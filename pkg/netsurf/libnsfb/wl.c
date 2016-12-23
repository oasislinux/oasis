#include <fcntl.h>
#include <linux/input.h>
#include <linux/memfd.h>
#include <poll.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <sys/param.h>
#include <sys/syscall.h>
#include <time.h>
#include <unistd.h>
#include <wayland-client.h>
#include <xdg-shell-unstable-v5-client-protocol.h>
#include <xkbcommon/xkbcommon.h>

#include "libnsfb.h"
#include "libnsfb_event.h"

#include "nsfb.h"
#include "surface.h"
#include "plot.h"

struct wlevent {
	struct wlevent *next;
	nsfb_event_t event;
};

struct format {
	uint32_t wl;
	enum nsfb_format_e ns;
};

struct wlimage {
	void *data;
	int width, height, stride, size;
	enum nsfb_format_e format;
	struct wl_shm_pool *pool;
	struct wl_buffer *buffer;
};

struct wlstate {
	struct wl_display *display;
	struct wl_registry *registry;
	struct wl_compositor *compositor;
	struct wl_seat *seat;
	struct wl_shm *shm;
	struct wl_keyboard *keyboard;
	struct wl_pointer *pointer;

	struct wl_surface *surface;
	struct wlimage *image;

	struct xdg_shell *shell;
	struct xdg_surface *xdg_surface;

	struct wlevent *events, **events_end;

	struct format *formats;
	int num_formats;

	int nextwidth, nextheight;

	struct {
		struct xkb_context *ctx;
		struct xkb_state *state;
		struct xkb_keymap *map;
		xkb_mod_index_t ctrl, shift;
	} xkb;
	enum nsfb_mod_e mods;
	int buttons;

	struct {
		int delay, interval, last;
		bool started;
		xkb_keysym_t sym;
	} repeat;
};

static nsfb_event_t *
queue_event(struct wlstate *wl)
{
	struct wlevent *event;

	event = calloc(1, sizeof(*event));
	if (!event)
		return NULL;
	*wl->events_end = event;
	wl->events_end = &event->next;
	return &event->event;
}

static int
clocknow(void)
{
	struct timespec ts;

	if (clock_gettime(CLOCK_MONOTONIC, &ts) < 0)
		return -1;
	return ts.tv_sec * 1000 + ts.tv_nsec / 1e6;
}

static void
registry_global(void *data, struct wl_registry *reg, uint32_t name, const char *interface, uint32_t version)
{
	struct wlstate *wl = data;

	if (strcmp(interface, "wl_compositor") == 0) {
		wl->compositor = wl_registry_bind(reg, name, &wl_compositor_interface, MIN(version, 4));
	} else if (strcmp(interface, "wl_seat") == 0) {
		wl->seat = wl_registry_bind(reg, name, &wl_seat_interface, MIN(version, 4));
	} else if (strcmp(interface, "wl_shm") == 0) {
		wl->shm = wl_registry_bind(reg, name, &wl_shm_interface, MIN(version, 1));
	} else if (strcmp(interface, "xdg_shell") == 0) {
		wl->shell = wl_registry_bind(reg, name, &xdg_shell_interface, MIN(version, 1));
	}
}

static void
registry_global_remove(void *data, struct wl_registry *reg, uint32_t name)
{
}

static struct wl_registry_listener registry_listener = {
	.global = registry_global,
	.global_remove = registry_global_remove,
};

static void
shm_format(void *data, struct wl_shm *shm, uint32_t wlformat)
{
	struct wlstate *wl = data;
	enum nsfb_format_e nsformat;
	struct format *formats;

	switch (wlformat) {
	case WL_SHM_FORMAT_XBGR8888:
		nsformat = NSFB_FMT_XBGR8888;
		break;
	case WL_SHM_FORMAT_XRGB8888:
		nsformat = NSFB_FMT_XRGB8888;
		break;
	case WL_SHM_FORMAT_ABGR8888:
		nsformat = NSFB_FMT_ABGR8888;
		break;
	case WL_SHM_FORMAT_ARGB8888:
		nsformat = NSFB_FMT_ARGB8888;
		break;
	case WL_SHM_FORMAT_RGB888:
		nsformat = NSFB_FMT_RGB888;
		break;
	case WL_SHM_FORMAT_ARGB1555:
		nsformat = NSFB_FMT_ARGB1555;
		break;
	case WL_SHM_FORMAT_RGB565:
		nsformat = NSFB_FMT_RGB565;
		break;
	case WL_SHM_FORMAT_C8:
		nsformat = NSFB_FMT_I8;
		break;
	default:
		return;
	}

	formats = realloc(wl->formats, (wl->num_formats + 1) * sizeof(*wl->formats));
	if (formats == NULL)
		return;
	wl->formats = formats;
	wl->formats[wl->num_formats++] = (struct format){wlformat, nsformat};
}

static struct wl_shm_listener shm_listener = {
	.format = shm_format,
};

static void
keyboard_keymap(void *data, struct wl_keyboard *keyboard, uint32_t format, int32_t fd, uint32_t size)
{
	struct wlstate *wl = data;
	char *str;

	str = mmap(NULL, size, PROT_READ, MAP_SHARED, fd, 0);
	if (str == MAP_FAILED)
		return;

	xkb_keymap_unref(wl->xkb.map);
	wl->xkb.map = xkb_keymap_new_from_buffer(wl->xkb.ctx, str, size, XKB_KEYMAP_FORMAT_TEXT_V1, 0);
	if (wl->xkb.map == NULL)
		return;

	xkb_state_unref(wl->xkb.state);
	wl->xkb.state = xkb_state_new(wl->xkb.map);
	wl->xkb.ctrl = xkb_keymap_mod_get_index(wl->xkb.map, XKB_MOD_NAME_CTRL);
	wl->xkb.shift = xkb_keymap_mod_get_index(wl->xkb.map, XKB_MOD_NAME_SHIFT);
}

static void
keyboard_enter(void *data, struct wl_keyboard *keyboard, uint32_t serial , struct wl_surface *surface, struct wl_array *keys)
{
}

static void
keyboard_leave(void *data, struct wl_keyboard *keyboard, uint32_t serial, struct wl_surface *surface)
{
	struct wlstate *wl = data;

	wl->repeat.sym = XKB_KEY_NoSymbol;
}

static void
keyboard_key(void *data, struct wl_keyboard *keyboard, uint32_t serial, uint32_t time, uint32_t key, uint32_t state)
{
	struct wlstate *wl = data;
	xkb_keysym_t sym;
	nsfb_event_t *event;
	int now;

	if (!wl->xkb.state)
		return;

	sym = xkb_state_key_get_one_sym(wl->xkb.state, key + 8);

	event = queue_event(wl);
	if (!event)
		return;

	event->value.xkb.sym = sym;
	event->value.xkb.mod = wl->mods;
	if (state == WL_KEYBOARD_KEY_STATE_PRESSED) {
		event->type = NSFB_EVENT_XKB_KEY_DOWN;
		if (xkb_keymap_key_repeats(wl->xkb.map, key) && (now = clocknow()) >= 0) {
			wl->repeat.sym = sym;
			wl->repeat.started = false;
			wl->repeat.last = now;
		}
	} else {
		event->type = NSFB_EVENT_XKB_KEY_UP;
		if (sym == wl->repeat.sym)
			wl->repeat.sym = XKB_KEY_NoSymbol;
	}
}

static void
keyboard_modifiers(void *data, struct wl_keyboard *keyboard, uint32_t serial, uint32_t depressed, uint32_t latched, uint32_t locked, uint32_t group)
{
	struct wlstate *wl = data;

	xkb_state_update_mask(wl->xkb.state, depressed, latched, locked, group, 0, 0);

	wl->mods = 0;
	if (wl->xkb.ctrl != XKB_MOD_INVALID && xkb_state_mod_index_is_active(wl->xkb.state, wl->xkb.ctrl, XKB_STATE_MODS_EFFECTIVE))
		wl->mods |= NSFB_MOD_CTRL;
	if (wl->xkb.shift != XKB_MOD_INVALID && xkb_state_mod_index_is_active(wl->xkb.state, wl->xkb.shift, XKB_STATE_MODS_EFFECTIVE))
		wl->mods |= NSFB_MOD_SHIFT;
}

static void
keyboard_repeat_info(void *data, struct wl_keyboard *keyboard, int32_t rate, int32_t delay)
{
	struct wlstate *wl = data;

	wl->repeat.delay = delay;
	wl->repeat.interval = 1000 / rate;
}

static struct wl_keyboard_listener keyboard_listener = {
	.keymap = keyboard_keymap,
	.enter = keyboard_enter,
	.leave = keyboard_leave,
	.key = keyboard_key,
	.modifiers = keyboard_modifiers,
	.repeat_info = keyboard_repeat_info,
};

static void
pointer_enter(void *data, struct wl_pointer *pointer, uint32_t serial, struct wl_surface *surface, wl_fixed_t x, wl_fixed_t y)
{
	struct wlstate *wl = data;
	nsfb_event_t *event;

	event = queue_event(wl);
	if (!event)
		return;

	event->type = NSFB_EVENT_MOVE_ABSOLUTE;
	event->value.vector.x = wl_fixed_to_int(x);
	event->value.vector.y = wl_fixed_to_int(y);
}

static void
pointer_leave(void *data, struct wl_pointer *pointer, uint32_t serial, struct wl_surface *surface)
{
	struct wlstate *wl = data;
	int i;
	nsfb_event_t *event;

	for (i = 0; i < 3; ++i) {
		if (!(wl->buttons & (1 << i)))
			continue;
		event = queue_event(wl);
		if (!event)
			break;
		event->type = NSFB_EVENT_KEY_UP;
		switch (i) {
		case 0:
			event->value.keycode = NSFB_KEY_MOUSE_1;
			break;
		case 1:
			event->value.keycode = NSFB_KEY_MOUSE_2;
			break;
		case 2:
			event->value.keycode = NSFB_KEY_MOUSE_3;
			break;
		}
	}
	wl->buttons = 0;
}

static void
pointer_motion(void *data, struct wl_pointer *pointer, uint32_t time, wl_fixed_t x, wl_fixed_t y)
{
	struct wlstate *wl = data;
	nsfb_event_t *event;

	event = queue_event(wl);
	if (!event)
		return;

	event->type = NSFB_EVENT_MOVE_ABSOLUTE;
	event->value.vector.x = wl_fixed_to_int(x);
	event->value.vector.y = wl_fixed_to_int(y);
}

static void
pointer_button(void *data, struct wl_pointer *pointer, uint32_t serial, uint32_t time, uint32_t button, uint32_t state)
{
	struct wlstate *wl = data;
	enum nsfb_key_code_e code;
	nsfb_event_t *event;
	int num;

	switch (button) {
	case BTN_LEFT:
		code = NSFB_KEY_MOUSE_1;
		num = 0;
		break;
	case BTN_MIDDLE:
		code = NSFB_KEY_MOUSE_2;
		num = 1;
		break;
	case BTN_RIGHT:
		code = NSFB_KEY_MOUSE_3;
		num = 2;
		break;
	default:
		return;
	}
	if (state == WL_POINTER_BUTTON_STATE_PRESSED)
		wl->buttons |= 1 << num;
	else
		wl->buttons &= ~(1 << num);

	event = queue_event(wl);
	if (!event)
		return;
	if (state == WL_POINTER_BUTTON_STATE_PRESSED)
		event->type = NSFB_EVENT_KEY_DOWN;
	else
		event->type = NSFB_EVENT_KEY_UP;
	event->value.keycode = code;
}

static void
pointer_axis(void *data, struct wl_pointer *pointer, uint32_t time, uint32_t axis, wl_fixed_t value)
{
	struct wlstate *wl = data;
	nsfb_event_t *event;
	enum nsfb_key_code_e code;
	int n = wl_fixed_to_int(value) / 10;

	if (axis != WL_POINTER_AXIS_VERTICAL_SCROLL)
		return;

	if (n > 0) {
		code = NSFB_KEY_MOUSE_5;
	} else {
		code = NSFB_KEY_MOUSE_4;
		n = -n;
	}

	for (; n; --n) {
		event = queue_event(wl);
		if (!event)
			return;
		event->type = NSFB_EVENT_KEY_DOWN;
		event->value.keycode = code;
	}
}

static struct wl_pointer_listener pointer_listener = {
	.enter = pointer_enter,
	.leave = pointer_leave,
	.motion = pointer_motion,
	.button = pointer_button,
	.axis = pointer_axis,
};

static void
seat_capabilities(void *data, struct wl_seat *seat, uint32_t capabilities)
{
	struct wlstate *wl = data;

	if (capabilities & WL_SEAT_CAPABILITY_KEYBOARD && !wl->keyboard) {
		wl->keyboard = wl_seat_get_keyboard(wl->seat);
		if (wl->keyboard != NULL)
			wl_keyboard_add_listener(wl->keyboard, &keyboard_listener, wl);
	}
	if (capabilities & WL_SEAT_CAPABILITY_POINTER && !wl->pointer) {
		wl->pointer = wl_seat_get_pointer(wl->seat);
		if (wl->pointer != NULL)
			wl_pointer_add_listener(wl->pointer, &pointer_listener, wl);
	}
}

static void
seat_name(void *data, struct wl_seat *seat, const char *name)
{
}

static struct wl_seat_listener seat_listener = {
	.capabilities = seat_capabilities,
	.name = seat_name,
};

static void
shell_ping(void *data, struct xdg_shell *shell, uint32_t serial)
{
	xdg_shell_pong(shell, serial);
}

static struct xdg_shell_listener shell_listener = {
	.ping = shell_ping,
};

static void
xdg_surface_configure(void *data, struct xdg_surface *xdg_surface, int32_t width, int32_t height, struct wl_array *states, uint32_t serial)
{
	struct wlstate *wl = data;

	if (width)
		wl->nextwidth = width;
	if (height)
		wl->nextheight = height;
	xdg_surface_ack_configure(xdg_surface, serial);
}

static void
xdg_surface_close(void *data, struct xdg_surface *xdg_surface)
{
	struct wlstate *wl = data;
	nsfb_event_t *event;

	event = queue_event(wl);
	if (!event)
		return;
	event->type = NSFB_EVENT_CONTROL;
	event->value.controlcode = NSFB_CONTROL_QUIT;
}

static struct xdg_surface_listener xdg_surface_listener = {
	.configure = xdg_surface_configure,
	.close = xdg_surface_close,
};

static int
format_index(struct wlstate *wl, enum nsfb_format_e format)
{
	int i;

	for (i = 0; i < wl->num_formats; ++i) {
		if (wl->formats[i].ns == format)
			return i;
	}
	return -1;
}

static struct wlimage *
create_image(struct wlstate *wl, int w, int h, uint32_t format, int bpp)
{
	struct wlimage *i;
	int fd;

	i = calloc(1, sizeof(*i));
	if (i == NULL)
		goto err0;
	i->width = w;
	i->height = h;
	i->stride = w * bpp;
	i->size = h * i->stride;
	fd = syscall(SYS_memfd_create, "nsfb", 0);
	if (fd < 0)
		goto err1;
	if (posix_fallocate(fd, 0, i->size) < 0)
		goto err2;
	i->data = mmap(NULL, i->size, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (i->data == MAP_FAILED)
		goto err2;
	i->pool = wl_shm_create_pool(wl->shm, fd, i->size);
	if (i->pool == NULL)
		goto err3;
	i->buffer = wl_shm_pool_create_buffer(i->pool, 0, w, h, i->stride, format);
	if (i->buffer == NULL)
		goto err4;

	close(fd);
	return i;

err4:
	wl_shm_pool_destroy(i->pool);
err3:
	munmap(i->data, i->size);
err2:
	close(fd);
err1:
	free(i);
err0:
	return NULL;
}

static void
destroy_image(struct wlimage *i)
{
	wl_buffer_destroy(i->buffer);
	wl_shm_pool_destroy(i->pool);
	munmap(i->data, i->size);
	free(i);
}

static int
wayland_geometry(nsfb_t *nsfb, int width, int height, enum nsfb_format_e nsformat)
{
	struct wlstate *wl = nsfb->surface_priv;
	uint32_t wlformat;
	int i;

	if (!wl)
		return 0;

	if (width)
		nsfb->width = width;
	if (height)
		nsfb->height = height;
	if (nsformat != NSFB_FMT_ANY)
		nsfb->format = nsformat;

	select_plotters(nsfb);

	for (i = 0; i < wl->num_formats; ++i) {
		if (wl->formats[i].ns == nsfb->format) {
			wlformat = wl->formats[i].wl;
			break;
		}
	}
	if (i == wl->num_formats)
		return -1;

	if (wl->image)
		destroy_image(wl->image);
	wl->image = create_image(wl, width, height, wlformat, nsfb->bpp);
	if (wl->image == NULL)
		return -1;
	nsfb->ptr = wl->image->data;
	nsfb->linelen = wl->image->stride;
	wl_surface_attach(wl->surface, wl->image->buffer, 0, 0);

	return 0;
}

static int
wayland_initialise(nsfb_t *nsfb)
{
	struct wlstate *wl = nsfb->surface_priv;

	if (wl != NULL)
		return -1;

	wl = calloc(1, sizeof(*wl));
	if (wl == NULL)
		return -1;
	wl->xkb.ctx = xkb_context_new(0);
	if (!wl->xkb.ctx)
		return -1;

	wl->events_end = &wl->events;
	wl->nextwidth = nsfb->width;
	wl->nextheight = nsfb->height;
	wl->repeat.delay = 500;
	wl->repeat.interval = 25;

	wl->display = wl_display_connect(NULL);
	if (!wl->display) {
		free(wl);
		return -1;
	}

	wl->registry = wl_display_get_registry(wl->display);
	if (!wl->registry) {
		wl_display_disconnect(wl->display);
		free(wl);
		return -1;
	}
	wl_registry_add_listener(wl->registry, &registry_listener, wl);

	wl_display_roundtrip(wl->display);

	if (!wl->compositor || !wl->seat || !wl->shm || !wl->shell) {
		fprintf(stderr, "display is missing required globals\n");
		wl_display_disconnect(wl->display);
		free(wl);
		return -1;
	}

	wl_seat_add_listener(wl->seat, &seat_listener, wl);
	wl_shm_add_listener(wl->shm, &shm_listener, wl);
	xdg_shell_use_unstable_version(wl->shell, XDG_SHELL_VERSION_CURRENT);
	xdg_shell_add_listener(wl->shell, &shell_listener, NULL);

	wl->surface = wl_compositor_create_surface(wl->compositor);
	if (!wl->surface)
		return -1;

	wl->xdg_surface = xdg_shell_get_xdg_surface(wl->shell, wl->surface);
	if (!wl->xdg_surface)
		return -1;
	xdg_surface_add_listener(wl->xdg_surface, &xdg_surface_listener, wl);
	wl_display_roundtrip(wl->display);

	nsfb->surface_priv = wl;
	if (wayland_geometry(nsfb, wl->nextwidth, wl->nextheight, nsfb->format) < 0)
		return -1;

	return 0;
}

static int
wayland_finalise(nsfb_t *nsfb)
{
	struct wlstate *wl = nsfb->surface_priv;
	struct wlevent *event;

	if (wl == NULL)
		return 0;

	xdg_surface_destroy(wl->xdg_surface);
	xdg_shell_destroy(wl->shell);
	wl_surface_destroy(wl->surface);
	if (wl->keyboard) {
		if (wl_keyboard_get_version(wl->keyboard) >= WL_KEYBOARD_RELEASE_SINCE_VERSION)
			wl_keyboard_release(wl->keyboard);
		else
			wl_keyboard_destroy(wl->keyboard);
	}
	if (wl->pointer) {
		if (wl_pointer_get_version(wl->pointer) >= WL_POINTER_RELEASE_SINCE_VERSION)
			wl_pointer_release(wl->pointer);
		else
			wl_pointer_destroy(wl->pointer);
	}
	wl_seat_destroy(wl->seat);
	wl_shm_destroy(wl->shm);
	wl_compositor_destroy(wl->compositor);
	wl_registry_destroy(wl->registry);

	xkb_state_unref(wl->xkb.state);
	xkb_keymap_unref(wl->xkb.map);
	xkb_context_unref(wl->xkb.ctx);

	while (wl->events) {
		event = wl->events;
		wl->events = event->next;
		free(event);
	}
	free(wl->formats);
	free(wl);

	return 0;
}

static bool
wayland_input(nsfb_t *nsfb, nsfb_event_t *event, int timeout)
{
	nsfb_event_t *resize;
	struct wlstate *wl = nsfb->surface_priv;
	struct pollfd fd;
	int ret, now, delay, left;
	bool dorepeat = false;

	if (wl == NULL)
		return false;

	wl_display_dispatch_pending(wl->display);
	wl_display_flush(wl->display);

	if (wl->events != NULL)
		goto nextevent;

	if (wl->repeat.sym != XKB_KEY_NoSymbol) {
		now = clocknow();
		if (now >= 0) {
			delay = wl->repeat.started ? wl->repeat.interval : wl->repeat.delay;
			left = delay - (now - wl->repeat.last);
			if (left <= 0)
				goto keyrepeat;
			if (left <= timeout) {
				timeout = left;
				dorepeat = true;
			}
		}
	}

	if (timeout >= 0) {
		fd.fd = wl_display_get_fd(wl->display);
		fd.events = POLLIN;
		ret = poll(&fd, 1, timeout);
		if (ret == 0) {
			if (dorepeat) {
keyrepeat:
				wl->repeat.last = now;
				wl->repeat.started = true;
				event->type = NSFB_EVENT_XKB_KEY_DOWN;
				event->value.xkb.sym = wl->repeat.sym;
			} else {
				event->type = NSFB_EVENT_CONTROL;
				event->value.controlcode = NSFB_CONTROL_TIMEOUT;
			}
			return true;
		}
	}

	if (wl_display_dispatch(wl->display) == -1) {
		event->type = NSFB_EVENT_CONTROL;
		event->value.controlcode = NSFB_CONTROL_QUIT;
		return true;
	}

	if (wl->nextwidth != nsfb->width || wl->nextheight != nsfb->height) {
		resize = queue_event(wl);
		if (resize) {
			resize->type = NSFB_EVENT_RESIZE;
			resize->value.resize.w = wl->nextwidth;
			resize->value.resize.h = wl->nextheight;
		}
	}

	if (wl->events == NULL)
		return false;

nextevent:
	*event = wl->events->event;
	if (wl->events_end == &wl->events->next)
		wl->events_end = &wl->events;
	wl->events = wl->events->next;

	return true;
}

static int
wayland_update(nsfb_t *nsfb, nsfb_bbox_t *box)
{
	struct wlstate *wl = nsfb->surface_priv;

	if (!wl)
		return 0;

	wl_surface_damage(wl->surface, box->x0, box->y0, box->x1 - box->x0, box->y1 - box->y0);
	wl_surface_commit(wl->surface);
	return 0;
}

const nsfb_surface_rtns_t wayland_rtns = {
	.initialise = wayland_initialise,
	.finalise = wayland_finalise,
	.input = wayland_input,
	.update = wayland_update,
	.geometry = wayland_geometry,
};

NSFB_SURFACE_DEF(wayland, NSFB_SURFACE_WL, &wayland_rtns)

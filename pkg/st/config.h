/* See LICENSE file for copyright and license details. */

/*
 * appearance
 *
 * font: see http://freedesktop.org/software/fontconfig/fontconfig-user.html
 */
static char font[] = "Terminus:pixelsize=14";
static int borderpx = 2;

/*
 * What program is execed by st depends of these precedence rules:
 * 1: program passed with -e
 * 2: utmp option
 * 3: SHELL environment variable
 * 4: value of shell in /etc/passwd
 * 5: value of shell in config.h
 */
static char shell[] = "/bin/sh";
static char *utmp = NULL;
static char stty_args[] = "stty raw pass8 nl -echo -iexten -cstopb 38400";

/* identification sequence returned in DA and DECID */
static char vtiden[] = "\033[?6c";

/* Kerning / character bounding-box multipliers */
static float cwscale = 1.0;
static float chscale = 1.0;

/*
 * word delimiter string
 *
 * More advanced example: " `'\"()[]{}"
 */
static char worddelimiters[] = " ";

/* selection timeouts (in milliseconds) */
static unsigned int doubleclicktimeout = 300;
static unsigned int tripleclicktimeout = 600;

/* key repeat timeouts (in milliseconds) */
static unsigned int keyrepeatdelay = 500;
static unsigned int keyrepeatinterval = 25;

/* alt screens */
static int allowaltscreen = 1;

/*
 * blinking timeout (set to 0 to disable blinking) for the terminal blinking
 * attribute.
 */
static unsigned int blinktimeout = 800;

/*
 * thickness of underline and bar cursors
 */
static unsigned int cursorthickness = 2;

/*
 * bell volume. It must be a value between -100 and 100. Use 0 for disabling
 * it
 */
/* XXX: Wayland does not have a bell.
 * static int bellvolume = 0;
 */

/* default TERM value */
static char termname[] = "st-256color";

/*
 * spaces per tab
 *
 * When you are changing this value, don't forget to adapt the »it« value in
 * the st.info and appropriately install the st.info in the environment where
 * you use this st version.
 *
 *	it#$tabspaces,
 *
 * Secondly make sure your kernel is not expanding tabs. When running `stty
 * -a` »tab0« should appear. You can tell the terminal to not expand tabs by
 *  running following command:
 *
 *	stty tabs
 */
static unsigned int tabspaces = 8;

/* Terminal colors (16 first used in escape sequence) */
static const char *colorname[] = {
	/* 8 normal colors */
	"#000000",
	"#a40000",
	"#4e9a06",
	"#c4a000",
	"#204a87",
	"#ce5c00",
	"#038e82",
	"#eaede6",

	/* 8 bright colors */
	"#555753",
	"#cc0000",
	"#73d216",
	"#edd400",
	"#3465a4",
	"#f57900",
	"#05d2c1",
	"#ffffff",

	[255] = 0,

	/* more colors can be added after 255 to use with DefaultXX */
	"#cccccc",
	"#555555",

	/* background */
	"#000000",

	/* foreground */
	"#babdb6"
};


/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
static unsigned int defaultfg = 259;
static unsigned int defaultbg = 258;
static unsigned int defaultcs = 256;
static unsigned int defaultrcs = 257;

/*
 * Default shape of cursor
 * 2: Block ("█")
 * 4: Underline ("_")
 * 6: Bar ("|")
 * 7: Snowman ("☃")
 */
static unsigned int cursorshape = 2;

/*
 * Default columns and rows numbers
 */

static unsigned int cols = 80;
static unsigned int rows = 24;

/*
 * Default shape of the mouse cursor
 */
static char mouseshape[] = "xterm";

/*
 * Color used to display font attributes when fontconfig selected a font which
 * doesn't match the ones requested.
 */
static unsigned int defaultattr = 11;

/*
 * Internal mouse shortcuts.
 * Beware that overloading Button1 will disable the selection.
 */
static MouseShortcut mshortcuts[] = {
	/* button               mask            string */
	{ -1,                   MOD_MASK_NONE,  "" }
};

static Axiskey ashortcuts[] = {
	/* axis		    direction	mask		string */
	{ AXIS_VERTICAL,    +1,		MOD_MASK_ANY,	"\031"},
	{ AXIS_VERTICAL,    -1,		MOD_MASK_ANY,	"\005"},
};

/* Internal keyboard shortcuts. */
#define MODKEY MOD_MASK_ALT

static Shortcut shortcuts[] = {
	/* modifier                     key                     function        argument */
	{ MOD_MASK_ANY,                 XKB_KEY_Break,          sendbreak,      {.i =  0} },
	{ MOD_MASK_CTRL,                XKB_KEY_Print,          toggleprinter,  {.i =  0} },
	{ MOD_MASK_SHIFT,               XKB_KEY_Print,          printscreen,    {.i =  0} },
	{ MOD_MASK_ANY,                 XKB_KEY_Print,          printsel,       {.i =  0} },
	{ MODKEY|MOD_MASK_SHIFT,        XKB_KEY_Prior,          wlzoom,         {.f = +1} },
	{ MODKEY|MOD_MASK_SHIFT,        XKB_KEY_Next,           wlzoom,         {.f = -1} },
	{ MODKEY|MOD_MASK_SHIFT,        XKB_KEY_Home,           wlzoomreset,    {.f =  0} },
	{ MOD_MASK_SHIFT,               XKB_KEY_Insert,         selpaste,       {.i =  0} },
	{ MODKEY,                       XKB_KEY_Num_Lock,       numlock,        {.i =  0} },
	{ MODKEY,                       XKB_KEY_Control_L,      iso14755,       {.i =  0} },
};

/*
 * Special keys (change & recompile st.info accordingly)
 *
 * Mask value:
 * * Use MOD_MASK_ANY to match the key no matter modifiers state
 * * Use MOD_MASK_NONE to match the key alone (no modifiers)
 * appkey value:
 * * 0: no value
 * * > 0: keypad application mode enabled
 * *   = 2: term.numlock = 1
 * * < 0: keypad application mode disabled
 * appcursor value:
 * * 0: no value
 * * > 0: cursor application mode enabled
 * * < 0: cursor application mode disabled
 * crlf value
 * * 0: no value
 * * > 0: crlf mode is enabled
 * * < 0: crlf mode is disabled
 *
 * Be careful with the order of the definitions because st searches in
 * this table sequentially, so any MOD_MASK_ANY must be in the last
 * position for a key.
 */

/*
 * If you want keys other than the X11 function keys (0xFD00 - 0xFFFF)
 * to be mapped below, add them to this array.
 */
static xkb_keysym_t mappedkeys[] = { -1 };

/* State bits to ignore when matching key or button events. */
static uint ignoremod = 0;

/*
 * Override mouse-select while mask is active (when MODE_MOUSE is set).
 * Note that if you want to use MOD_MASK_SHIFT with selmasks, set this to an
 * other modifier, set to 0 to not use it.
 */
static uint forceselmod = MOD_MASK_SHIFT;

/*
 * This is the huge key array which defines all compatibility to the Linux
 * world. Please decide about changes wisely.
 */
static Key key[] = {
	/* keysym                mask             string      appkey appcursor crlf */
	{ XKB_KEY_KP_Home,       MOD_MASK_SHIFT,  "\033[2J",       0,   -1,    0},
	{ XKB_KEY_KP_Home,       MOD_MASK_SHIFT,  "\033[1;2H",     0,   +1,    0},
	{ XKB_KEY_KP_Home,       MOD_MASK_ANY,    "\033[H",        0,   -1,    0},
	{ XKB_KEY_KP_Home,       MOD_MASK_ANY,    "\033[1~",       0,   +1,    0},
	{ XKB_KEY_KP_Up,         MOD_MASK_ANY,    "\033Ox",       +1,    0,    0},
	{ XKB_KEY_KP_Up,         MOD_MASK_ANY,    "\033[A",        0,   -1,    0},
	{ XKB_KEY_KP_Up,         MOD_MASK_ANY,    "\033OA",        0,   +1,    0},
	{ XKB_KEY_KP_Down,       MOD_MASK_ANY,    "\033Or",       +1,    0,    0},
	{ XKB_KEY_KP_Down,       MOD_MASK_ANY,    "\033[B",        0,   -1,    0},
	{ XKB_KEY_KP_Down,       MOD_MASK_ANY,    "\033OB",        0,   +1,    0},
	{ XKB_KEY_KP_Left,       MOD_MASK_ANY,    "\033Ot",       +1,    0,    0},
	{ XKB_KEY_KP_Left,       MOD_MASK_ANY,    "\033[D",        0,   -1,    0},
	{ XKB_KEY_KP_Left,       MOD_MASK_ANY,    "\033OD",        0,   +1,    0},
	{ XKB_KEY_KP_Right,      MOD_MASK_ANY,    "\033Ov",       +1,    0,    0},
	{ XKB_KEY_KP_Right,      MOD_MASK_ANY,    "\033[C",        0,   -1,    0},
	{ XKB_KEY_KP_Right,      MOD_MASK_ANY,    "\033OC",        0,   +1,    0},
	{ XKB_KEY_KP_Prior,      MOD_MASK_SHIFT,  "\033[5;2~",     0,    0,    0},
	{ XKB_KEY_KP_Prior,      MOD_MASK_ANY,    "\033[5~",       0,    0,    0},
	{ XKB_KEY_KP_Begin,      MOD_MASK_ANY,    "\033[E",        0,    0,    0},
	{ XKB_KEY_KP_End,        MOD_MASK_CTRL,   "\033[J",       -1,    0,    0},
	{ XKB_KEY_KP_End,        MOD_MASK_CTRL,   "\033[1;5F",    +1,    0,    0},
	{ XKB_KEY_KP_End,        MOD_MASK_SHIFT,  "\033[K",       -1,    0,    0},
	{ XKB_KEY_KP_End,        MOD_MASK_SHIFT,  "\033[1;2F",    +1,    0,    0},
	{ XKB_KEY_KP_End,        MOD_MASK_ANY,    "\033[4~",       0,    0,    0},
	{ XKB_KEY_KP_Next,       MOD_MASK_SHIFT,  "\033[6;2~",     0,    0,    0},
	{ XKB_KEY_KP_Next,       MOD_MASK_ANY,    "\033[6~",       0,    0,    0},
	{ XKB_KEY_KP_Insert,     MOD_MASK_SHIFT,  "\033[2;2~",    +1,    0,    0},
	{ XKB_KEY_KP_Insert,     MOD_MASK_SHIFT,  "\033[4l",      -1,    0,    0},
	{ XKB_KEY_KP_Insert,     MOD_MASK_CTRL,   "\033[L",       -1,    0,    0},
	{ XKB_KEY_KP_Insert,     MOD_MASK_CTRL,   "\033[2;5~",    +1,    0,    0},
	{ XKB_KEY_KP_Insert,     MOD_MASK_ANY,    "\033[4h",      -1,    0,    0},
	{ XKB_KEY_KP_Insert,     MOD_MASK_ANY,    "\033[2~",      +1,    0,    0},
	{ XKB_KEY_KP_Delete,     MOD_MASK_CTRL,   "\033[M",       -1,    0,    0},
	{ XKB_KEY_KP_Delete,     MOD_MASK_CTRL,   "\033[3;5~",    +1,    0,    0},
	{ XKB_KEY_KP_Delete,     MOD_MASK_SHIFT,  "\033[2K",      -1,    0,    0},
	{ XKB_KEY_KP_Delete,     MOD_MASK_SHIFT,  "\033[3;2~",    +1,    0,    0},
	{ XKB_KEY_KP_Delete,     MOD_MASK_ANY,    "\033[P",       -1,    0,    0},
	{ XKB_KEY_KP_Delete,     MOD_MASK_ANY,    "\033[3~",      +1,    0,    0},
	{ XKB_KEY_KP_Multiply,   MOD_MASK_ANY,    "\033Oj",       +2,    0,    0},
	{ XKB_KEY_KP_Add,        MOD_MASK_ANY,    "\033Ok",       +2,    0,    0},
	{ XKB_KEY_KP_Enter,      MOD_MASK_ANY,    "\033OM",       +2,    0,    0},
	{ XKB_KEY_KP_Enter,      MOD_MASK_ANY,    "\r",           -1,    0,   -1},
	{ XKB_KEY_KP_Enter,      MOD_MASK_ANY,    "\r\n",         -1,    0,   +1},
	{ XKB_KEY_KP_Subtract,   MOD_MASK_ANY,    "\033Om",       +2,    0,    0},
	{ XKB_KEY_KP_Decimal,    MOD_MASK_ANY,    "\033On",       +2,    0,    0},
	{ XKB_KEY_KP_Divide,     MOD_MASK_ANY,    "\033Oo",       +2,    0,    0},
	{ XKB_KEY_KP_0,          MOD_MASK_ANY,    "\033Op",       +2,    0,    0},
	{ XKB_KEY_KP_1,          MOD_MASK_ANY,    "\033Oq",       +2,    0,    0},
	{ XKB_KEY_KP_2,          MOD_MASK_ANY,    "\033Or",       +2,    0,    0},
	{ XKB_KEY_KP_3,          MOD_MASK_ANY,    "\033Os",       +2,    0,    0},
	{ XKB_KEY_KP_4,          MOD_MASK_ANY,    "\033Ot",       +2,    0,    0},
	{ XKB_KEY_KP_5,          MOD_MASK_ANY,    "\033Ou",       +2,    0,    0},
	{ XKB_KEY_KP_6,          MOD_MASK_ANY,    "\033Ov",       +2,    0,    0},
	{ XKB_KEY_KP_7,          MOD_MASK_ANY,    "\033Ow",       +2,    0,    0},
	{ XKB_KEY_KP_8,          MOD_MASK_ANY,    "\033Ox",       +2,    0,    0},
	{ XKB_KEY_KP_9,          MOD_MASK_ANY,    "\033Oy",       +2,    0,    0},
	{ XKB_KEY_Up,            MOD_MASK_SHIFT,  "\033[1;2A",     0,    0,    0},
	{ XKB_KEY_Up,            MOD_MASK_ALT,    "\033[1;3A",     0,    0,    0},
	{ XKB_KEY_Up, MOD_MASK_SHIFT|MOD_MASK_ALT,"\033[1;4A",     0,    0,    0},
	{ XKB_KEY_Up,            MOD_MASK_CTRL,   "\033[1;5A",     0,    0,    0},
	{ XKB_KEY_Up,MOD_MASK_SHIFT|MOD_MASK_CTRL,"\033[1;6A",     0,    0,    0},
	{ XKB_KEY_Up,  MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;7A",     0,    0,    0},
	{ XKB_KEY_Up,MOD_MASK_SHIFT|MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;8A",0,0,0},
	{ XKB_KEY_Up,            MOD_MASK_ANY,    "\033[A",        0,   -1,    0},
	{ XKB_KEY_Up,            MOD_MASK_ANY,    "\033OA",        0,   +1,    0},
	{ XKB_KEY_Down,          MOD_MASK_SHIFT,  "\033[1;2B",     0,    0,    0},
	{ XKB_KEY_Down,          MOD_MASK_ALT,    "\033[1;3B",     0,    0,    0},
	{ XKB_KEY_Down,MOD_MASK_SHIFT|MOD_MASK_ALT,"\033[1;4B",    0,    0,    0},
	{ XKB_KEY_Down,         MOD_MASK_CTRL,    "\033[1;5B",     0,    0,    0},
	{ XKB_KEY_Down,MOD_MASK_SHIFT|MOD_MASK_CTRL,"\033[1;6B",   0,    0,    0},
	{ XKB_KEY_Down,MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;7B",     0,    0,    0},
	{ XKB_KEY_Down,MOD_MASK_SHIFT|MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;8B",0,0,0},
	{ XKB_KEY_Down,          MOD_MASK_ANY,    "\033[B",        0,   -1,    0},
	{ XKB_KEY_Down,          MOD_MASK_ANY,    "\033OB",        0,   +1,    0},
	{ XKB_KEY_Left,          MOD_MASK_SHIFT,  "\033[1;2D",     0,    0,    0},
	{ XKB_KEY_Left,          MOD_MASK_ALT,    "\033[1;3D",     0,    0,    0},
	{ XKB_KEY_Left,MOD_MASK_SHIFT|MOD_MASK_ALT,"\033[1;4D",    0,    0,    0},
	{ XKB_KEY_Left,          MOD_MASK_CTRL,   "\033[1;5D",     0,    0,    0},
	{ XKB_KEY_Left,MOD_MASK_SHIFT|MOD_MASK_CTRL,"\033[1;6D",   0,    0,    0},
	{ XKB_KEY_Left,MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;7D",     0,    0,    0},
	{ XKB_KEY_Left,MOD_MASK_SHIFT|MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;8D",0,0,0},
	{ XKB_KEY_Left,          MOD_MASK_ANY,    "\033[D",        0,   -1,    0},
	{ XKB_KEY_Left,          MOD_MASK_ANY,    "\033OD",        0,   +1,    0},
	{ XKB_KEY_Right,         MOD_MASK_SHIFT,  "\033[1;2C",     0,    0,    0},
	{ XKB_KEY_Right,         MOD_MASK_ALT,    "\033[1;3C",     0,    0,    0},
	{ XKB_KEY_Right,MOD_MASK_SHIFT|MOD_MASK_ALT,"\033[1;4C",   0,    0,    0},
	{ XKB_KEY_Right,         MOD_MASK_CTRL,   "\033[1;5C",     0,    0,    0},
	{ XKB_KEY_Right,MOD_MASK_SHIFT|MOD_MASK_CTRL,"\033[1;6C",  0,    0,    0},
	{ XKB_KEY_Right,MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;7C",    0,    0,    0},
	{ XKB_KEY_Right,MOD_MASK_SHIFT|MOD_MASK_CTRL|MOD_MASK_ALT,"\033[1;8C",0,0,0},
	{ XKB_KEY_Right,         MOD_MASK_ANY,    "\033[C",        0,   -1,    0},
	{ XKB_KEY_Right,         MOD_MASK_ANY,    "\033OC",        0,   +1,    0},
	{ XKB_KEY_ISO_Left_Tab,  MOD_MASK_SHIFT,  "\033[Z",        0,    0,    0},
	{ XKB_KEY_Return,        MOD_MASK_ALT,    "\033\r",        0,    0,   -1},
	{ XKB_KEY_Return,        MOD_MASK_ALT,    "\033\r\n",      0,    0,   +1},
	{ XKB_KEY_Return,        MOD_MASK_ANY,    "\r",            0,    0,   -1},
	{ XKB_KEY_Return,        MOD_MASK_ANY,    "\r\n",          0,    0,   +1},
	{ XKB_KEY_Insert,        MOD_MASK_SHIFT,  "\033[4l",      -1,    0,    0},
	{ XKB_KEY_Insert,        MOD_MASK_SHIFT,  "\033[2;2~",    +1,    0,    0},
	{ XKB_KEY_Insert,        MOD_MASK_CTRL,   "\033[L",       -1,    0,    0},
	{ XKB_KEY_Insert,        MOD_MASK_CTRL,   "\033[2;5~",    +1,    0,    0},
	{ XKB_KEY_Insert,        MOD_MASK_ANY,    "\033[4h",      -1,    0,    0},
	{ XKB_KEY_Insert,        MOD_MASK_ANY,    "\033[2~",      +1,    0,    0},
	{ XKB_KEY_Delete,        MOD_MASK_CTRL,   "\033[M",       -1,    0,    0},
	{ XKB_KEY_Delete,        MOD_MASK_CTRL,   "\033[3;5~",    +1,    0,    0},
	{ XKB_KEY_Delete,        MOD_MASK_SHIFT,  "\033[2K",      -1,    0,    0},
	{ XKB_KEY_Delete,        MOD_MASK_SHIFT,  "\033[3;2~",    +1,    0,    0},
	{ XKB_KEY_Delete,        MOD_MASK_ANY,    "\033[P",       -1,    0,    0},
	{ XKB_KEY_Delete,        MOD_MASK_ANY,    "\033[3~",      +1,    0,    0},
	{ XKB_KEY_BackSpace,     MOD_MASK_NONE,   "\177",          0,    0,    0},
	{ XKB_KEY_BackSpace,     MOD_MASK_CTRL,   "\033\177",      0,    0,    0},
	{ XKB_KEY_Home,          MOD_MASK_SHIFT,  "\033[2J",       0,   -1,    0},
	{ XKB_KEY_Home,          MOD_MASK_SHIFT,  "\033[1;2H",     0,   +1,    0},
	{ XKB_KEY_Home,          MOD_MASK_ANY,    "\033[H",        0,   -1,    0},
	{ XKB_KEY_Home,          MOD_MASK_ANY,    "\033[1~",       0,   +1,    0},
	{ XKB_KEY_End,           MOD_MASK_CTRL,   "\033[J",       -1,    0,    0},
	{ XKB_KEY_End,           MOD_MASK_CTRL,   "\033[1;5F",    +1,    0,    0},
	{ XKB_KEY_End,           MOD_MASK_SHIFT,  "\033[K",       -1,    0,    0},
	{ XKB_KEY_End,           MOD_MASK_SHIFT,  "\033[1;2F",    +1,    0,    0},
	{ XKB_KEY_End,           MOD_MASK_ANY,    "\033[4~",       0,    0,    0},
	{ XKB_KEY_Prior,         MOD_MASK_CTRL,   "\033[5;5~",     0,    0,    0},
	{ XKB_KEY_Prior,         MOD_MASK_SHIFT,  "\033[5;2~",     0,    0,    0},
	{ XKB_KEY_Prior,         MOD_MASK_ANY,    "\033[5~",       0,    0,    0},
	{ XKB_KEY_Next,          MOD_MASK_CTRL,   "\033[6;5~",     0,    0,    0},
	{ XKB_KEY_Next,          MOD_MASK_SHIFT,  "\033[6;2~",     0,    0,    0},
	{ XKB_KEY_Next,          MOD_MASK_ANY,    "\033[6~",       0,    0,    0},
	{ XKB_KEY_F1,            MOD_MASK_NONE,   "\033OP" ,       0,    0,    0},
	{ XKB_KEY_F1, /* F13 */  MOD_MASK_SHIFT,  "\033[1;2P",     0,    0,    0},
	{ XKB_KEY_F1, /* F25 */  MOD_MASK_CTRL,   "\033[1;5P",     0,    0,    0},
	{ XKB_KEY_F1, /* F37 */  MOD_MASK_LOGO,   "\033[1;6P",     0,    0,    0},
	{ XKB_KEY_F1, /* F49 */  MOD_MASK_ALT,    "\033[1;3P",     0,    0,    0},
	{ XKB_KEY_F2,            MOD_MASK_NONE,   "\033OQ" ,       0,    0,    0},
	{ XKB_KEY_F2, /* F14 */  MOD_MASK_SHIFT,  "\033[1;2Q",     0,    0,    0},
	{ XKB_KEY_F2, /* F26 */  MOD_MASK_CTRL,   "\033[1;5Q",     0,    0,    0},
	{ XKB_KEY_F2, /* F38 */  MOD_MASK_LOGO,   "\033[1;6Q",     0,    0,    0},
	{ XKB_KEY_F2, /* F50 */  MOD_MASK_ALT,    "\033[1;3Q",     0,    0,    0},
	{ XKB_KEY_F3,            MOD_MASK_NONE,   "\033OR" ,       0,    0,    0},
	{ XKB_KEY_F3, /* F15 */  MOD_MASK_SHIFT,  "\033[1;2R",     0,    0,    0},
	{ XKB_KEY_F3, /* F27 */  MOD_MASK_CTRL,   "\033[1;5R",     0,    0,    0},
	{ XKB_KEY_F3, /* F39 */  MOD_MASK_LOGO,   "\033[1;6R",     0,    0,    0},
	{ XKB_KEY_F3, /* F51 */  MOD_MASK_ALT,    "\033[1;3R",     0,    0,    0},
	{ XKB_KEY_F4,            MOD_MASK_NONE,   "\033OS" ,       0,    0,    0},
	{ XKB_KEY_F4, /* F16 */  MOD_MASK_SHIFT,  "\033[1;2S",     0,    0,    0},
	{ XKB_KEY_F4, /* F28 */  MOD_MASK_CTRL,   "\033[1;5S",     0,    0,    0},
	{ XKB_KEY_F4, /* F40 */  MOD_MASK_LOGO,   "\033[1;6S",     0,    0,    0},
	{ XKB_KEY_F4, /* F52 */  MOD_MASK_ALT,    "\033[1;3S",     0,    0,    0},
	{ XKB_KEY_F5,            MOD_MASK_NONE,   "\033[15~",      0,    0,    0},
	{ XKB_KEY_F5, /* F17 */  MOD_MASK_SHIFT,  "\033[15;2~",    0,    0,    0},
	{ XKB_KEY_F5, /* F29 */  MOD_MASK_CTRL,   "\033[15;5~",    0,    0,    0},
	{ XKB_KEY_F5, /* F41 */  MOD_MASK_LOGO,   "\033[15;6~",    0,    0,    0},
	{ XKB_KEY_F5, /* F53 */  MOD_MASK_ALT,    "\033[15;3~",    0,    0,    0},
	{ XKB_KEY_F6,            MOD_MASK_NONE,   "\033[17~",      0,    0,    0},
	{ XKB_KEY_F6, /* F18 */  MOD_MASK_SHIFT,  "\033[17;2~",    0,    0,    0},
	{ XKB_KEY_F6, /* F30 */  MOD_MASK_CTRL,   "\033[17;5~",    0,    0,    0},
	{ XKB_KEY_F6, /* F42 */  MOD_MASK_LOGO,   "\033[17;6~",    0,    0,    0},
	{ XKB_KEY_F6, /* F54 */  MOD_MASK_ALT,    "\033[17;3~",    0,    0,    0},
	{ XKB_KEY_F7,            MOD_MASK_NONE,   "\033[18~",      0,    0,    0},
	{ XKB_KEY_F7, /* F19 */  MOD_MASK_SHIFT,  "\033[18;2~",    0,    0,    0},
	{ XKB_KEY_F7, /* F31 */  MOD_MASK_CTRL,   "\033[18;5~",    0,    0,    0},
	{ XKB_KEY_F7, /* F43 */  MOD_MASK_LOGO,   "\033[18;6~",    0,    0,    0},
	{ XKB_KEY_F7, /* F55 */  MOD_MASK_ALT,    "\033[18;3~",    0,    0,    0},
	{ XKB_KEY_F8,            MOD_MASK_NONE,   "\033[19~",      0,    0,    0},
	{ XKB_KEY_F8, /* F20 */  MOD_MASK_SHIFT,  "\033[19;2~",    0,    0,    0},
	{ XKB_KEY_F8, /* F32 */  MOD_MASK_CTRL,   "\033[19;5~",    0,    0,    0},
	{ XKB_KEY_F8, /* F44 */  MOD_MASK_LOGO,   "\033[19;6~",    0,    0,    0},
	{ XKB_KEY_F8, /* F56 */  MOD_MASK_ALT,    "\033[19;3~",    0,    0,    0},
	{ XKB_KEY_F9,            MOD_MASK_NONE,   "\033[20~",      0,    0,    0},
	{ XKB_KEY_F9, /* F21 */  MOD_MASK_SHIFT,  "\033[20;2~",    0,    0,    0},
	{ XKB_KEY_F9, /* F33 */  MOD_MASK_CTRL,   "\033[20;5~",    0,    0,    0},
	{ XKB_KEY_F9, /* F45 */  MOD_MASK_LOGO,   "\033[20;6~",    0,    0,    0},
	{ XKB_KEY_F9, /* F57 */  MOD_MASK_ALT,    "\033[20;3~",    0,    0,    0},
	{ XKB_KEY_F10,           MOD_MASK_NONE,   "\033[21~",      0,    0,    0},
	{ XKB_KEY_F10, /* F22 */ MOD_MASK_SHIFT,  "\033[21;2~",    0,    0,    0},
	{ XKB_KEY_F10, /* F34 */ MOD_MASK_CTRL,   "\033[21;5~",    0,    0,    0},
	{ XKB_KEY_F10, /* F46 */ MOD_MASK_LOGO,   "\033[21;6~",    0,    0,    0},
	{ XKB_KEY_F10, /* F58 */ MOD_MASK_ALT,    "\033[21;3~",    0,    0,    0},
	{ XKB_KEY_F11,           MOD_MASK_NONE,   "\033[23~",      0,    0,    0},
	{ XKB_KEY_F11, /* F23 */ MOD_MASK_SHIFT,  "\033[23;2~",    0,    0,    0},
	{ XKB_KEY_F11, /* F35 */ MOD_MASK_CTRL,   "\033[23;5~",    0,    0,    0},
	{ XKB_KEY_F11, /* F47 */ MOD_MASK_LOGO,   "\033[23;6~",    0,    0,    0},
	{ XKB_KEY_F11, /* F59 */ MOD_MASK_ALT,    "\033[23;3~",    0,    0,    0},
	{ XKB_KEY_F12,           MOD_MASK_NONE,   "\033[24~",      0,    0,    0},
	{ XKB_KEY_F12, /* F24 */ MOD_MASK_SHIFT,  "\033[24;2~",    0,    0,    0},
	{ XKB_KEY_F12, /* F36 */ MOD_MASK_CTRL,   "\033[24;5~",    0,    0,    0},
	{ XKB_KEY_F12, /* F48 */ MOD_MASK_LOGO,   "\033[24;6~",    0,    0,    0},
	{ XKB_KEY_F12, /* F60 */ MOD_MASK_ALT,    "\033[24;3~",    0,    0,    0},
	{ XKB_KEY_F13,           MOD_MASK_NONE,   "\033[1;2P",     0,    0,    0},
	{ XKB_KEY_F14,           MOD_MASK_NONE,   "\033[1;2Q",     0,    0,    0},
	{ XKB_KEY_F15,           MOD_MASK_NONE,   "\033[1;2R",     0,    0,    0},
	{ XKB_KEY_F16,           MOD_MASK_NONE,   "\033[1;2S",     0,    0,    0},
	{ XKB_KEY_F17,           MOD_MASK_NONE,   "\033[15;2~",    0,    0,    0},
	{ XKB_KEY_F18,           MOD_MASK_NONE,   "\033[17;2~",    0,    0,    0},
	{ XKB_KEY_F19,           MOD_MASK_NONE,   "\033[18;2~",    0,    0,    0},
	{ XKB_KEY_F20,           MOD_MASK_NONE,   "\033[19;2~",    0,    0,    0},
	{ XKB_KEY_F21,           MOD_MASK_NONE,   "\033[20;2~",    0,    0,    0},
	{ XKB_KEY_F22,           MOD_MASK_NONE,   "\033[21;2~",    0,    0,    0},
	{ XKB_KEY_F23,           MOD_MASK_NONE,   "\033[23;2~",    0,    0,    0},
	{ XKB_KEY_F24,           MOD_MASK_NONE,   "\033[24;2~",    0,    0,    0},
	{ XKB_KEY_F25,           MOD_MASK_NONE,   "\033[1;5P",     0,    0,    0},
	{ XKB_KEY_F26,           MOD_MASK_NONE,   "\033[1;5Q",     0,    0,    0},
	{ XKB_KEY_F27,           MOD_MASK_NONE,   "\033[1;5R",     0,    0,    0},
	{ XKB_KEY_F28,           MOD_MASK_NONE,   "\033[1;5S",     0,    0,    0},
	{ XKB_KEY_F29,           MOD_MASK_NONE,   "\033[15;5~",    0,    0,    0},
	{ XKB_KEY_F30,           MOD_MASK_NONE,   "\033[17;5~",    0,    0,    0},
	{ XKB_KEY_F31,           MOD_MASK_NONE,   "\033[18;5~",    0,    0,    0},
	{ XKB_KEY_F32,           MOD_MASK_NONE,   "\033[19;5~",    0,    0,    0},
	{ XKB_KEY_F33,           MOD_MASK_NONE,   "\033[20;5~",    0,    0,    0},
	{ XKB_KEY_F34,           MOD_MASK_NONE,   "\033[21;5~",    0,    0,    0},
	{ XKB_KEY_F35,           MOD_MASK_NONE,   "\033[23;5~",    0,    0,    0},
};

/*
 * Selection types' masks.
 * Use the same masks as usual.
 * Button1Mask is always unset, to make masks match between ButtonPress.
 * ButtonRelease and MotionNotify.
 * If no match is found, regular selection is used.
 */
static uint selmasks[] = {
	[SEL_RECTANGULAR] = MOD_MASK_ALT,
};

/*
 * Printable characters in ASCII, used to estimate the advance width
 * of single wide characters.
 */
static char ascii_printable[] =
	" !\"#$%&'()*+,-./0123456789:;<=>?"
	"@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_"
	"`abcdefghijklmnopqrstuvwxyz{|}~";


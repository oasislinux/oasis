/* See LICENSE file for copyright and license details. */

static char *const rcinitcmd[]     = { PREFIX "/etc/rc.init", NULL };
static char *const rcrebootcmd[]   = { PREFIX "/etc/rc.shutdown", "reboot", NULL };
static char *const rcpoweroffcmd[] = { PREFIX "/etc/rc.shutdown", "poweroff", NULL };

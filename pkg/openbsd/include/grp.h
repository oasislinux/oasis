#include_next <grp.h>
#define setgroupent(n) setgrent()
char *group_from_gid(gid_t, int);

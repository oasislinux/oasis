#include_next <grp.h>
#define setgroupent(n) setgrent()
const char *group_from_gid(gid_t, int);
int gid_from_group(const char *, gid_t *);

#include_next <pwd.h>
#define setpassent(n) setpwent()
const char *user_from_uid(uid_t, int);
int uid_from_user(const char *, uid_t *);

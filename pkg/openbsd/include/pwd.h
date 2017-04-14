#include_next <pwd.h>
#define setpassent(n) setpwent()
char *user_from_uid(uid_t, int);

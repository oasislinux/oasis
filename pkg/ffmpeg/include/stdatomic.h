#ifdef __STDC_NO_ATOMICS__
# include <compat/atomics/dummy/stdatomic.h>
#else
# include_next <stdatomic.h>
#endif

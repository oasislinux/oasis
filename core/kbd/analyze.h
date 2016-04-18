#include <string.h>
#include "keymap.h"

int stack_push(struct lk_ctx *ctx, lkfile_t *fp, void *scanner);
int stack_pop(struct lk_ctx *ctx, void *scanner);

typedef void *yyscan_t;
int yylex_init(yyscan_t *scanner);
int yylex_init_extra (struct lk_ctx *user_defined, yyscan_t *scanner);
int yylex_destroy(yyscan_t yyscanner);

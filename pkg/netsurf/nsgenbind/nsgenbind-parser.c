/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.4"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 1

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Substitute the type names.  */
#define YYSTYPE         NSGENBIND_STYPE
#define YYLTYPE         NSGENBIND_LTYPE
/* Substitute the variable and function names.  */
#define yyparse         nsgenbind_parse
#define yylex           nsgenbind_lex
#define yyerror         nsgenbind_error
#define yydebug         nsgenbind_debug
#define yynerrs         nsgenbind_nerrs


/* Copy the first part of user declarations.  */

#line 75 "nsgenbind-parser.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 1
#endif

/* In a future release of Bison, this section will be replaced
   by #include "nsgenbind-parser.h".  */
#ifndef YY_NSGENBIND_NSGENBIND_PARSER_H_INCLUDED
# define YY_NSGENBIND_NSGENBIND_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef NSGENBIND_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define NSGENBIND_DEBUG 1
#  else
#   define NSGENBIND_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define NSGENBIND_DEBUG 1
# endif /* ! defined YYDEBUG */
#endif  /* ! defined NSGENBIND_DEBUG */
#if NSGENBIND_DEBUG
extern int nsgenbind_debug;
#endif
/* "%code requires" blocks.  */
#line 21 "nsgenbind-parser.y" /* yacc.c:355  */


#define YYLTYPE YYLTYPE
typedef struct YYLTYPE {
        struct YYLTYPE *next;
        int start_line;
        char *filename;

        int first_line;
        int first_column;
        int last_line;
        int last_column;
} YYLTYPE;


#define YYLLOC_DEFAULT(Current, Rhs, N)                                \
        do                                                             \
                if (N) {                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;       \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;     \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;        \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;      \
          (Current).filename     = YYRHSLOC (Rhs, 1).filename;         \
          (Current).start_line   = YYRHSLOC (Rhs, 1).start_line;       \
                } else { /* empty RHS */                               \
          (Current).first_line   = (Current).last_line   =             \
            YYRHSLOC (Rhs, 0).last_line;                               \
          (Current).first_column = (Current).last_column =             \
            YYRHSLOC (Rhs, 0).last_column;                             \
          (Current).filename  = YYRHSLOC (Rhs, 0).filename;            \
          (Current).start_line  = YYRHSLOC (Rhs, 0).start_line;        \
                }                                                      \
        while (0)


#line 149 "nsgenbind-parser.c" /* yacc.c:355  */

/* Token type.  */
#ifndef NSGENBIND_TOKENTYPE
# define NSGENBIND_TOKENTYPE
  enum nsgenbind_tokentype
  {
    TOK_BINDING = 258,
    TOK_WEBIDL = 259,
    TOK_PREFACE = 260,
    TOK_PROLOGUE = 261,
    TOK_EPILOGUE = 262,
    TOK_POSTFACE = 263,
    TOK_CLASS = 264,
    TOK_PRIVATE = 265,
    TOK_INTERNAL = 266,
    TOK_FLAGS = 267,
    TOK_TYPE = 268,
    TOK_UNSHARED = 269,
    TOK_SHARED = 270,
    TOK_PROPERTY = 271,
    TOK_INIT = 272,
    TOK_FINI = 273,
    TOK_METHOD = 274,
    TOK_GETTER = 275,
    TOK_SETTER = 276,
    TOK_PROTOTYPE = 277,
    TOK_DBLCOLON = 278,
    TOK_STRUCT = 279,
    TOK_UNION = 280,
    TOK_UNSIGNED = 281,
    TOK_IDENTIFIER = 282,
    TOK_STRING_LITERAL = 283,
    TOK_CCODE_LITERAL = 284
  };
#endif

/* Value type.  */
#if ! defined NSGENBIND_STYPE && ! defined NSGENBIND_STYPE_IS_DECLARED

union NSGENBIND_STYPE
{
#line 180 "nsgenbind-parser.y" /* yacc.c:355  */

        char *text;
        struct genbind_node *node;
        long value;

#line 197 "nsgenbind-parser.c" /* yacc.c:355  */
};

typedef union NSGENBIND_STYPE NSGENBIND_STYPE;
# define NSGENBIND_STYPE_IS_TRIVIAL 1
# define NSGENBIND_STYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined NSGENBIND_LTYPE && ! defined NSGENBIND_LTYPE_IS_DECLARED
typedef struct NSGENBIND_LTYPE NSGENBIND_LTYPE;
struct NSGENBIND_LTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define NSGENBIND_LTYPE_IS_DECLARED 1
# define NSGENBIND_LTYPE_IS_TRIVIAL 1
#endif



int nsgenbind_parse (char *filename, struct genbind_node **genbind_ast);

#endif /* !YY_NSGENBIND_NSGENBIND_PARSER_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 227 "nsgenbind-parser.c" /* yacc.c:358  */
/* Unqualified %code blocks.  */
#line 63 "nsgenbind-parser.y" /* yacc.c:359  */

/* parser for the binding generation config file 
 *
 * This file is part of nsgenbind.
 * Licensed under the MIT License,
 *                http://www.opensource.org/licenses/mit-license.php
 * Copyright 2012 Vincent Sanders <vince@netsurf-browser.org>
 */

#include <stdio.h>
#include <string.h>

#define YYFPRINTF genbind_fprintf
#define YY_LOCATION_PRINT(File, Loc)                            \
  genbind_fprintf(File, "%d.%d-%d.%d",                          \
                  (Loc).first_line, (Loc).first_column,         \
                  (Loc).last_line,  (Loc).last_column)

#include "utils.h"
#include "nsgenbind-lexer.h"
#include "webidl-ast.h"
#include "nsgenbind-ast.h"

char *errtxt;

static void nsgenbind_error(YYLTYPE *locp,
                            char *filename,
                            struct genbind_node **genbind_ast,
                            const char *str)
{
        int errlen;

        UNUSED(genbind_ast);
        UNUSED(filename);

        errlen = snprintf(NULL, 0, "%s:%d:%s",
                          locp->filename, locp->first_line, str);
        errtxt = malloc(errlen + 1);
        snprintf(errtxt, errlen + 1, "%s:%d:%s",
                          locp->filename, locp->first_line, str);

}

static struct genbind_node *
add_method(struct genbind_node **genbind_ast,
           long methodtype,
           struct genbind_node *declarator,
           char *cdata,
           long lineno,
           char *filename)
{
        struct genbind_node *res_node;
        struct genbind_node *method_node;
        struct genbind_node *class_node;
        struct genbind_node *cdata_node;
        struct genbind_node *location_node;
        char *class_name;

        /* extract the class name from the declarator */
        class_name = genbind_node_gettext(
                genbind_node_find_type(
                        genbind_node_getnode(
                                genbind_node_find_type(
                                        declarator,
                                        NULL,
                                        GENBIND_NODE_TYPE_CLASS)),
                        NULL,
                        GENBIND_NODE_TYPE_IDENT));

        if (cdata == NULL) {
                cdata_node = declarator;
        } else {
                cdata_node = genbind_new_node(GENBIND_NODE_TYPE_CDATA,
                                              declarator,
                                              cdata);
        }

        location_node = genbind_new_node(GENBIND_NODE_TYPE_FILE,
                                genbind_new_node(GENBIND_NODE_TYPE_LINE,
                                                 cdata_node,
                                                 (void *)lineno),
                                         strdup(filename));

        /* generate method node */
        method_node = genbind_new_node(GENBIND_NODE_TYPE_METHOD,
                                 NULL,
                                 genbind_new_node(GENBIND_NODE_TYPE_METHOD_TYPE,
                                                  location_node,
                                                  (void *)methodtype));

        class_node = genbind_node_find_type_ident(*genbind_ast,
                                                  NULL,
                                                  GENBIND_NODE_TYPE_CLASS,
                                                  class_name);
        if (class_node == NULL) {
                /* no existing class so manufacture one and attach method */
                res_node = genbind_new_node(GENBIND_NODE_TYPE_CLASS, NULL,
                                      genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                       method_node,
                                                       class_name));
        } else {
                /* update the existing class */

                /* link member node into class_node */
                genbind_node_add(class_node, method_node);

                res_node = NULL; /* updating so no need to add a new node */
        }
        return res_node;
}


#line 342 "nsgenbind-parser.c" /* yacc.c:359  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined NSGENBIND_LTYPE_IS_TRIVIAL && NSGENBIND_LTYPE_IS_TRIVIAL \
             && defined NSGENBIND_STYPE_IS_TRIVIAL && NSGENBIND_STYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
  YYLTYPE yyls_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE) + sizeof (YYLTYPE)) \
      + 2 * YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  25
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   134

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  37
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  24
/* YYNRULES -- Number of rules.  */
#define YYNRULES  61
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  104

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   284

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
      35,    36,    33,     2,    34,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,    30,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    31,     2,    32,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29
};

#if NSGENBIND_DEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   251,   251,   258,   260,   265,   274,   276,   278,   282,
     292,   294,   301,   303,   317,   327,   336,   345,   354,   361,
     363,   370,   375,   384,   386,   394,   399,   410,   415,   422,
     427,   432,   437,   442,   447,   452,   456,   461,   466,   471,
     478,   483,   488,   496,   507,   518,   527,   538,   547,   551,
     558,   563,   568,   578,   583,   596,   601,   609,   613,   620,
     625,   630
};
#endif

#if NSGENBIND_DEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TOK_BINDING", "TOK_WEBIDL",
  "TOK_PREFACE", "TOK_PROLOGUE", "TOK_EPILOGUE", "TOK_POSTFACE",
  "TOK_CLASS", "TOK_PRIVATE", "TOK_INTERNAL", "TOK_FLAGS", "TOK_TYPE",
  "TOK_UNSHARED", "TOK_SHARED", "TOK_PROPERTY", "TOK_INIT", "TOK_FINI",
  "TOK_METHOD", "TOK_GETTER", "TOK_SETTER", "TOK_PROTOTYPE",
  "TOK_DBLCOLON", "TOK_STRUCT", "TOK_UNION", "TOK_UNSIGNED",
  "TOK_IDENTIFIER", "TOK_STRING_LITERAL", "TOK_CCODE_LITERAL", "';'",
  "'{'", "'}'", "'*'", "','", "'('", "')'", "$accept", "Input",
  "Statements", "Statement", "Binding", "BindingArgs", "BindingArg",
  "WebIDL", "CTypeSpecifier", "CType", "CTypeIdent", "CBlock",
  "ParameterList", "Method", "MethodType", "BindingAndMethodType",
  "MethodName", "MethodDeclarator", "Class", "ClassArgs", "ClassArg",
  "ClassFlags", "Modifiers", "Modifier", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
      59,   123,   125,    42,    44,    40,    41
};
# endif

#define YYPACT_NINF -42

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-42)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
       6,   -20,    13,   -42,   -42,   -42,   -42,    51,   -42,   -42,
     -42,   -42,   -42,   -42,    91,    26,   -42,   -42,   -42,    65,
     -42,   -42,   -42,    62,    64,   -42,   -42,   -15,    37,    76,
      63,    38,    28,   -42,   -42,    67,    66,    -2,   -42,   -42,
      68,    61,    61,    71,   -42,    68,    69,    63,   -42,   -42,
     -42,    70,    72,    73,    75,   -42,   -42,    74,    77,   -42,
     -17,   -42,    78,    79,   -42,    47,    80,    81,   -42,   -12,
      23,    60,    82,   -42,    36,   -42,   -42,   -42,   -42,    83,
      61,   -42,   -42,   -42,   -42,   -42,   -42,   -42,    86,   -42,
     -42,   -42,    84,   -42,   -42,   -42,   -42,    22,    88,   -42,
     -42,   -42,   -42,   -42
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,    36,    37,    38,    39,     0,    29,    30,
      31,    32,    33,    34,     0,     2,     3,     6,     8,     0,
      35,     7,     5,     0,     0,     1,     4,     0,     0,     0,
      48,     0,     0,    23,    28,    27,     0,     0,    10,    12,
       0,     0,     0,     0,    57,     0,     0,    48,    42,    41,
      40,     0,     0,     0,     0,    18,    46,    19,     0,    25,
       0,    24,     0,     0,    11,     0,     0,     0,    55,     0,
       0,     0,     0,    49,     0,    16,    17,    15,    20,    21,
       0,    45,    14,     9,    13,    50,    51,    53,     0,    59,
      60,    61,     0,    58,    54,    47,    44,     0,     0,    26,
      56,    52,    43,    22
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -42,   -42,   -42,   101,   -42,   -42,    85,   -42,   -42,   -42,
     -41,   -24,    29,   -42,   -42,    12,   -42,   -42,   -42,    87,
     -42,   -42,   -42,   -42
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,    14,    15,    16,    17,    37,    38,    39,    57,    58,
      59,    35,    60,    18,    19,    20,    51,    28,    21,    46,
      47,    69,    70,    93
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      66,    67,    36,     3,     4,     5,     6,     1,    31,     2,
      22,     3,     4,     5,     6,     7,    65,    80,    87,    81,
      32,    71,    88,     8,     9,    10,    11,    12,    13,     2,
      63,     3,     4,     5,     6,     7,    89,    90,    91,    99,
      23,    40,    45,     8,     9,    10,    11,    12,    13,    40,
      92,    48,    52,    53,    54,    55,    80,    49,   102,    45,
      52,    53,    54,    55,    56,    50,    33,    34,     3,     4,
       5,     6,    96,    41,    42,    43,    61,    84,    24,    44,
      36,     3,     4,     5,     6,    52,    53,    54,    55,    61,
      94,    25,    27,    29,    62,    30,    61,    33,    68,    75,
      76,    72,    77,    97,    79,    74,    98,    78,    82,    83,
      85,    86,    95,   100,   101,   103,    26,     0,     0,     0,
       0,     0,    64,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    73
};

static const yytype_int8 yycheck[] =
{
      41,    42,     4,     5,     6,     7,     8,     1,    23,     3,
      30,     5,     6,     7,     8,     9,    40,    34,    30,    36,
      35,    45,    34,    17,    18,    19,    20,    21,    22,     3,
      32,     5,     6,     7,     8,     9,    13,    14,    15,    80,
      27,    29,    30,    17,    18,    19,    20,    21,    22,    37,
      27,    13,    24,    25,    26,    27,    34,    19,    36,    47,
      24,    25,    26,    27,    36,    27,    29,    30,     5,     6,
       7,     8,    36,    10,    11,    12,    29,    30,    27,    16,
       4,     5,     6,     7,     8,    24,    25,    26,    27,    29,
      30,     0,    27,    31,    28,    31,    29,    29,    27,    27,
      27,    32,    27,    74,    27,    35,    23,    33,    30,    30,
      30,    30,    30,    27,    30,    27,    15,    -1,    -1,    -1,
      -1,    -1,    37,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    47
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     1,     3,     5,     6,     7,     8,     9,    17,    18,
      19,    20,    21,    22,    38,    39,    40,    41,    50,    51,
      52,    55,    30,    27,    27,     0,    40,    27,    54,    31,
      31,    23,    35,    29,    30,    48,     4,    42,    43,    44,
      52,    10,    11,    12,    16,    52,    56,    57,    13,    19,
      27,    53,    24,    25,    26,    27,    36,    45,    46,    47,
      49,    29,    28,    32,    43,    48,    47,    47,    27,    58,
      59,    48,    32,    56,    35,    27,    27,    27,    33,    27,
      34,    36,    30,    30,    30,    30,    30,    30,    34,    13,
      14,    15,    27,    60,    30,    30,    36,    49,    23,    47,
      27,    30,    36,    27
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    37,    38,    39,    39,    39,    40,    40,    40,    41,
      42,    42,    43,    43,    44,    45,    45,    45,    45,    46,
      46,    47,    47,    48,    48,    49,    49,    50,    50,    51,
      51,    51,    51,    51,    51,    51,    52,    52,    52,    52,
      53,    53,    53,    54,    54,    54,    54,    55,    56,    56,
      57,    57,    57,    57,    57,    58,    58,    59,    59,    60,
      60,    60
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     2,     2,     1,     1,     1,     6,
       1,     2,     1,     3,     3,     2,     2,     2,     1,     1,
       2,     2,     4,     1,     2,     1,     3,     3,     3,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     6,     5,     4,     3,     6,     0,     2,
       3,     3,     4,     3,     3,     1,     3,     0,     2,     1,
       1,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (&yylloc, filename, genbind_ast, YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)                                \
    do                                                                  \
      if (N)                                                            \
        {                                                               \
          (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;        \
          (Current).first_column = YYRHSLOC (Rhs, 1).first_column;      \
          (Current).last_line    = YYRHSLOC (Rhs, N).last_line;         \
          (Current).last_column  = YYRHSLOC (Rhs, N).last_column;       \
        }                                                               \
      else                                                              \
        {                                                               \
          (Current).first_line   = (Current).last_line   =              \
            YYRHSLOC (Rhs, 0).last_line;                                \
          (Current).first_column = (Current).last_column =              \
            YYRHSLOC (Rhs, 0).last_column;                              \
        }                                                               \
    while (0)
#endif

#define YYRHSLOC(Rhs, K) ((Rhs)[K])


/* Enable debugging if requested.  */
#if NSGENBIND_DEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined NSGENBIND_LTYPE_IS_TRIVIAL && NSGENBIND_LTYPE_IS_TRIVIAL

/* Print *YYLOCP on YYO.  Private, do not rely on its existence. */

YY_ATTRIBUTE_UNUSED
static unsigned
yy_location_print_ (FILE *yyo, YYLTYPE const * const yylocp)
{
  unsigned res = 0;
  int end_col = 0 != yylocp->last_column ? yylocp->last_column - 1 : 0;
  if (0 <= yylocp->first_line)
    {
      res += YYFPRINTF (yyo, "%d", yylocp->first_line);
      if (0 <= yylocp->first_column)
        res += YYFPRINTF (yyo, ".%d", yylocp->first_column);
    }
  if (0 <= yylocp->last_line)
    {
      if (yylocp->first_line < yylocp->last_line)
        {
          res += YYFPRINTF (yyo, "-%d", yylocp->last_line);
          if (0 <= end_col)
            res += YYFPRINTF (yyo, ".%d", end_col);
        }
      else if (0 <= end_col && yylocp->first_column < end_col)
        res += YYFPRINTF (yyo, "-%d", end_col);
    }
  return res;
 }

#  define YY_LOCATION_PRINT(File, Loc)          \
  yy_location_print_ (File, &(Loc))

# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value, Location, filename, genbind_ast); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, char *filename, struct genbind_node **genbind_ast)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  YYUSE (yylocationp);
  YYUSE (filename);
  YYUSE (genbind_ast);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, char *filename, struct genbind_node **genbind_ast)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp, filename, genbind_ast);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule, char *filename, struct genbind_node **genbind_ast)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                       , &(yylsp[(yyi + 1) - (yynrhs)])                       , filename, genbind_ast);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule, filename, genbind_ast); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !NSGENBIND_DEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !NSGENBIND_DEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp, char *filename, struct genbind_node **genbind_ast)
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);
  YYUSE (filename);
  YYUSE (genbind_ast);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/*----------.
| yyparse.  |
`----------*/

int
yyparse (char *filename, struct genbind_node **genbind_ast)
{
/* The lookahead symbol.  */
int yychar;


/* The semantic value of the lookahead symbol.  */
/* Default value used for initialization, for pacifying older GCCs
   or non-GCC compilers.  */
YY_INITIAL_VALUE (static YYSTYPE yyval_default;)
YYSTYPE yylval YY_INITIAL_VALUE (= yyval_default);

/* Location data for the lookahead symbol.  */
static YYLTYPE yyloc_default
# if defined NSGENBIND_LTYPE_IS_TRIVIAL && NSGENBIND_LTYPE_IS_TRIVIAL
  = { 1, 1, 1, 1 }
# endif
;
YYLTYPE yylloc = yyloc_default;

    /* Number of syntax errors so far.  */
    int yynerrs;

    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.
       'yyls': related to locations.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    /* The location stack.  */
    YYLTYPE yylsa[YYINITDEPTH];
    YYLTYPE *yyls;
    YYLTYPE *yylsp;

    /* The locations where the error started and ended.  */
    YYLTYPE yyerror_range[3];

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
  YYLTYPE yyloc;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N), yylsp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yylsp = yyls = yylsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

/* User initialization code.  */
#line 57 "nsgenbind-parser.y" /* yacc.c:1429  */
{
        yylloc.first_line   = yylloc.last_line   = 1;
        yylloc.first_column = yylloc.last_column = 1;
        yylloc.filename = filename;
}

#line 1428 "nsgenbind-parser.c" /* yacc.c:1429  */
  yylsp[0] = yylloc;
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;
        YYLTYPE *yyls1 = yyls;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yyls1, yysize * sizeof (*yylsp),
                    &yystacksize);

        yyls = yyls1;
        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
        YYSTACK_RELOCATE (yyls_alloc, yyls);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;
      yylsp = yyls + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex (&yylval, &yylloc);
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END
  *++yylsp = yylloc;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];

  /* Default location.  */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);
  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:
#line 252 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                *genbind_ast = (yyvsp[0].node);
        }
#line 1619 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 4:
#line 261 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = *genbind_ast = genbind_node_prepend((yyvsp[0].node), (yyvsp[-1].node));
        }
#line 1627 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 5:
#line 266 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                fprintf(stderr, "%s\n", errtxt);
                free(errtxt);
                YYABORT ;
        }
#line 1637 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 9:
#line 283 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_BINDING,
                                      NULL,
                                      genbind_new_node(GENBIND_NODE_TYPE_NAME,
                                                       (yyvsp[-2].node), (yyvsp[-4].text)));
        }
#line 1648 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 11:
#line 295 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_node_link((yyvsp[0].node), (yyvsp[-1].node));
        }
#line 1656 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 13:
#line 304 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_METHOD,
                        NULL,
                        genbind_new_node(GENBIND_NODE_TYPE_METHOD_TYPE,
                                genbind_new_node(GENBIND_NODE_TYPE_CDATA,
                                                 NULL,
                                                 (yyvsp[-1].text)),
                                (void *)(yyvsp[-2].value)));
        }
#line 1670 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 14:
#line 318 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_WEBIDL, NULL, (yyvsp[-1].text));
        }
#line 1678 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 15:
#line 328 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_NAME,
                                      genbind_new_node(GENBIND_NODE_TYPE_NAME,
                                                       NULL,
                                                       strdup("unsigned")),
                                      (yyvsp[0].text));
        }
#line 1690 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 16:
#line 337 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_NAME,
                                      genbind_new_node(GENBIND_NODE_TYPE_NAME,
                                                       NULL,
                                                       strdup("struct")),
                                      (yyvsp[0].text));
        }
#line 1702 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 17:
#line 346 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_NAME,
                                      genbind_new_node(GENBIND_NODE_TYPE_NAME,
                                                       NULL,
                                                       strdup("union")),
                                      (yyvsp[0].text));
        }
#line 1714 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 18:
#line 355 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_NAME, NULL, (yyvsp[0].text));
        }
#line 1722 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 20:
#line 364 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_NAME, (yyvsp[-1].node), strdup("*"));
        }
#line 1730 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 21:
#line 371 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_IDENT, (yyvsp[-1].node), (yyvsp[0].text));
        }
#line 1738 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 22:
#line 376 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                        genbind_new_node(GENBIND_NODE_TYPE_IDENT, (yyvsp[-3].node), (yyvsp[-2].text)), (yyvsp[0].text));
        }
#line 1747 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 24:
#line 387 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
          (yyval.text) = genbind_strapp((yyvsp[-1].text), (yyvsp[0].text));
        }
#line 1755 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 25:
#line 395 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_PARAMETER, NULL, (yyvsp[0].node));
        }
#line 1763 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 26:
#line 400 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_node_prepend((yyvsp[-2].node),
                                          genbind_new_node(
                                                  GENBIND_NODE_TYPE_PARAMETER,
                                                  NULL,
                                                  (yyvsp[0].node)));
        }
#line 1775 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 27:
#line 411 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = add_method(genbind_ast, (yyvsp[-2].value), (yyvsp[-1].node), (yyvsp[0].text), (yylsp[-2]).first_line, (yylsp[-2]).filename);
        }
#line 1783 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 28:
#line 416 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = add_method(genbind_ast, (yyvsp[-2].value), (yyvsp[-1].node), NULL, (yylsp[-2]).first_line, (yylsp[-2]).filename);
        }
#line 1791 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 29:
#line 423 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_INIT;
        }
#line 1799 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 30:
#line 428 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_FINI;
        }
#line 1807 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 31:
#line 433 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_METHOD;
        }
#line 1815 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 32:
#line 438 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_GETTER;
        }
#line 1823 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 33:
#line 443 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_SETTER;
        }
#line 1831 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 34:
#line 448 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_PROTOTYPE;
        }
#line 1839 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 36:
#line 457 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_PREFACE;
        }
#line 1847 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 37:
#line 462 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_PROLOGUE;
        }
#line 1855 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 38:
#line 467 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_EPILOGUE;
        }
#line 1863 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 39:
#line 472 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.value) = GENBIND_METHOD_TYPE_POSTFACE;
        }
#line 1871 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 40:
#line 479 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = (yyvsp[0].text);
        }
#line 1879 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 41:
#line 484 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("method");
        }
#line 1887 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 42:
#line 489 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("type");
        }
#line 1895 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 43:
#line 497 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_CLASS,
                                      genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                       (yyvsp[-1].node),
                                                       (yyvsp[-3].text)),
                                      genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                       NULL,
                                                       (yyvsp[-5].text)));
        }
#line 1909 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 44:
#line 508 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_CLASS,
                                      genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                       NULL,
                                                       (yyvsp[-2].text)),
                                      genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                       NULL,
                                                       (yyvsp[-4].text)));
        }
#line 1923 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 45:
#line 519 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_CLASS,
                                      (yyvsp[-1].node),
                                      genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                       NULL,
                                                       (yyvsp[-3].text)));
        }
#line 1935 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 46:
#line 528 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_CLASS, NULL,
                                      genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                       NULL,
                                                       (yyvsp[-2].text)));
        }
#line 1946 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 47:
#line 539 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_CLASS, NULL,
                        genbind_new_node(GENBIND_NODE_TYPE_IDENT, (yyvsp[-2].node), (yyvsp[-4].text)));
        }
#line 1955 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 48:
#line 547 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 1963 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 49:
#line 552 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_node_prepend((yyvsp[0].node), (yyvsp[-1].node));
        }
#line 1971 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 50:
#line 559 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_PRIVATE, NULL, (yyvsp[-1].node));
        }
#line 1979 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 51:
#line 564 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_INTERNAL, NULL, (yyvsp[-1].node));
        }
#line 1987 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 52:
#line 569 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_PROPERTY, NULL,
                        genbind_new_node(GENBIND_NODE_TYPE_MODIFIER,
                                genbind_new_node(GENBIND_NODE_TYPE_IDENT,
                                                 NULL,
                                                 (yyvsp[-1].text)),
                                         (void *)(yyvsp[-2].value)));
        }
#line 2000 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 53:
#line 579 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_FLAGS, NULL, (yyvsp[-1].node));
        }
#line 2008 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 54:
#line 584 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_METHOD,
                        NULL,
                        genbind_new_node(GENBIND_NODE_TYPE_METHOD_TYPE,
                                genbind_new_node(GENBIND_NODE_TYPE_CDATA,
                                                 NULL,
                                                 (yyvsp[-1].text)),
                                (void *)(yyvsp[-2].value)));
        }
#line 2022 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 55:
#line 597 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_IDENT, NULL, (yyvsp[0].text));
        }
#line 2030 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 56:
#line 602 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = genbind_new_node(GENBIND_NODE_TYPE_IDENT, (yyvsp[-2].node), (yyvsp[0].text));
        }
#line 2038 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 57:
#line 609 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
            (yyval.value) = GENBIND_TYPE_NONE;
        }
#line 2046 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 58:
#line 614 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
            (yyval.value) |= (yyvsp[0].value);
        }
#line 2054 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 59:
#line 621 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
            (yyval.value) = GENBIND_TYPE_TYPE;
        }
#line 2062 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 60:
#line 626 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
            (yyval.value) = GENBIND_TYPE_UNSHARED;            
        }
#line 2070 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;

  case 61:
#line 631 "nsgenbind-parser.y" /* yacc.c:1646  */
    {
            (yyval.value) = GENBIND_TYPE_NONE;            
        }
#line 2078 "nsgenbind-parser.c" /* yacc.c:1646  */
    break;


#line 2082 "nsgenbind-parser.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
  *++yylsp = yyloc;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (&yylloc, filename, genbind_ast, YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (&yylloc, filename, genbind_ast, yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }

  yyerror_range[1] = yylloc;

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, &yylloc, filename, genbind_ast);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  yyerror_range[1] = yylsp[1-yylen];
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;

      yyerror_range[1] = *yylsp;
      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp, yylsp, filename, genbind_ast);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  yyerror_range[2] = yylloc;
  /* Using YYLLOC is tempting, but would change the location of
     the lookahead.  YYLOC is available though.  */
  YYLLOC_DEFAULT (yyloc, yyerror_range, 2);
  *++yylsp = yyloc;

  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (&yylloc, filename, genbind_ast, YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, &yylloc, filename, genbind_ast);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp, yylsp, filename, genbind_ast);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
#line 636 "nsgenbind-parser.y" /* yacc.c:1906  */


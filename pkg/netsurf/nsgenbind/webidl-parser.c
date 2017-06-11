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
#define YYSTYPE         WEBIDL_STYPE
#define YYLTYPE         WEBIDL_LTYPE
/* Substitute the variable and function names.  */
#define yyparse         webidl_parse
#define yylex           webidl_lex
#define yyerror         webidl_error
#define yydebug         webidl_debug
#define yynerrs         webidl_nerrs


/* Copy the first part of user declarations.  */
#line 1 "webidl-parser.y" /* yacc.c:339  */


/* This is a bison parser for Web IDL
 *
 * This file is part of nsgenbind.
 * Licensed under the MIT License,
 *                http://www.opensource.org/licenses/mit-license.php
 * Copyright 2012 Vincent Sanders <vince@netsurf-browser.org>
 *
 * Derived from the the grammar in apendix A of W3C WEB IDL
 *   http://www.w3.org/TR/WebIDL/
 *
 * WebIDL now has a second edition draft (mid 2015) that the dom and
 *   html specs are using. https://heycam.github.io/webidl
 */

#include <stdio.h>
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <math.h>

#define YYFPRINTF webidl_fprintf
#define YY_LOCATION_PRINT(File, Loc)                            \
  webidl_fprintf(File, "%d.%d-%d.%d",                           \
                 (Loc).first_line, (Loc).first_column,          \
                 (Loc).last_line,  (Loc).last_column)

#include "utils.h"
#include "webidl-parser.h"
#include "webidl-lexer.h"

#include "webidl-ast.h"

char *errtxt;

static void
webidl_error(YYLTYPE *locp, struct webidl_node **winbind_ast, const char *str)
{
    UNUSED(locp);
    UNUSED(winbind_ast);
    errtxt = strdup(str);
}


#line 120 "webidl-parser.c" /* yacc.c:339  */

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
   by #include "webidl-parser.h".  */
#ifndef YY_WEBIDL_WEBIDL_PARSER_H_INCLUDED
# define YY_WEBIDL_WEBIDL_PARSER_H_INCLUDED
/* Debug traces.  */
#ifndef WEBIDL_DEBUG
# if defined YYDEBUG
#if YYDEBUG
#   define WEBIDL_DEBUG 1
#  else
#   define WEBIDL_DEBUG 0
#  endif
# else /* ! defined YYDEBUG */
#  define WEBIDL_DEBUG 1
# endif /* ! defined YYDEBUG */
#endif  /* ! defined WEBIDL_DEBUG */
#if WEBIDL_DEBUG
extern int webidl_debug;
#endif

/* Token type.  */
#ifndef WEBIDL_TOKENTYPE
# define WEBIDL_TOKENTYPE
  enum webidl_tokentype
  {
    TOK_ANY = 258,
    TOK_ATTRIBUTE = 259,
    TOK_BOOLEAN = 260,
    TOK_BYTE = 261,
    TOK_CALLBACK = 262,
    TOK_CONST = 263,
    TOK_CONSTRUCTOR = 264,
    TOK_CREATOR = 265,
    TOK_DATE = 266,
    TOK_DELETER = 267,
    TOK_DICTIONARY = 268,
    TOK_DOUBLE = 269,
    TOK_ELLIPSIS = 270,
    TOK_ENUM = 271,
    TOK_EOL = 272,
    TOK_EXCEPTION = 273,
    TOK_FALSE = 274,
    TOK_FLOAT = 275,
    TOK_GETRAISES = 276,
    TOK_GETTER = 277,
    TOK_IMPLEMENTS = 278,
    TOK_IN = 279,
    TOK_INFINITY = 280,
    TOK_INHERIT = 281,
    TOK_INTERFACE = 282,
    TOK_ITERABLE = 283,
    TOK_LEGACYCALLER = 284,
    TOK_LEGACYITERABLE = 285,
    TOK_LONG = 286,
    TOK_MODULE = 287,
    TOK_NAN = 288,
    TOK_NATIVE = 289,
    TOK_NAMEDCONSTRUCTOR = 290,
    TOK_NULL_LITERAL = 291,
    TOK_OBJECT = 292,
    TOK_OCTET = 293,
    TOK_OMITTABLE = 294,
    TOK_OPTIONAL = 295,
    TOK_OR = 296,
    TOK_PARTIAL = 297,
    TOK_PROMISE = 298,
    TOK_RAISES = 299,
    TOK_READONLY = 300,
    TOK_REQUIRED = 301,
    TOK_SETRAISES = 302,
    TOK_SETTER = 303,
    TOK_SEQUENCE = 304,
    TOK_SHORT = 305,
    TOK_STATIC = 306,
    TOK_STRING = 307,
    TOK_STRINGIFIER = 308,
    TOK_TRUE = 309,
    TOK_TYPEDEF = 310,
    TOK_UNRESTRICTED = 311,
    TOK_UNSIGNED = 312,
    TOK_VOID = 313,
    TOK_POUND_SIGN = 314,
    TOK_IDENTIFIER = 315,
    TOK_INT_LITERAL = 316,
    TOK_FLOAT_LITERAL = 317,
    TOK_STRING_LITERAL = 318,
    TOK_OTHER_LITERAL = 319,
    TOK_JAVADOC = 320
  };
#endif

/* Value type.  */
#if ! defined WEBIDL_STYPE && ! defined WEBIDL_STYPE_IS_DECLARED

union WEBIDL_STYPE
{
#line 56 "webidl-parser.y" /* yacc.c:355  */

    int attr;
    long value;
    bool isit;
    char* text;
    struct webidl_node *node;

#line 242 "webidl-parser.c" /* yacc.c:355  */
};

typedef union WEBIDL_STYPE WEBIDL_STYPE;
# define WEBIDL_STYPE_IS_TRIVIAL 1
# define WEBIDL_STYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined WEBIDL_LTYPE && ! defined WEBIDL_LTYPE_IS_DECLARED
typedef struct WEBIDL_LTYPE WEBIDL_LTYPE;
struct WEBIDL_LTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define WEBIDL_LTYPE_IS_DECLARED 1
# define WEBIDL_LTYPE_IS_TRIVIAL 1
#endif



int webidl_parse (struct webidl_node **webidl_ast);

#endif /* !YY_WEBIDL_WEBIDL_PARSER_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 272 "webidl-parser.c" /* yacc.c:358  */

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
         || (defined WEBIDL_LTYPE_IS_TRIVIAL && WEBIDL_LTYPE_IS_TRIVIAL \
             && defined WEBIDL_STYPE_IS_TRIVIAL && WEBIDL_STYPE_IS_TRIVIAL)))

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
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   819

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  81
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  83
/* YYNRULES -- Number of rules.  */
#define YYNRULES  232
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  387

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   320

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
      72,    73,     2,     2,    71,    74,    79,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    70,    68,
      75,    69,    76,    80,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    77,     2,    78,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    66,     2,    67,     2,     2,     2,     2,
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
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65
};

#if WEBIDL_DEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   230,   230,   234,   240,   250,   252,   254,   256,   258,
     260,   262,   268,   273,   278,   280,   285,   326,   334,   336,
     341,   372,   376,   440,   442,   444,   446,   451,   492,   496,
     509,   520,   548,   585,   589,   598,   600,   608,   615,   618,
     624,   628,   636,   646,   651,   652,   658,   659,   666,   674,
     682,   714,   732,   734,   736,   743,   751,   758,   768,   778,
     788,   798,   811,   816,   818,   823,   825,   831,   841,   872,
     881,   902,   923,   931,   933,   938,   948,   952,   964,   968,
     977,   985,   993,  1009,  1013,  1021,  1028,  1035,  1045,  1052,
    1062,  1074,  1078,  1090,  1094,  1103,  1107,  1116,  1124,  1133,
    1145,  1147,  1153,  1157,  1165,  1170,  1179,  1183,  1191,  1193,
    1198,  1204,  1208,  1219,  1223,  1235,  1240,  1246,  1252,  1260,
    1272,  1286,  1298,  1302,  1311,  1315,  1324,  1334,  1344,  1355,
    1362,  1367,  1372,  1377,  1382,  1387,  1392,  1397,  1402,  1407,
    1412,  1417,  1422,  1427,  1432,  1437,  1442,  1447,  1452,  1457,
    1462,  1467,  1472,  1477,  1482,  1487,  1492,  1497,  1502,  1507,
    1512,  1517,  1522,  1527,  1532,  1542,  1547,  1552,  1557,  1562,
    1567,  1572,  1577,  1582,  1587,  1592,  1597,  1602,  1607,  1612,
    1617,  1622,  1627,  1632,  1637,  1642,  1647,  1655,  1660,  1668,
    1673,  1682,  1684,  1695,  1703,  1708,  1714,  1723,  1727,  1738,
    1743,  1749,  1756,  1765,  1772,  1779,  1789,  1794,  1808,  1810,
    1812,  1819,  1826,  1836,  1843,  1848,  1855,  1865,  1872,  1877,
    1884,  1901,  1905,  1913,  1922,  1926,  1931,  1940,  1944,  1951,
    1954,  1959,  1961
};
#endif

#if WEBIDL_DEBUG || YYERROR_VERBOSE || 1
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "TOK_ANY", "TOK_ATTRIBUTE",
  "TOK_BOOLEAN", "TOK_BYTE", "TOK_CALLBACK", "TOK_CONST",
  "TOK_CONSTRUCTOR", "TOK_CREATOR", "TOK_DATE", "TOK_DELETER",
  "TOK_DICTIONARY", "TOK_DOUBLE", "TOK_ELLIPSIS", "TOK_ENUM", "TOK_EOL",
  "TOK_EXCEPTION", "TOK_FALSE", "TOK_FLOAT", "TOK_GETRAISES", "TOK_GETTER",
  "TOK_IMPLEMENTS", "TOK_IN", "TOK_INFINITY", "TOK_INHERIT",
  "TOK_INTERFACE", "TOK_ITERABLE", "TOK_LEGACYCALLER",
  "TOK_LEGACYITERABLE", "TOK_LONG", "TOK_MODULE", "TOK_NAN", "TOK_NATIVE",
  "TOK_NAMEDCONSTRUCTOR", "TOK_NULL_LITERAL", "TOK_OBJECT", "TOK_OCTET",
  "TOK_OMITTABLE", "TOK_OPTIONAL", "TOK_OR", "TOK_PARTIAL", "TOK_PROMISE",
  "TOK_RAISES", "TOK_READONLY", "TOK_REQUIRED", "TOK_SETRAISES",
  "TOK_SETTER", "TOK_SEQUENCE", "TOK_SHORT", "TOK_STATIC", "TOK_STRING",
  "TOK_STRINGIFIER", "TOK_TRUE", "TOK_TYPEDEF", "TOK_UNRESTRICTED",
  "TOK_UNSIGNED", "TOK_VOID", "TOK_POUND_SIGN", "TOK_IDENTIFIER",
  "TOK_INT_LITERAL", "TOK_FLOAT_LITERAL", "TOK_STRING_LITERAL",
  "TOK_OTHER_LITERAL", "TOK_JAVADOC", "'{'", "'}'", "';'", "'='", "':'",
  "','", "'('", "')'", "'-'", "'<'", "'>'", "'['", "']'", "'.'", "'?'",
  "$accept", "Definitions", "Definition", "CallbackOrInterface",
  "CallbackRestOrInterface", "Interface", "Partial", "PartialDefinition",
  "PartialInterface", "InterfaceMembers", "InterfaceMember", "Dictionary",
  "DictionaryMembers", "DictionaryMember", "PartialDictionary", "Default",
  "DefaultValue", "Exception", "ExceptionMembers", "Inheritance", "Enum",
  "EnumValueList", "EnumValueListComma", "EnumValueListString",
  "CallbackRest", "Typedef", "ImplementsStatement", "Const", "ConstValue",
  "BooleanLiteral", "FloatLiteral", "AttributeOrOperation",
  "StringifierAttributeOrOperation", "Attribute", "StaticMember",
  "StaticMemberRest", "AttributeRest", "AttributeName",
  "AttributeNameKeyword", "Inherit", "ReadOnly", "Operation",
  "SpecialOperation", "Specials", "Special", "OperationRest",
  "OptionalIdentifier", "ArgumentList", "Arguments", "Argument",
  "OptionalOrRequiredArgument", "ArgumentName", "Ellipsis", "Iterable",
  "OptionalType", "ExceptionMember", "ExceptionField",
  "ExtendedAttributeList", "ExtendedAttributes", "ExtendedAttribute",
  "ExtendedAttributeRest", "ExtendedAttributeInner", "Other",
  "ArgumentNameKeyword", "OtherOrComma", "Type", "SingleType", "UnionType",
  "UnionMemberType", "UnionMemberTypes", "NonAnyType", "ConstType",
  "PrimitiveType", "UnrestrictedFloatType", "FloatType",
  "UnsignedIntegerType", "IntegerType", "OptionalLong", "PromiseType",
  "TypeSuffix", "TypeSuffixStartingWithArray", "Null", "ReturnType", YY_NULLPTR
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
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   123,   125,    59,    61,
      58,    44,    40,    41,    45,    60,    62,    91,    93,    46,
      63
};
# endif

#define YYPACT_NINF -289

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-289)))

#define YYTABLE_NINF -94

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
      16,  -289,    11,  -289,   256,    32,  -289,  -289,  -289,  -289,
    -289,  -289,     0,  -289,  -289,  -289,  -289,  -289,  -289,  -289,
    -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,
    -289,  -289,  -289,    12,  -289,  -289,  -289,  -289,  -289,  -289,
    -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,
    -289,  -289,  -289,  -289,  -289,  -289,  -289,   334,  -289,  -289,
    -289,   334,  -289,  -289,  -289,   334,  -289,  -289,   -20,   256,
    -289,    -3,    18,    34,    39,    41,     9,    27,    83,  -289,
    -289,  -289,  -289,  -289,  -289,  -289,  -289,  -289,   -10,    47,
     334,  -289,   334,   334,    51,  -289,   334,    40,    36,   256,
      42,  -289,  -289,    50,  -289,  -289,  -289,    57,    55,    57,
      57,    69,    79,  -289,  -289,  -289,   660,    81,    70,    73,
     460,    76,    78,    77,    74,   256,  -289,   256,   256,   -20,
    -289,   508,    91,    87,    93,    88,    92,    94,    98,    80,
    -289,  -289,   -15,  -289,  -289,   128,   -15,  -289,    90,    99,
    -289,   -15,    46,    -1,   -15,   708,   109,  -289,   -15,  -289,
     -15,  -289,  -289,  -289,  -289,   -15,   108,  -289,    27,  -289,
     660,  -289,   165,   -10,   334,   334,   334,  -289,  -289,  -289,
    -289,  -289,  -289,   110,  -289,   -42,   113,   123,   -30,  -289,
     -42,  -289,   107,  -289,   116,    80,  -289,  -289,  -289,  -289,
     508,   660,  -289,  -289,  -289,  -289,   114,   -15,   158,  -289,
     132,  -289,  -289,  -289,  -289,    73,   759,  -289,   759,   129,
    -289,  -289,  -289,   -10,   134,   556,   140,  -289,   138,   141,
     612,   -21,   142,   -13,   -15,   -15,  -289,   131,   135,   136,
    -289,   708,  -289,  -289,  -289,   143,  -289,  -289,  -289,   153,
     145,   660,   -42,   168,   113,  -289,  -289,   162,   111,  -289,
     -30,  -289,   172,   166,   167,   169,   170,  -289,  -289,  -289,
     155,   -15,   192,   737,  -289,   173,  -289,   176,  -289,   143,
    -289,  -289,   155,   180,   155,  -289,   174,  -289,  -289,  -289,
    -289,  -289,   171,  -289,   177,  -289,   412,     1,  -289,  -289,
    -289,  -289,  -289,   198,  -289,  -289,   118,  -289,   184,  -289,
    -289,  -289,  -289,  -289,   708,   175,  -289,  -289,  -289,  -289,
    -289,  -289,  -289,  -289,   222,  -289,  -289,  -289,  -289,  -289,
     181,   183,  -289,   186,  -289,  -289,   660,   660,  -289,  -289,
     249,   184,  -289,  -289,  -289,  -289,  -289,   185,   249,   508,
     118,  -289,   192,  -289,  -289,  -289,  -289,    72,   202,   201,
     660,  -289,  -289,   -10,  -289,   184,  -289,  -289,   188,   660,
     204,   220,   -18,   217,  -289,  -289,  -289,   227,  -289,  -289,
    -289,   231,  -289,   232,  -289,  -289,  -289
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     4,   111,     1,     0,     0,   147,   165,   148,   149,
     166,   167,   118,   168,   143,   169,   170,   150,   136,   171,
     172,   151,   152,   173,   174,   145,   175,   176,   177,   178,
     179,   153,   146,     0,   154,   155,   156,   158,   157,   180,
     181,   182,   159,   160,   183,   144,   184,   161,   185,   186,
     162,   163,   131,   129,   130,   132,   133,   124,   138,   140,
     137,   124,   134,   139,   141,   124,   135,   142,   113,   122,
     164,     0,     0,     0,     0,     0,     0,   111,     0,     3,
       5,    13,     6,     7,     8,     9,    10,    11,   111,     0,
     124,   188,   124,   124,     0,   187,   124,     0,     0,     0,
       0,   123,   121,     0,    12,    15,    14,    40,     0,    40,
      40,     0,     0,    17,    18,    19,     0,     0,     0,    95,
       0,     0,     0,     0,     0,   122,   128,   122,   122,   113,
     112,     0,     0,     0,     0,     0,     0,     0,     0,   227,
     210,   211,   224,   216,   215,   221,   224,   212,     0,     0,
     219,   224,     0,     0,   224,     0,     0,   189,   224,   191,
     224,   209,   214,   208,   218,   224,     0,   119,   111,    94,
       0,    97,   102,   111,   124,   124,   124,   117,   115,   116,
     114,   232,   231,     0,    41,   111,    45,     0,   111,    21,
     111,    21,     0,   192,     0,   227,   205,   222,   220,   204,
       0,     0,   201,   213,   217,   202,     0,   224,     0,   194,
       0,   190,   199,   200,    50,    95,     0,   103,     0,     0,
     127,   125,   126,   111,     0,     0,    47,    43,     0,     0,
       0,   111,     0,   111,   224,   224,   226,     0,     0,     0,
     195,     0,    49,    96,   101,    33,   100,    99,   120,     0,
       0,     0,   111,     0,    45,    44,    42,     0,     0,   108,
     111,   109,     0,     0,    76,     0,     0,   228,   225,   223,
     229,   224,   197,     0,    98,     0,    27,     0,    29,    33,
      46,    37,   229,     0,   229,    39,     0,    16,    87,    88,
      85,    77,     0,    89,     0,    86,    78,    76,    22,    23,
      24,    63,    25,    78,    64,    81,    83,    26,    91,    32,
      20,   230,   203,   196,     0,     0,    57,    60,    61,    55,
      56,    54,    58,    36,     0,    34,    35,    52,    53,    48,
       0,     0,   207,     0,   206,   110,     0,     0,    79,    69,
       0,    91,    92,    67,    62,    65,    66,     0,     0,     0,
      83,    80,   197,   193,    59,    30,    31,     0,   106,     0,
       0,    70,    71,   111,    68,    91,    84,   198,     0,     0,
       0,     0,     0,     0,    82,    51,   107,     0,   105,    75,
      74,     0,    73,     0,   104,    72,    90
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
    -289,  -289,  -289,  -289,  -289,   230,  -289,  -289,  -289,   112,
    -289,  -289,  -172,  -289,  -289,    44,  -289,  -289,    61,     2,
    -289,  -289,    75,  -289,  -289,  -289,  -289,    63,   -23,  -289,
    -289,  -289,  -289,    54,  -289,  -289,   -33,  -289,  -289,  -289,
      52,  -289,  -289,    -7,   102,  -288,  -289,  -171,   154,   190,
    -289,   150,  -289,  -289,  -289,  -289,  -289,    -2,   244,     4,
     -43,   -52,    10,  -185,  -289,  -115,  -289,  -152,  -231,    25,
    -151,  -289,   120,  -289,   229,  -289,   226,  -289,  -289,  -139,
     206,  -184,  -194
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     2,    79,    80,   104,    81,    82,   113,   114,   231,
     298,    83,   224,   252,   115,   274,   325,    84,   229,   133,
      85,   187,   227,   255,   106,    86,    87,   259,   326,   327,
     328,   300,   344,   301,   302,   339,   361,   381,   382,   303,
     340,   304,   305,   349,   350,   346,   347,   118,   169,   119,
     171,   245,   218,   307,   370,   260,   261,   120,   100,   101,
     102,    94,    95,    70,    96,   182,   157,   158,   208,   315,
     159,   283,   160,   161,   162,   163,   164,   198,   165,   196,
     193,   312,   183
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int16 yytable[] =
{
       5,   156,   219,   207,   209,   172,   237,   199,    68,    97,
     272,     3,   202,    98,    69,   205,    -2,     1,   232,   211,
     351,   212,   111,    -2,    75,   -28,   213,   291,   379,    -2,
     145,   246,    -2,   246,    -2,     4,   112,   -38,   122,    71,
     123,   124,   380,    -2,   126,    72,   263,     4,    73,   150,
      74,    99,   249,   362,   266,   216,     4,   103,    -2,    75,
     143,   342,   194,   -93,     4,   195,   144,     4,   240,   343,
     308,    -2,    88,   -91,    76,   116,    -2,   374,   107,    69,
     278,    89,   177,   352,   178,   179,   238,    77,     4,   207,
     209,   316,    78,    -2,   108,   267,   268,   317,   332,   109,
     334,   110,   341,   129,     4,   318,   117,   121,   319,    69,
     253,   135,   136,   127,   128,   262,   140,   141,   125,   131,
     130,   134,   220,   221,   222,   143,   320,   132,   288,   137,
     289,   144,   313,   321,   322,    69,   277,    69,    69,   138,
     290,   166,   145,   167,   168,   174,   324,   293,   173,   147,
     175,   184,   176,   185,   188,   365,   186,   192,   189,   197,
     190,   150,   207,   209,   191,   200,   295,   152,   153,   210,
     139,   282,   140,   141,   201,   258,   214,   288,   142,   289,
     217,   143,   223,   225,   226,   234,   230,   144,   225,   290,
     228,   239,   373,   291,   235,   292,   293,   294,   145,   241,
     242,   250,   248,   254,   146,   147,   256,   269,   257,   265,
     148,   270,   273,   276,   271,   295,   149,   150,   296,   151,
     297,   358,   359,   152,   153,   181,   275,   154,   279,   264,
     281,   264,   286,   314,   287,   311,   330,   309,   310,   155,
     333,   329,   335,   338,   342,   372,   336,   354,   353,   355,
     225,   356,   337,   360,   376,   357,   375,   363,   230,     6,
       7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
      17,    18,    19,   369,    20,    21,    22,   371,    23,    24,
     377,    25,    26,    27,    28,    29,    30,    31,   378,    32,
     383,    33,    34,    35,    36,   384,    37,    38,    39,   385,
     386,   105,    40,   233,    41,    42,    43,    44,    45,    46,
      47,    48,    49,    50,    51,   364,    52,    53,    54,    55,
      56,   285,    57,   331,    58,    59,    60,   299,    61,   280,
      62,    63,    64,    65,   368,    66,    67,     6,     7,     8,
       9,    10,    11,   366,    13,    14,    15,    16,    17,    18,
      19,   345,    20,    21,    22,   348,    23,    24,   215,    25,
      26,    27,    28,    29,    30,    31,   306,    32,   247,   243,
      34,    35,    36,   180,    37,    38,    39,   367,   284,   204,
      40,   203,    41,    42,    43,    44,    45,    46,    47,    48,
      49,    50,    51,     0,    52,    53,    54,    55,    56,     0,
      90,   236,    58,    59,    60,    91,    92,     0,    62,    63,
      64,    93,     0,    66,    67,   139,     0,   140,   141,     0,
       0,     0,     0,   142,     0,     0,   143,     0,     0,     0,
       0,     0,   144,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   145,     0,     0,     0,     0,     0,   146,
     147,     0,     0,     0,     0,   148,     0,   338,     0,     0,
       0,   149,   150,   139,   151,   140,   141,     0,   152,   153,
     181,   142,   154,     0,   143,     0,     0,     0,     0,     0,
     144,     0,     0,     0,   155,     0,     0,     0,     0,     0,
       0,   145,     0,     0,     0,     0,     0,   146,   147,     0,
     170,     0,     0,   148,     0,     0,     0,     0,     0,   149,
     150,   139,   151,   140,   141,     0,   152,   153,     0,   142,
     154,     0,   143,     0,     0,     0,     0,     0,   144,     0,
       0,     0,   155,     0,     0,     0,     0,     0,     0,   145,
       0,     0,     0,     0,     0,   146,   147,     0,     0,     0,
       0,   148,     0,     0,     0,     0,     0,   149,   150,   139,
     151,   140,   141,     0,   152,   153,   181,   142,   154,     0,
     143,     0,     0,     0,     0,     0,   144,     0,     0,     0,
     155,     0,     0,     0,     0,     0,     0,   145,     0,     0,
       0,     0,     0,   146,   147,     0,     0,     0,     0,   148,
       0,     0,   251,     0,     0,   149,   150,     0,   151,     0,
       0,     0,   152,   153,     0,   139,   154,   140,   141,     0,
     258,     0,     0,   142,     0,     0,   143,     0,   155,     0,
       0,     0,   144,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   145,     0,     0,     0,     0,     0,   146,
     147,     0,     0,     0,     0,   148,     0,     0,     0,     0,
       0,   149,   150,   139,   151,   140,   141,     0,   152,   153,
       0,   142,   154,     0,   143,     0,     0,     0,     0,     0,
     144,     0,     0,     0,   155,     0,     0,     0,     0,     0,
       0,   145,     0,     0,     0,     0,     0,   146,   147,     0,
       0,     0,     0,   148,     0,     0,     0,     0,     0,   149,
     150,   206,   151,   140,   141,     0,   152,   153,     0,   142,
     154,     0,   143,     0,     0,     0,     0,     0,   144,     0,
       0,     0,   155,     0,     0,     0,     0,     0,     0,   145,
       0,     0,     0,     0,     0,   146,   147,     0,     0,     0,
       0,   148,     0,     0,     0,     0,   316,   149,   150,     0,
     151,     0,   317,     7,   152,   153,    10,    11,   154,    13,
     318,    15,    16,   319,     0,    19,     0,    20,     0,     0,
     155,    23,    24,     0,     0,    26,    27,    28,    29,    30,
       0,   320,     0,     0,     0,     0,     0,     0,   321,   322,
     323,    39,     0,     0,     0,    40,     0,    41,     0,     0,
      44,   324,    46,     0,    48,    49,     0,     0,     0,   244
};

static const yytype_int16 yycheck[] =
{
       2,   116,   173,   155,   155,   120,   200,   146,     4,    61,
     241,     0,   151,    65,     4,   154,     0,     1,   190,   158,
     308,   160,    13,     7,    27,    67,   165,    26,    46,    13,
      31,   216,    16,   218,    18,    77,    27,    67,    90,     7,
      92,    93,    60,    27,    96,    13,    67,    77,    16,    50,
      18,    71,   223,   341,    67,   170,    77,    60,    42,    27,
      14,    60,    77,    73,    77,    80,    20,    77,   207,    68,
     264,    55,    72,    72,    42,    77,    60,   365,    60,    69,
     252,    69,   125,   314,   127,   128,   201,    55,    77,   241,
     241,    19,    60,    77,    60,   234,   235,    25,   282,    60,
     284,    60,   296,    99,    77,    33,    23,    60,    36,    99,
     225,   109,   110,    73,    78,   230,     5,     6,    67,    69,
      78,    66,   174,   175,   176,    14,    54,    70,    10,    60,
      12,    20,   271,    61,    62,   125,   251,   127,   128,    60,
      22,    60,    31,    73,    71,    67,    74,    29,    72,    38,
      73,    60,    78,    66,    66,   349,    63,    77,    66,    31,
      66,    50,   314,   314,    66,    75,    48,    56,    57,    60,
       3,    60,     5,     6,    75,     8,    68,    10,    11,    12,
      15,    14,    72,   185,    71,    78,   188,    20,   190,    22,
      67,    77,   363,    26,    78,    28,    29,    30,    31,    41,
      68,    67,    73,    63,    37,    38,    68,    76,    67,    67,
      43,    76,    69,    68,    78,    48,    49,    50,    51,    52,
      53,   336,   337,    56,    57,    58,    73,    60,    60,   231,
      68,   233,    60,    41,    68,    80,    60,    68,    68,    72,
      60,    68,    68,    45,    60,   360,    75,    25,    73,    68,
     252,    68,    75,     4,   369,    69,    68,    72,   260,     3,
       4,     5,     6,     7,     8,     9,    10,    11,    12,    13,
      14,    15,    16,    71,    18,    19,    20,    76,    22,    23,
      76,    25,    26,    27,    28,    29,    30,    31,    68,    33,
      73,    35,    36,    37,    38,    68,    40,    41,    42,    68,
      68,    71,    46,   191,    48,    49,    50,    51,    52,    53,
      54,    55,    56,    57,    58,   348,    60,    61,    62,    63,
      64,   260,    66,   279,    68,    69,    70,   264,    72,   254,
      74,    75,    76,    77,   357,    79,    80,     3,     4,     5,
       6,     7,     8,   350,    10,    11,    12,    13,    14,    15,
      16,   297,    18,    19,    20,   303,    22,    23,   168,    25,
      26,    27,    28,    29,    30,    31,   264,    33,   218,   215,
      36,    37,    38,   129,    40,    41,    42,   352,   258,   153,
      46,   152,    48,    49,    50,    51,    52,    53,    54,    55,
      56,    57,    58,    -1,    60,    61,    62,    63,    64,    -1,
      66,   195,    68,    69,    70,    71,    72,    -1,    74,    75,
      76,    77,    -1,    79,    80,     3,    -1,     5,     6,    -1,
      -1,    -1,    -1,    11,    -1,    -1,    14,    -1,    -1,    -1,
      -1,    -1,    20,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    31,    -1,    -1,    -1,    -1,    -1,    37,
      38,    -1,    -1,    -1,    -1,    43,    -1,    45,    -1,    -1,
      -1,    49,    50,     3,    52,     5,     6,    -1,    56,    57,
      58,    11,    60,    -1,    14,    -1,    -1,    -1,    -1,    -1,
      20,    -1,    -1,    -1,    72,    -1,    -1,    -1,    -1,    -1,
      -1,    31,    -1,    -1,    -1,    -1,    -1,    37,    38,    -1,
      40,    -1,    -1,    43,    -1,    -1,    -1,    -1,    -1,    49,
      50,     3,    52,     5,     6,    -1,    56,    57,    -1,    11,
      60,    -1,    14,    -1,    -1,    -1,    -1,    -1,    20,    -1,
      -1,    -1,    72,    -1,    -1,    -1,    -1,    -1,    -1,    31,
      -1,    -1,    -1,    -1,    -1,    37,    38,    -1,    -1,    -1,
      -1,    43,    -1,    -1,    -1,    -1,    -1,    49,    50,     3,
      52,     5,     6,    -1,    56,    57,    58,    11,    60,    -1,
      14,    -1,    -1,    -1,    -1,    -1,    20,    -1,    -1,    -1,
      72,    -1,    -1,    -1,    -1,    -1,    -1,    31,    -1,    -1,
      -1,    -1,    -1,    37,    38,    -1,    -1,    -1,    -1,    43,
      -1,    -1,    46,    -1,    -1,    49,    50,    -1,    52,    -1,
      -1,    -1,    56,    57,    -1,     3,    60,     5,     6,    -1,
       8,    -1,    -1,    11,    -1,    -1,    14,    -1,    72,    -1,
      -1,    -1,    20,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    31,    -1,    -1,    -1,    -1,    -1,    37,
      38,    -1,    -1,    -1,    -1,    43,    -1,    -1,    -1,    -1,
      -1,    49,    50,     3,    52,     5,     6,    -1,    56,    57,
      -1,    11,    60,    -1,    14,    -1,    -1,    -1,    -1,    -1,
      20,    -1,    -1,    -1,    72,    -1,    -1,    -1,    -1,    -1,
      -1,    31,    -1,    -1,    -1,    -1,    -1,    37,    38,    -1,
      -1,    -1,    -1,    43,    -1,    -1,    -1,    -1,    -1,    49,
      50,     3,    52,     5,     6,    -1,    56,    57,    -1,    11,
      60,    -1,    14,    -1,    -1,    -1,    -1,    -1,    20,    -1,
      -1,    -1,    72,    -1,    -1,    -1,    -1,    -1,    -1,    31,
      -1,    -1,    -1,    -1,    -1,    37,    38,    -1,    -1,    -1,
      -1,    43,    -1,    -1,    -1,    -1,    19,    49,    50,    -1,
      52,    -1,    25,     4,    56,    57,     7,     8,    60,    10,
      33,    12,    13,    36,    -1,    16,    -1,    18,    -1,    -1,
      72,    22,    23,    -1,    -1,    26,    27,    28,    29,    30,
      -1,    54,    -1,    -1,    -1,    -1,    -1,    -1,    61,    62,
      63,    42,    -1,    -1,    -1,    46,    -1,    48,    -1,    -1,
      51,    74,    53,    -1,    55,    56,    -1,    -1,    -1,    60
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,     1,    82,     0,    77,   138,     3,     4,     5,     6,
       7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
      18,    19,    20,    22,    23,    25,    26,    27,    28,    29,
      30,    31,    33,    35,    36,    37,    38,    40,    41,    42,
      46,    48,    49,    50,    51,    52,    53,    54,    55,    56,
      57,    58,    60,    61,    62,    63,    64,    66,    68,    69,
      70,    72,    74,    75,    76,    77,    79,    80,   140,   143,
     144,     7,    13,    16,    18,    27,    42,    55,    60,    83,
      84,    86,    87,    92,    98,   101,   106,   107,    72,    69,
      66,    71,    72,    77,   142,   143,   145,   142,   142,    71,
     139,   140,   141,    60,    85,    86,   105,    60,    60,    60,
      60,    13,    27,    88,    89,    95,   138,    23,   128,   130,
     138,    60,   142,   142,   142,    67,   142,    73,    78,   140,
      78,    69,    70,   100,    66,   100,   100,    60,    60,     3,
       5,     6,    11,    14,    20,    31,    37,    38,    43,    49,
      50,    52,    56,    57,    60,    72,   146,   147,   148,   151,
     153,   154,   155,   156,   157,   159,    60,    73,    71,   129,
      40,   131,   146,    72,    67,    73,    78,   141,   141,   141,
     139,    58,   146,   163,    60,    66,    63,   102,    66,    66,
      66,    66,    77,   161,    77,    80,   160,    31,   158,   160,
      75,    75,   160,   155,   157,   160,     3,   148,   149,   151,
      60,   160,   160,   160,    68,   130,   146,    15,   133,   128,
     142,   142,   142,    72,    93,   138,    71,   103,    67,    99,
     138,    90,    93,    90,    78,    78,   161,   163,   146,    77,
     160,    41,    68,   129,    60,   132,   144,   132,    73,   128,
      67,    46,    94,   146,    63,   104,    68,    67,     8,   108,
     136,   137,   146,    67,   138,    67,    67,   160,   160,    76,
      76,    78,   149,    69,    96,    73,    68,   146,    93,    60,
     103,    68,    60,   152,   153,    99,    60,    68,    10,    12,
      22,    26,    28,    29,    30,    48,    51,    53,    91,   108,
     112,   114,   115,   120,   122,   123,   125,   134,   163,    68,
      68,    80,   162,   160,    41,   150,    19,    25,    33,    36,
      54,    61,    62,    63,    74,    97,   109,   110,   111,    68,
      60,    96,   162,    60,   162,    68,    75,    75,    45,   116,
     121,   163,    60,    68,   113,   114,   126,   127,   121,   124,
     125,   126,   149,    73,    25,    68,    68,    69,   146,   146,
       4,   117,   126,    72,   117,   163,   124,   150,   109,    71,
     135,    76,   146,   128,   126,    68,   146,    76,    68,    46,
      60,   118,   119,    73,    68,    68,    68
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    81,    82,    82,    82,    83,    83,    83,    83,    83,
      83,    83,    84,    84,    85,    85,    86,    87,    88,    88,
      89,    90,    90,    91,    91,    91,    91,    92,    93,    93,
      94,    94,    95,    96,    96,    97,    97,    98,    99,    99,
     100,   100,   101,   102,   103,   103,   104,   104,   105,   106,
     107,   108,   109,   109,   109,   109,   110,   110,   111,   111,
     111,   111,   112,   112,   112,   113,   113,   113,   114,   115,
     116,   116,   117,   118,   118,   119,   120,   120,   121,   121,
     122,   122,   123,   124,   124,   125,   125,   125,   125,   125,
     126,   127,   127,   128,   128,   129,   129,   130,   131,   131,
     132,   132,   133,   133,   134,   134,   135,   135,   136,   136,
     137,   138,   138,   139,   139,   140,   140,   140,   140,   140,
     140,   140,   141,   141,   142,   142,   142,   142,   142,   143,
     143,   143,   143,   143,   143,   143,   143,   143,   143,   143,
     143,   143,   143,   143,   143,   143,   143,   143,   143,   143,
     143,   143,   143,   143,   143,   143,   143,   143,   143,   143,
     143,   143,   143,   143,   143,   144,   144,   144,   144,   144,
     144,   144,   144,   144,   144,   144,   144,   144,   144,   144,
     144,   144,   144,   144,   144,   144,   144,   145,   145,   146,
     146,   147,   147,   148,   149,   149,   149,   150,   150,   151,
     151,   151,   151,   151,   151,   151,   152,   152,   153,   153,
     153,   153,   153,   154,   154,   155,   155,   156,   156,   157,
     157,   158,   158,   159,   160,   160,   160,   161,   161,   162,
     162,   163,   163
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     3,     1,     1,     1,     1,     1,     1,
       1,     1,     2,     1,     1,     1,     7,     2,     1,     1,
       6,     0,     3,     1,     1,     1,     1,     7,     0,     3,
       4,     4,     6,     0,     2,     1,     1,     7,     0,     3,
       0,     2,     6,     2,     2,     0,     2,     0,     7,     5,
       4,     6,     1,     1,     1,     1,     1,     1,     1,     2,
       1,     1,     2,     1,     1,     1,     1,     1,     3,     2,
       2,     2,     4,     1,     1,     1,     0,     1,     0,     1,
       2,     1,     4,     0,     2,     1,     1,     1,     1,     1,
       5,     0,     1,     0,     2,     0,     3,     2,     4,     3,
       1,     1,     0,     1,     6,     5,     0,     2,     1,     1,
       3,     0,     4,     0,     3,     4,     4,     4,     1,     4,
       6,     2,     0,     1,     0,     4,     4,     4,     2,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       2,     1,     2,     6,     1,     2,     4,     0,     3,     2,
       2,     2,     2,     5,     2,     2,     2,     2,     1,     1,
       1,     1,     1,     2,     1,     1,     1,     2,     1,     1,
       2,     0,     1,     4,     0,     3,     2,     0,     3,     0,
       1,     1,     1
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
      yyerror (&yylloc, webidl_ast, YY_("syntax error: cannot back up")); \
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
#if WEBIDL_DEBUG

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
# if defined WEBIDL_LTYPE_IS_TRIVIAL && WEBIDL_LTYPE_IS_TRIVIAL

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
                  Type, Value, Location, webidl_ast); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, struct webidl_node **webidl_ast)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  YYUSE (yylocationp);
  YYUSE (webidl_ast);
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
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep, YYLTYPE const * const yylocationp, struct webidl_node **webidl_ast)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  YY_LOCATION_PRINT (yyoutput, *yylocationp);
  YYFPRINTF (yyoutput, ": ");
  yy_symbol_value_print (yyoutput, yytype, yyvaluep, yylocationp, webidl_ast);
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
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, YYLTYPE *yylsp, int yyrule, struct webidl_node **webidl_ast)
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
                       , &(yylsp[(yyi + 1) - (yynrhs)])                       , webidl_ast);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, yylsp, Rule, webidl_ast); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !WEBIDL_DEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !WEBIDL_DEBUG */


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
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep, YYLTYPE *yylocationp, struct webidl_node **webidl_ast)
{
  YYUSE (yyvaluep);
  YYUSE (yylocationp);
  YYUSE (webidl_ast);
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
yyparse (struct webidl_node **webidl_ast)
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
# if defined WEBIDL_LTYPE_IS_TRIVIAL && WEBIDL_LTYPE_IS_TRIVIAL
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
#line 230 "webidl-parser.y" /* yacc.c:1646  */
    {
          (yyval.node) = NULL;
        }
#line 1855 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 3:
#line 235 "webidl-parser.y" /* yacc.c:1646  */
    {
            webidl_node_add((yyvsp[0].node), (yyvsp[-1].node));
            (yyval.node) = *webidl_ast = webidl_node_prepend(*webidl_ast, (yyvsp[0].node));
        }
#line 1864 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 4:
#line 241 "webidl-parser.y" /* yacc.c:1646  */
    {
            fprintf(stderr, "%d: %s\n", yylloc.first_line, errtxt);
            free(errtxt);
            YYABORT ;
        }
#line 1874 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 12:
#line 269 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = (yyvsp[0].node);
        }
#line 1882 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 16:
#line 286 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* extend interface with additional members */
                struct webidl_node *interface_node;
                struct webidl_node *members = NULL;

                if ((yyvsp[-4].text) != NULL) {
                        members = webidl_node_new(WEBIDL_NODE_TYPE_INHERITANCE,
                                                  members,
                                                  (yyvsp[-4].text));
                }

                members = webidl_node_new(WEBIDL_NODE_TYPE_LIST, members, (yyvsp[-2].node));


                interface_node = webidl_node_find_type_ident(*webidl_ast,
                                                     WEBIDL_NODE_TYPE_INTERFACE,
                                                             (yyvsp[-5].text));

                if (interface_node == NULL) {
                        /* no existing interface - create one with ident */
                        members = webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                  members,
                                                  (yyvsp[-5].text));

                        (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_INTERFACE,
                                             NULL,
                                             members);
                } else {
                        /* update the existing interface */

                        /* link member node into interfaces_node */
                        webidl_node_add(interface_node, members);

                        (yyval.node) = NULL; /* updating so no need to add a new node */
                }
        }
#line 1923 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 17:
#line 327 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = (yyvsp[0].node);
        }
#line 1931 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 20:
#line 342 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* extend interface with additional members */
            struct webidl_node *members;
            struct webidl_node *interface_node;

            interface_node = webidl_node_find_type_ident(*webidl_ast,
                                                     WEBIDL_NODE_TYPE_INTERFACE,
                                                     (yyvsp[-4].text));

            members = webidl_node_new(WEBIDL_NODE_TYPE_LIST, NULL, (yyvsp[-2].node));

            if (interface_node == NULL) {
                /* doesnt already exist so create it */

                members = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, members, (yyvsp[-4].text));

                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_INTERFACE, NULL, members);
            } else {
                /* update the existing interface */

                /* link member node into interfaces_node */
                webidl_node_add(interface_node, members);

                (yyval.node) = NULL; /* updating so no need to add a new node */
            }
        }
#line 1962 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 21:
#line 372 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL; /* empty */
        }
#line 1970 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 22:
#line 377 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* This needs to deal with members with the same
                 * identifier which indicate polymorphism. this is
                 * handled in the AST by adding the argument lists for
                 * each polymorphism to the same
                 * WEBIDL_NODE_TYPE_OPERATION
                 *
                 * @todo need to consider qualifer/stringifier compatibility
                 */
                struct webidl_node *member_node;
                struct webidl_node *ident_node;
                struct webidl_node *list_node;

                ident_node = webidl_node_find_type(webidl_node_getnode((yyvsp[0].node)),
                                                   NULL,
                                                   WEBIDL_NODE_TYPE_IDENT);

                list_node = webidl_node_find_type(webidl_node_getnode((yyvsp[0].node)),
                                                  NULL,
                                                  WEBIDL_NODE_TYPE_LIST);

                if (ident_node == NULL) {
                        /* something with no ident - possibly constructors? */
                        /* @todo understand this better */

                        (yyval.node) = webidl_node_prepend((yyvsp[-2].node), (yyvsp[0].node));

                } else if (list_node == NULL) {
                        /* member with no argument list, usually an
                         * attribute, cannot be polymorphic
                         */

                        /* add extended attributes to parameter list */
                        webidl_node_add((yyvsp[0].node), (yyvsp[-1].node));

                        (yyval.node) = webidl_node_prepend((yyvsp[-2].node), (yyvsp[0].node));

                } else {
                        /* add extended attributes to parameter list */
                        webidl_node_add(list_node, (yyvsp[-1].node));

                        /* has an arguemnt list so can be polymorphic */
                        member_node = webidl_node_find_type_ident(
                                              (yyvsp[-2].node),
                                              webidl_node_gettype((yyvsp[0].node)),
                                              webidl_node_gettext(ident_node));
                        if (member_node == NULL) {
                                /* not a member with that ident already present */
                                (yyval.node) = webidl_node_prepend((yyvsp[-2].node), (yyvsp[0].node));
                        } else {
                                webidl_node_add(member_node, list_node);
                                (yyval.node) = (yyvsp[-2].node); /* updated existing node do not add new one */
                        }
                }
        }
#line 2030 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 27:
#line 452 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* extend dictionary with additional members */
                struct webidl_node *dictionary_node;
                struct webidl_node *members = NULL;

                if ((yyvsp[-4].text) != NULL) {
                        members = webidl_node_new(WEBIDL_NODE_TYPE_INHERITANCE,
                                                  members,
                                                  (yyvsp[-4].text));
                }

                members = webidl_node_new(WEBIDL_NODE_TYPE_LIST, members, (yyvsp[-2].node));

                dictionary_node = webidl_node_find_type_ident(
                                         *webidl_ast,
                                         WEBIDL_NODE_TYPE_DICTIONARY,
                                         (yyvsp[-5].text));

                if (dictionary_node == NULL) {
                        /* no existing interface - create one with ident */
                        members = webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                  members,
                                                  (yyvsp[-5].text));

                        (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_DICTIONARY,
                                             NULL,
                                             members);
                } else {
                        /* update the existing interface */

                        /* link member node into interfaces_node */
                        webidl_node_add(dictionary_node, members);

                        (yyval.node) = NULL; /* updating so no need to add a new node */
                }
        }
#line 2071 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 28:
#line 492 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL; /* empty */
        }
#line 2079 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 29:
#line 497 "webidl-parser.y" /* yacc.c:1646  */
    {
                /** \todo handle ExtendedAttributeList */
                (yyval.node) = webidl_node_append((yyvsp[0].node), (yyvsp[-1].node));
        }
#line 2088 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 30:
#line 510 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *member;
            /* add name */
            member = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, NULL, (yyvsp[-1].text));
            /* add type node */
            member = webidl_node_prepend(member, (yyvsp[-2].node));

            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_ARGUMENT, NULL, member);
        }
#line 2102 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 31:
#line 521 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *member;
            /* add name */
            member = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, NULL, (yyvsp[-2].text));
            /* add default */
            member = webidl_node_new(WEBIDL_NODE_TYPE_OPTIONAL, member, (yyvsp[-1].node));
            /* add type node */
            member = webidl_node_prepend(member, (yyvsp[-3].node));

            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_ARGUMENT, NULL, member);
        }
#line 2118 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 32:
#line 549 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* extend dictionary with additional members */
                struct webidl_node *members;
                struct webidl_node *dictionary_node;

                dictionary_node = webidl_node_find_type_ident(
                                         *webidl_ast,
                                         WEBIDL_NODE_TYPE_DICTIONARY,
                                         (yyvsp[-4].text));

                members = webidl_node_new(WEBIDL_NODE_TYPE_LIST, NULL, (yyvsp[-2].node));

                if (dictionary_node == NULL) {
                        /* doesnt already exist so create it */

                        members = webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                  members,
                                                  (yyvsp[-4].text));

                        (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_DICTIONARY,
                                             NULL,
                                             members);
                } else {
                        /* update the existing dictionary */

                        /* link member node into dictionary node */
                        webidl_node_add(dictionary_node, members);

                        (yyval.node) = NULL; /* updating so no need to add a new node */
                }
        }
#line 2154 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 33:
#line 585 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2162 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 34:
#line 590 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = (yyvsp[0].node);
        }
#line 2170 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 36:
#line 601 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_LITERAL_STRING, NULL, (yyvsp[0].text));
        }
#line 2178 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 37:
#line 609 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = NULL;
        }
#line 2186 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 40:
#line 624 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = NULL;
        }
#line 2194 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 41:
#line 629 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = (yyvsp[0].text);
        }
#line 2202 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 42:
#line 637 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2210 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 48:
#line 667 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2218 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 49:
#line 675 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2226 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 50:
#line 683 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* extend interface with implements members */
            struct webidl_node *implements;
            struct webidl_node *interface_node;


            interface_node = webidl_node_find_type_ident(*webidl_ast,
                                                     WEBIDL_NODE_TYPE_INTERFACE,
                                                     (yyvsp[-3].text));

            implements = webidl_node_new(WEBIDL_NODE_TYPE_INTERFACE_IMPLEMENTS, NULL, (yyvsp[-1].text));

            if (interface_node == NULL) {
                /* interface doesnt already exist so create it */

                implements = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, implements, (yyvsp[-3].text));

                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_INTERFACE, NULL, implements);
            } else {
                /* update the existing interface */

                /* link implements node into interfaces_node */
                webidl_node_add(interface_node, implements);

                (yyval.node) = NULL; /* updating so no need to add a new node */
            }
        }
#line 2258 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 51:
#line 715 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *constant;

            constant = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, NULL, (yyvsp[-3].text));

            /* add constant type */
            constant = webidl_node_prepend(constant, (yyvsp[-4].node));

            /* add constant value */
            constant = webidl_node_prepend(constant, (yyvsp[-1].node));

            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_CONST, NULL, constant);
        }
#line 2276 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 54:
#line 737 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_LITERAL_INT,
                                            NULL,
                                            (yyvsp[0].value));
        }
#line 2286 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 55:
#line 744 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_LITERAL_NULL, NULL, NULL);
        }
#line 2294 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 56:
#line 752 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_LITERAL_BOOL,
                                            NULL,
                                            (int)true);
        }
#line 2304 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 57:
#line 759 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_LITERAL_BOOL,
                                            NULL,
                                            (int)false);
        }
#line 2314 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 58:
#line 769 "webidl-parser.y" /* yacc.c:1646  */
    {
                float *value;
                value = malloc(sizeof(float));
                *value = strtof((yyvsp[0].text), NULL);
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_LITERAL_FLOAT,
                                     NULL,
                                     value);
        }
#line 2327 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 59:
#line 779 "webidl-parser.y" /* yacc.c:1646  */
    {
                float *value;
                value = malloc(sizeof(float));
                *value = -INFINITY;
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_LITERAL_FLOAT,
                                     NULL,
                                     value);
        }
#line 2340 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 60:
#line 789 "webidl-parser.y" /* yacc.c:1646  */
    {
                float *value;
                value = malloc(sizeof(float));
                *value = INFINITY;
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_LITERAL_FLOAT,
                                     NULL,
                                     value);
        }
#line 2353 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 61:
#line 799 "webidl-parser.y" /* yacc.c:1646  */
    {
                float *value;
                value = malloc(sizeof(float));
                *value = NAN;
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_LITERAL_FLOAT,
                                     NULL,
                                     value);
        }
#line 2366 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 62:
#line 812 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = (yyvsp[0].node);
        }
#line 2374 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 66:
#line 826 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* @todo deal with stringifier */
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_OPERATION, NULL, (yyvsp[0].node));
        }
#line 2383 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 67:
#line 832 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node)=NULL;
        }
#line 2391 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 68:
#line 842 "webidl-parser.y" /* yacc.c:1646  */
    {
                struct webidl_node *attribute;

                attribute = (yyvsp[0].node);

                /* deal with inherit modifier */
                if ((yyvsp[-2].isit)) {
                        attribute = webidl_new_number_node(
                                          WEBIDL_NODE_TYPE_MODIFIER,
                                          attribute,
                                          WEBIDL_TYPE_MODIFIER_INHERIT);
                }

                /* deal with readonly modifier */
                if ((yyvsp[-1].isit)) {
                        attribute = webidl_new_number_node(
                                         WEBIDL_NODE_TYPE_MODIFIER,
                                         attribute,
                                         WEBIDL_TYPE_MODIFIER_READONLY);
                }

                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_ATTRIBUTE,
                                     NULL,
                                     attribute);
        }
#line 2421 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 69:
#line 873 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = (yyvsp[0].node);
        }
#line 2429 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 70:
#line 882 "webidl-parser.y" /* yacc.c:1646  */
    {
                struct webidl_node *attribute;

                attribute = webidl_new_number_node(WEBIDL_NODE_TYPE_MODIFIER,
                                                   (yyvsp[0].node),
                                                   WEBIDL_TYPE_MODIFIER_STATIC);

                /* deal with readonly modifier */
                if ((yyvsp[-1].isit)) {
                        attribute = webidl_new_number_node(
                                         WEBIDL_NODE_TYPE_MODIFIER,
                                         attribute,
                                         WEBIDL_TYPE_MODIFIER_READONLY);
                }

                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_ATTRIBUTE,
                                     NULL,
                                     attribute);
        }
#line 2453 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 71:
#line 903 "webidl-parser.y" /* yacc.c:1646  */
    {
                struct webidl_node *operation;

                /* add static modifier */
                operation = webidl_new_number_node(WEBIDL_NODE_TYPE_MODIFIER,
                                                   (yyvsp[0].node),
                                                   WEBIDL_TYPE_MODIFIER_STATIC);

                /* put return type on the operation */
                operation = webidl_node_prepend((yyvsp[-1].node), operation);

                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_OPERATION,
                                     NULL,
                                     operation);
        }
#line 2473 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 72:
#line 924 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, (yyvsp[-2].node), (yyvsp[-1].text));
        }
#line 2481 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 75:
#line 939 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("required");
        }
#line 2489 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 76:
#line 948 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.isit) = false;
        }
#line 2497 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 77:
#line 953 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.isit) = true;
        }
#line 2505 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 78:
#line 964 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.isit) = false;
        }
#line 2513 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 79:
#line 969 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.isit) = true;
        }
#line 2521 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 80:
#line 978 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* put return type on the operation */
                (yyvsp[0].node) = webidl_node_prepend((yyvsp[-1].node), (yyvsp[0].node));

                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_OPERATION, NULL, (yyvsp[0].node));
        }
#line 2532 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 81:
#line 986 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_OPERATION, NULL, (yyvsp[0].node));
        }
#line 2540 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 82:
#line 994 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* put return type on the operation */
                (yyval.node) = webidl_node_prepend((yyvsp[0].node), (yyvsp[-1].node));

                /* specials */
                (yyval.node) = webidl_node_prepend((yyval.node), (yyvsp[-2].node));

                /* special */
                (yyval.node) = webidl_node_prepend((yyval.node), (yyvsp[-3].node));
        }
#line 2555 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 83:
#line 1009 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2563 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 84:
#line 1014 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_prepend((yyvsp[0].node), (yyvsp[-1].node));
        }
#line 2571 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 85:
#line 1022 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_SPECIAL,
                                            NULL,
                                            WEBIDL_TYPE_SPECIAL_GETTER);
        }
#line 2581 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 86:
#line 1029 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_SPECIAL,
                                            NULL,
                                            WEBIDL_TYPE_SPECIAL_SETTER);
        }
#line 2591 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 87:
#line 1036 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* second edition removed this special but the
                 * specifications still use it!
                 */
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_SPECIAL,
                                            NULL,
                                            WEBIDL_TYPE_SPECIAL_CREATOR);
        }
#line 2604 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 88:
#line 1046 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_SPECIAL,
                                            NULL,
                                            WEBIDL_TYPE_SPECIAL_DELETER);
        }
#line 2614 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 89:
#line 1053 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_SPECIAL,
                                            NULL,
                                            WEBIDL_TYPE_SPECIAL_LEGACYCALLER);
        }
#line 2624 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 90:
#line 1063 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* argument list */
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_LIST, NULL, (yyvsp[-2].node));

                (yyval.node) = webidl_node_prepend((yyvsp[-4].node), (yyval.node)); /* identifier */
        }
#line 2635 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 91:
#line 1074 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2643 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 92:
#line 1079 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, NULL, (yyvsp[0].text));
        }
#line 2651 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 93:
#line 1090 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2659 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 94:
#line 1095 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_append((yyvsp[0].node), (yyvsp[-1].node));
        }
#line 2667 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 95:
#line 1103 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2675 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 96:
#line 1108 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_append((yyvsp[0].node), (yyvsp[-1].node));
        }
#line 2683 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 97:
#line 1117 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = (yyvsp[0].node);
        }
#line 2691 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 98:
#line 1125 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *argument;
            argument = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, NULL, (yyvsp[-1].text));
            argument = webidl_node_new(WEBIDL_NODE_TYPE_OPTIONAL, argument, (yyvsp[0].node));
            argument = webidl_node_prepend(argument, (yyvsp[-2].node)); /* add type node */
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_ARGUMENT, NULL, argument);
        }
#line 2703 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 99:
#line 1134 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *argument;
            argument = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, NULL, (yyvsp[0].text));
            argument = webidl_node_prepend(argument, (yyvsp[-1].node)); /* ellipsis node */
            argument = webidl_node_prepend(argument, (yyvsp[-2].node)); /* add type node */
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_ARGUMENT, NULL, argument);
        }
#line 2715 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 102:
#line 1153 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2723 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 103:
#line 1158 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_ELLIPSIS, NULL, NULL);
        }
#line 2731 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 104:
#line 1166 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2739 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 105:
#line 1171 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2747 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 106:
#line 1179 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2755 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 107:
#line 1184 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2763 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 111:
#line 1204 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2771 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 112:
#line 1209 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE,
                                     (yyvsp[-1].node),
                                     (yyvsp[-2].node));
        }
#line 2781 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 113:
#line 1219 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2789 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 114:
#line 1224 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE,
                                     (yyvsp[0].node),
                                     (yyvsp[-1].node));
        }
#line 2799 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 115:
#line 1236 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE, (yyvsp[0].node), (yyvsp[-2].node));
        }
#line 2807 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 116:
#line 1241 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* @todo should be a WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE_SQUARE */
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE, (yyvsp[0].node), (yyvsp[-2].node));
        }
#line 2816 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 117:
#line 1247 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* @todo should be a WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE_CURLY */
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE, (yyvsp[0].node), (yyvsp[-2].node));
        }
#line 2825 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 118:
#line 1253 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* Constructor */
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                     NULL,
                                     strdup("Constructor"));
        }
#line 2836 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 119:
#line 1261 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* Constructor */
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_OPERATION,
                                     webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                     NULL,
                                                     strdup("Constructor")),
                                     webidl_node_new(WEBIDL_NODE_TYPE_LIST,
                                                     NULL,
                                                     (yyvsp[-1].node)));
        }
#line 2851 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 120:
#line 1273 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* Constructor */
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_OPERATION,
                                     webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                     NULL,
                                                     strdup("NamedConstructor")),
                                     webidl_node_new(WEBIDL_NODE_TYPE_LIST,
                                                     webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                                     NULL,
                                                                     (yyvsp[-3].text)),
                                                     (yyvsp[-1].node)));
        }
#line 2868 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 121:
#line 1287 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_append((yyvsp[0].node),
                                        webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                        NULL,
                                                        (yyvsp[-1].text)));
        }
#line 2879 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 122:
#line 1298 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2887 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 123:
#line 1303 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = (yyvsp[0].node);
        }
#line 2895 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 124:
#line 1311 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 2903 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 125:
#line 1316 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_prepend(
                        webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE,
                                        NULL,
                                        (yyvsp[-2].node)),
                        (yyvsp[0].node));
        }
#line 2915 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 126:
#line 1325 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* @todo should be a WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE_SQUARE */
            (yyval.node) = webidl_node_prepend(
                     webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE,
                                     NULL,
                                     (yyvsp[-2].node)),
                     (yyvsp[0].node));
        }
#line 2928 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 127:
#line 1335 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* @todo should be a WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE_CURLY */
            (yyval.node) = webidl_node_prepend(
                     webidl_node_new(WEBIDL_NODE_TYPE_EXTENDED_ATTRIBUTE,
                                     NULL,
                                     (yyvsp[-2].node)),
                     (yyvsp[0].node));
        }
#line 2941 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 128:
#line 1345 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_append((yyvsp[0].node),
                                        webidl_node_new(WEBIDL_NODE_TYPE_IDENT,
                                                        NULL,
                                                        (yyvsp[-1].text)));
        }
#line 2952 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 129:
#line 1356 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* @todo loosing base info here might break the attribute */
                (yyval.text) = calloc(1, 32);
                snprintf((yyval.text), 32, "%ld", (yyvsp[0].value));
        }
#line 2962 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 130:
#line 1363 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = (yyvsp[0].text);
        }
#line 2970 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 131:
#line 1368 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = (yyvsp[0].text);
        }
#line 2978 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 132:
#line 1373 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = (yyvsp[0].text);
        }
#line 2986 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 133:
#line 1378 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = (yyvsp[0].text);
        }
#line 2994 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 134:
#line 1383 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("-");
        }
#line 3002 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 135:
#line 1388 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup(".");
        }
#line 3010 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 136:
#line 1393 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("...");
        }
#line 3018 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 137:
#line 1398 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup(":");
        }
#line 3026 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 138:
#line 1403 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup(";");
        }
#line 3034 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 139:
#line 1408 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("<");
        }
#line 3042 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 140:
#line 1413 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("=");
        }
#line 3050 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 141:
#line 1418 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup(">");
        }
#line 3058 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 142:
#line 1423 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("?");
        }
#line 3066 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 143:
#line 1428 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("Date");
        }
#line 3074 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 144:
#line 1433 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("DOMString");
        }
#line 3082 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 145:
#line 1438 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("Infinity");
        }
#line 3090 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 146:
#line 1443 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("NaN");
        }
#line 3098 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 147:
#line 1448 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("any");
        }
#line 3106 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 148:
#line 1453 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("boolean");
        }
#line 3114 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 149:
#line 1458 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("byte");
        }
#line 3122 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 150:
#line 1463 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("double");
        }
#line 3130 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 151:
#line 1468 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.text) = strdup("false");
        }
#line 3138 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 152:
#line 1473 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("float");
        }
#line 3146 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 153:
#line 1478 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("long");
        }
#line 3154 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 154:
#line 1483 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("null");
        }
#line 3162 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 155:
#line 1488 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("object");
        }
#line 3170 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 156:
#line 1493 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("octet");
        }
#line 3178 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 157:
#line 1498 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("or");
        }
#line 3186 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 158:
#line 1503 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("optional");
        }
#line 3194 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 159:
#line 1508 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("sequence");
        }
#line 3202 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 160:
#line 1513 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("short");
        }
#line 3210 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 161:
#line 1518 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("true");
        }
#line 3218 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 162:
#line 1523 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("unsigned");
        }
#line 3226 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 163:
#line 1528 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("void");
        }
#line 3234 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 164:
#line 1533 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = (yyvsp[0].text);
        }
#line 3242 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 165:
#line 1543 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("attribute");
        }
#line 3250 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 166:
#line 1548 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("callback");
        }
#line 3258 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 167:
#line 1553 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("const");
        }
#line 3266 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 168:
#line 1558 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("creator");
        }
#line 3274 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 169:
#line 1563 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("deleter");
        }
#line 3282 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 170:
#line 1568 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("dictionary");
        }
#line 3290 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 171:
#line 1573 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("enum");
        }
#line 3298 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 172:
#line 1578 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("exception");
        }
#line 3306 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 173:
#line 1583 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("getter");
        }
#line 3314 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 174:
#line 1588 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("implements");
        }
#line 3322 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 175:
#line 1593 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("inherit");
        }
#line 3330 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 176:
#line 1598 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("interface");
        }
#line 3338 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 177:
#line 1603 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("iterable");
        }
#line 3346 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 178:
#line 1608 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("legacycaller");
        }
#line 3354 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 179:
#line 1613 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("legacyiterable");
        }
#line 3362 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 180:
#line 1618 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("partial");
        }
#line 3370 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 181:
#line 1623 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("required");
        }
#line 3378 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 182:
#line 1628 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("setter");
        }
#line 3386 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 183:
#line 1633 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("static");
        }
#line 3394 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 184:
#line 1638 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("stringifier");
        }
#line 3402 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 185:
#line 1643 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("typedef");
        }
#line 3410 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 186:
#line 1648 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup("unrestricted");
        }
#line 3418 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 187:
#line 1656 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = (yyvsp[0].text);
        }
#line 3426 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 188:
#line 1661 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.text) = strdup(",");
        }
#line 3434 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 189:
#line 1669 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE, NULL, (yyvsp[0].node));
        }
#line 3442 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 190:
#line 1674 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* todo handle suffix */
            (yyval.node) = (yyvsp[-1].node);
        }
#line 3451 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 192:
#line 1685 "webidl-parser.y" /* yacc.c:1646  */
    {
                /* todo deal with TypeSuffixStartingWithArray */
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                            NULL,
                                            WEBIDL_TYPE_ANY);
        }
#line 3462 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 193:
#line 1696 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_prepend((yyvsp[-4].node), webidl_node_prepend((yyvsp[-2].node), (yyvsp[-1].node)));
        }
#line 3470 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 194:
#line 1704 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE, NULL, (yyvsp[0].node));
        }
#line 3478 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 195:
#line 1709 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* todo handle suffix */
            (yyval.node) = (yyvsp[-1].node);
        }
#line 3487 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 196:
#line 1715 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 3495 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 197:
#line 1723 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = NULL;
        }
#line 3503 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 198:
#line 1728 "webidl-parser.y" /* yacc.c:1646  */
    {
                (yyval.node) = webidl_node_prepend((yyvsp[-1].node), (yyvsp[0].node));
        }
#line 3511 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 199:
#line 1739 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_prepend((yyvsp[-1].node), (yyvsp[0].node));
        }
#line 3519 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 200:
#line 1744 "webidl-parser.y" /* yacc.c:1646  */
    {
            /* second edition adds promise types */
            (yyval.node) = webidl_node_prepend((yyvsp[-1].node), (yyvsp[0].node));
        }
#line 3528 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 201:
#line 1750 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        (yyvsp[0].node),
                                        WEBIDL_TYPE_STRING);
        }
#line 3538 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 202:
#line 1757 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *type;
            type = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                          (yyvsp[0].node),
                                          WEBIDL_TYPE_USER);
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, type, (yyvsp[-1].text));
        }
#line 3550 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 203:
#line 1766 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        (yyvsp[-2].node),
                                        WEBIDL_TYPE_SEQUENCE);
        }
#line 3560 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 204:
#line 1773 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        (yyvsp[0].node),
                                        WEBIDL_TYPE_OBJECT);
        }
#line 3570 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 205:
#line 1780 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        (yyvsp[0].node),
                                        WEBIDL_TYPE_DATE);
        }
#line 3580 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 206:
#line 1790 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE, NULL, (yyvsp[-1].node));
        }
#line 3588 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 207:
#line 1795 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *type;
            type = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                          NULL,
                                          WEBIDL_TYPE_USER);
            type = webidl_node_new(WEBIDL_NODE_TYPE_IDENT, type, (yyvsp[-1].text));
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE, NULL, type);
        }
#line 3601 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 210:
#line 1813 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        NULL,
                                        WEBIDL_TYPE_BOOL);
        }
#line 3611 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 211:
#line 1820 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        NULL,
                                        WEBIDL_TYPE_BYTE);
        }
#line 3621 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 212:
#line 1827 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        NULL,
                                        WEBIDL_TYPE_OCTET);
        }
#line 3631 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 213:
#line 1837 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_MODIFIER,
                                        (yyvsp[0].node),
                                        WEBIDL_TYPE_MODIFIER_UNRESTRICTED);
        }
#line 3641 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 215:
#line 1849 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        NULL,
                                        WEBIDL_TYPE_FLOAT);
        }
#line 3651 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 216:
#line 1856 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        NULL,
                                        WEBIDL_TYPE_DOUBLE);
        }
#line 3661 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 217:
#line 1866 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_MODIFIER,
                                        (yyvsp[0].node),
                                        WEBIDL_TYPE_MODIFIER_UNSIGNED);
        }
#line 3671 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 219:
#line 1878 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                        NULL,
                                        WEBIDL_TYPE_SHORT);
        }
#line 3681 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 220:
#line 1885 "webidl-parser.y" /* yacc.c:1646  */
    {
            if ((yyvsp[0].isit)) {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                            NULL,
                                            WEBIDL_TYPE_LONGLONG);
            } else {
                (yyval.node) = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                            NULL,
                                            WEBIDL_TYPE_LONG);
            }
        }
#line 3697 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 221:
#line 1901 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.isit) = false;
        }
#line 3705 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 222:
#line 1906 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.isit) = true;
        }
#line 3713 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 223:
#line 1914 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = NULL;
        }
#line 3721 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 224:
#line 1922 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = NULL;
        }
#line 3729 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 225:
#line 1927 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE_ARRAY, (yyvsp[0].node), NULL);
        }
#line 3737 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 226:
#line 1932 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE_NULLABLE, (yyvsp[0].node), NULL);
        }
#line 3745 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 227:
#line 1940 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = NULL;
        }
#line 3753 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 228:
#line 1945 "webidl-parser.y" /* yacc.c:1646  */
    {
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE_ARRAY, (yyvsp[0].node), NULL);
        }
#line 3761 "webidl-parser.c" /* yacc.c:1646  */
    break;

  case 232:
#line 1962 "webidl-parser.y" /* yacc.c:1646  */
    {
            struct webidl_node *type;
            type = webidl_new_number_node(WEBIDL_NODE_TYPE_TYPE_BASE,
                                          NULL,
                                          WEBIDL_TYPE_VOID);
            (yyval.node) = webidl_node_new(WEBIDL_NODE_TYPE_TYPE, NULL, type);
        }
#line 3773 "webidl-parser.c" /* yacc.c:1646  */
    break;


#line 3777 "webidl-parser.c" /* yacc.c:1646  */
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
      yyerror (&yylloc, webidl_ast, YY_("syntax error"));
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
        yyerror (&yylloc, webidl_ast, yymsgp);
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
                      yytoken, &yylval, &yylloc, webidl_ast);
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
                  yystos[yystate], yyvsp, yylsp, webidl_ast);
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
  yyerror (&yylloc, webidl_ast, YY_("memory exhausted"));
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
                  yytoken, &yylval, &yylloc, webidl_ast);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp, yylsp, webidl_ast);
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
#line 1972 "webidl-parser.y" /* yacc.c:1906  */


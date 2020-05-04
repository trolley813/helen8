#include <stdarg.h>
#include <stdio.h>

extern int yylineno;
struct h8_ast;

void yyerror(struct h8_ast *a, char *s, ...) {
  va_list ap;
  va_start(ap, s);
  fprintf(stderr, "%d: error: ", yylineno);
  vfprintf(stderr, s, ap);
  fprintf(stderr, "\n");
}
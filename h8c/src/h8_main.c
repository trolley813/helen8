#include "h8_ast.h"
#include "h8_parser.tab.h"
#include <stdio.h>

extern FILE *yyin;

int main(int argc, char **argv) {
  if (argc == 1) {
    fprintf(stderr, "Usage: h8c FILE");
    return 1;
  }
  yyin = fopen(argv[1], "r");
  if (!yyin) {
    fprintf(stderr, "Unable to open file %s", argv[1]);
    return 1;
  }
  h8_ast *result_ast;
  yyparse(result_ast);
  return 0;
}
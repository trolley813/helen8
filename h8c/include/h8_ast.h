#ifndef H8_AST_H
#define H8_AST_H

#include <stddef.h>

typedef enum h8_ast_type {
  H8_AST_DUMMY,
  H8_AST_TYPENAME,
  H8_AST_IDENTIFIER,
  H8_AST_INTEGER,
  H8_AST_FUNCTION_CALL,
} h8_ast_type;

typedef struct h8_ast {
  h8_ast_type type;
  void *data;
  size_t data_size;
  size_t children_count;
  struct h8_ast **children;
} h8_ast;

h8_ast *h8_ast_new(h8_ast_type type, void *data, size_t data_size,
                   size_t children_count, ...);

void h8_ast_free(h8_ast *ast);

#endif
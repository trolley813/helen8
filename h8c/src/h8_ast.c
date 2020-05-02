#include <h8_ast.h>
#include <stdarg.h>
#include <stddef.h>

h8_ast *h8_ast_new(h8_ast_type type, void *data, size_t data_size,
                   size_t children_count, ...) {
  h8_ast *result = malloc(sizeof(h8_ast));
  result->type = type;
  result->children_count = children_count;
  result->data = data;
  result->data_size = data_size;
  if (children_count) {
    result->children = malloc(children_count * sizeof(h8_ast *));
  }
  va_list args;
  va_start(args, children_count);
  for (size_t idx = 0; idx < children_count; idx++) {
    h8_ast *arg = va_arg(args, h8_ast *);
    result->children[idx] = arg;
  }
  va_end(args);
}

void h8_ast_free(h8_ast *ast) {
  for (size_t idx = 0; idx < ast->children_count; idx++) {
    h8_ast_free(ast->children[idx]);
  }
  if (ast->children_count) {
    free(ast->children);
  }
  if (ast->data_size) {
    free(ast->data);
  }
  /* safety first */
  ast->data = NULL;
  ast->children = NULL;
  ast->data_size = 0;
  ast->children_count = 0;
  ast->type = H8_AST_DUMMY;
}
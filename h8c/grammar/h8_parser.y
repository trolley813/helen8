%{
#include <stdint.h>
#include <string.h>
#include <h8_lexer.h>
#include <h8_ast.h>

%}
%token TYPENAME IDENTIFIER INTEGER REAL
%token VAR
%token COLON EQUALS NEWLINE COMMA LPAREN RPAREN
%token OPERATOR0 OPERATOR1 OPERATOR2 OPERATOR3 OPERATOR4
%token OPERATOR5 OPERATOR6 OPERATOR7 OPERATOR8 OPERATOR9
%start program
%parse-param {h8_ast* result}
%union {
  long long intval;
  double dblval;
  char* strval;
  struct h8_ast *astval;
  struct {
    h8_ast** data;
    unsigned count;
  } *astlistval;
}

%left OPERATOR0 EQUALS
%left OPERATOR1
%left OPERATOR2
%left OPERATOR3
%left OPERATOR4
%left OPERATOR5
%left OPERATOR6 COLON
%left OPERATOR7
%left OPERATOR8
%left OPERATOR9

%type<astval> expression function_call
%type<strval> OPERATOR0 OPERATOR1 OPERATOR2 OPERATOR3 OPERATOR4
%type<strval> OPERATOR5 OPERATOR6 OPERATOR7 OPERATOR8 OPERATOR9
%type<dblval> REAL
%type<intval> INTEGER
%type<strval> IDENTIFIER TYPENAME
%type<astlistval> expr_list
%%

program: /* empty */
  | statement
  | program NEWLINE statement;

statement: var_init
  | var_decl;

var_init: VAR IDENTIFIER COLON TYPENAME EQUALS expression;

var_decl: VAR IDENTIFIER COLON TYPENAME;

expression: REAL { $$ = h8_ast_new(H8_AST_REAL, &$1, sizeof(double), 0); }
  | INTEGER { $$ = h8_ast_new(H8_AST_INTEGER, &$1, sizeof(long long), 0); }
  | IDENTIFIER { $$ = h8_ast_new(H8_AST_IDENTIFIER, strdup($1), strlen($1) + 1, 0); }
  | function_call
  | expression OPERATOR0 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression EQUALS    expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup("="), 2, 2, $1, $3); }
  | expression OPERATOR1 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression OPERATOR2 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression OPERATOR3 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression OPERATOR4 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression OPERATOR5 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression OPERATOR6 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression COLON     expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup(":"), 2, 2, $1, $3); }
  | expression OPERATOR7 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression OPERATOR8 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
  | expression OPERATOR9 expression { $$ = h8_ast_new(H8_AST_FUNCTION_CALL, strdup($2), strlen($2) + 1, 2, $1, $3); }
;

function_call: IDENTIFIER LPAREN expr_list RPAREN { 
  $$ = h8_ast_new_from_array(H8_AST_FUNCTION_CALL, strdup($1), strlen($1) + 1, $3->count, $3->data); 
};

expr_list: /* empty */
  | expression
  | expr_list COMMA expression;

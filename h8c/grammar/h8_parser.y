%{
#include <stdint.h>
#include <h8_lexer.h>
#include <h8_ast.h>

%}
%token TYPENAME IDENTIFIER INTEGER REAL
%token VAR
%token COLON EQUALS NEWLINE COMMA LPAREN RPAREN
%token OPERATOR0 OPERATOR1 OPERATOR2 OPERATOR3 OPERATOR4
%token OPERATOR5 OPERATOR6 OPERATOR7 OPERATOR8 OPERATOR9
%start program
%parse-param {h8_ast** result}
%union {
  long long intval;
  double dblval;
  char* strval;
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
%%

program: /* empty */
  | statement
  | program NEWLINE statement

statement: var_init
  | var_decl

var_init: VAR IDENTIFIER COLON TYPENAME EQUALS expression

var_decl: VAR IDENTIFIER COLON TYPENAME

expression: REAL 
  | INTEGER
  | IDENTIFIER
  | function_call
  | expression OPERATOR0 expression
  | expression EQUALS    expression
  | expression OPERATOR1 expression
  | expression OPERATOR2 expression
  | expression OPERATOR3 expression
  | expression OPERATOR4 expression
  | expression OPERATOR5 expression
  | expression OPERATOR6 expression
  | expression COLON     expression
  | expression OPERATOR7 expression
  | expression OPERATOR8 expression
  | expression OPERATOR9 expression

function_call: IDENTIFIER LPAREN expr_list RPAREN

expr_list: /* empty */
  | expression
  | expr_list COMMA expression

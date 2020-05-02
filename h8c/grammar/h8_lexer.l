%{
#include "h8_ast.h"
#include "h8_parser.tab.h"
%}
%option noyywrap yylineno

DIGIT [0-9]
ALNUM [A-Za-z0-9]
OPCHAR [\?\*/%\+\-:=!<>&\^|]

%%
"var" {
    return VAR;
}
[A-Z]{ALNUM}* { 
    yylval.strval = strdup(yytext);
    return TYPENAME; 
}
[a-z]{ALNUM}* { 
    yylval.strval = strdup(yytext);
    return IDENTIFIER;
}
{DIGIT}+.{DIGIT}+([Ee]{DIGIT}+)? {
    yylval.dblval = atof(yytext);
    return REAL;
}
({DIGIT}+$)?(\+\-)?{ALNUM}+ {
    char* hash_pos = strtok(yytext, "#");
    if (hash_pos) {
        int base = strtoll(yytext, NULL, 0);
        yylval.intval = strtoll(hash_pos, NULL, base);
    }
    else {
        yylval.intval = atoll(yytext);
    }
    return INTEGER;
}
[ \t\r]+ {
    /* do nothing, skipping whitespace */
}
\n {
    return NEWLINE;
}
"#".*  { 
    /* do nothing, it's a comment */
}
":" {
    return COLON; /* behaves as OPERATOR6 but can have different sense */
}
"=" {
    return EQUALS; /* behaves as OPERATOR0 but can have different sense */
}
[<>]= {
    return OPERATOR4;
}
!= {
    return OPERATOR5;
}
[\?\*/%\+\-:!<>&\^|]{OPCHAR}*= {
    return OPERATOR0;
}
\?{OPCHAR}* {
    return OPERATOR9;
}
[\*/%]{OPCHAR}* {
    return OPERATOR8;
}
[\+\-]{OPCHAR}* {
    return OPERATOR7;
}
:{OPCHAR}+ {
    return OPERATOR6;
}
={OPCHAR}+ {
    return OPERATOR5;
}
!{OPCHAR}* {
    return OPERATOR5;
}
[<>]{OPCHAR}* {
    return OPERATOR4;
}
&{OPCHAR}* {
    return OPERATOR3;
}
\^{OPCHAR}* {
    return OPERATOR2;
}
\|{OPCHAR}* {
    return OPERATOR1;
}
"," {
    return COMMA;
}
"(" {
    return LPAREN;
}
")" {
    return RPAREN;
}
. { yyerror(NULL, "unknown character: %s", yytext); }
%%
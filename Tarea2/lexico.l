%option noyywrap
%{
#include "parser.h"
#include <iostream> //libreria para imprimir en cosola de C
%}
digito [0-9]
Numero {digito}+
%%
[+]             { strcpy(yylval.TEXT, yytext); return mas; }
[-]             { strcpy(yylval.TEXT, yytext); return menos; }
[*]             { strcpy(yylval.TEXT, yytext); return por; }
[/]             { strcpy(yylval.TEXT, yytext); return dv; }
[(]             { strcpy(yylval.TEXT, yytext); return apar; }
[)]             { strcpy(yylval.TEXT, yytext); return cpar; }
[\^]             { strcpy(yylval.TEXT, yytext); return elev; }
{Numero}        { strcpy(yylval.TEXT, yytext); return Nnum; }
.               {std::cout <<yytext<<"Error Lexico "<< std::endl;}
%%

%{
#include "scanner.h"//se importa el header del analisis sintactico

#include <iostream> //libreria para imprimir en cosola de C

#include <string> //libreria para manejo de STRINGS de QT

extern int yylineno; //linea actual donde se encuentra el parser (analisis lexico) lo maneja BISON
extern char *yytext; //lexema actual donde esta el parser (analisis lexico) lo maneja BISON

int yyerror(const char* mens){
//metodo que se llama al haber un error sintactico
//SE IMPRIME EN CONSOLA EL ERROR
std::cout <<mens<<" "<<yytext<< std::endl;
return 0;
}

struct Operador{
//ESTRUCTURA LA CUAL CONTENDRA LOS TIPOS DE LOS NO TERMINALES PARA HEREDAR VALORES
std::string texto;
int valor;
};

%}
//error-verbose si se especifica la opcion los errores sintacticos son especificados por BISON
%error-verbose

%union{
//se especifican los tipo de valores para los no terminales y lo terminales
char TEXT [256];
struct Operador * VAL;
}
//TERMINALES DE TIPO TEXT, SON STRINGS
%token<TEXT> Nnum
%token mas
%token menos
%token por
%token dv
%token apar
%token cpar
%token elev
//NO TERMINALES DE TIPO VAL, POSEEN ATRIBUTOS INT VALOR, Y QSTRING TEXTO
%type<VAL>  E
%type<VAL>  S
//LOS NO TERMINALES PUEDEN SER DE DIFERENTE TIPO, LOS TERMINALES SIEMPRE SON STRINGS O NO SE ESPECIFICA TIPO
//PRECEDENCIA DE LOS OPERADORES PARA QUITAR LA AMBIGUEDAD DEN LA GRAMTICA
%left mas menos
%left por dv

%%
S : E{ std::cout <<"Salida: "<<$$->texto<<" = "<<$$->valor<< std::endl; };

E : E mas E{
        //OPERACION MAS
        $$=$1;//EL VALOR DE E ES IGUAL E1, PARA NO DESPERDICIAR MEMORIA
        $$->valor = $1->valor + $3->valor; //SE MULTIPLICAN LOS VALORES E=E1+E2
        $$->texto = $1->texto + "+" +$3->texto;
    }

    |E por E{
        //OPERACION POR
        $$=$1;//EL VALOR DE E ES IGUAL E1, PARA NO DESPERDICIAR MEMORIA
        $$->valor = $1->valor * $3->valor; //SE MULTIPLICAN LOS VALORES E=E1*E2
        $$->texto = $1->texto + "*" +$3->texto;
    }

    |E menos E{
        //OPERACION MENOS
        $$=$1;//EL VALOR DE E ES IGUAL E1, PARA NO DESPERDICIAR MEMORIA
        $$->valor = $1->valor - $3->valor; //SE RESTAN LOS VALORES E=E1-E2
        $$->texto = $1->texto + "-" +$3->texto;
    }

    |E dv E{
        //OPERACION DIVISION
        $$=$1;//EL VALOR DE E ES IGUAL E1, PARA NO DESPERDICIAR MEMORIA
        $$->valor = $1->valor / $3->valor; //SE DIVIDEN LOS VALORES E=E1-E2
        $$->texto = $1->texto + "/" +$3->texto;
    }


    |Nnum{
        $$=new Operador(); //$$ EQUIVALE AL VALOR DE E
        std::string temp = $1;
        $$->valor= std::stoi(temp);
        $$->texto= temp;
    };

%%

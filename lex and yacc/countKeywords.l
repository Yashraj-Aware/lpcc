/*Lex program to display keywords , numbers and words*/

/*global declaration*/
%{
    #include<stdio.h>
    int yywrap(void);
    int yyerror(char *errormsg);
%}

/*Production rules*/

%%
if |
else |
printf {printf("\n%s is a keyword", yytext);}
[0-9]+ {printf("\n%s is a number", yytext);}
[a-zA-Z]+ {printf("\n%s is a word", yytext);}
.|\n {ECHO;}

%%

int main()
{
    yylex();
    printf("Enter the input");
}

int yywrap(void)
{
    return 0;
}

int yyerror(char *errormsg)
{
    fprintf(stderr, "%s\n", errormsg);
    exit(1);
}
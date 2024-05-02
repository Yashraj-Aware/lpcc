/*Identify capital words*/
%{
    #include<stdio.h>
    int yywrap(void);
    int yyerror(char *errormsg);
%}



%%

[A-Z]+[ \t\n] {printf("%s\n", yytext);}
. {}

%%




int main()
{
    printf("input \n");
    yylex();
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
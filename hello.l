%{
    #include <stdio.h>
    int yywrap(void);
    int yyerror(char *errormsg);
    int count = 0;
%}
/**/
%%
[0-9]+  {printf("got NUMBER");}
[\t ]   { }
\n      {printf("got new line"); count++;}

%%

int main(){
    yylex();

    printf("line count: %d\n", yytext);
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
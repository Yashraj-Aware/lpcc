%{
    #include<stdio.h>
    int yywrap(void);
    int yyerror(char *errormsg);
%}

%%
^the$  {printf("Article\n");}
^a$    {printf("Article\n");}
^an$   {printf("Article\n");}
^[A-Za-z]+(ed|ing)$   {printf("Verb\n");}
^[A-za-z]+(es|s)$     {printf("Noun\n");}
^[A-Za-z]+ly$         {printf("AdVerb\n");}
^[A-Za-z]+(able|ible)$  {printf("Adjective\n");}
^[A-Za-z]+(ment|tion)$   {printf("Noun\n");}
^[A-Za-z]+$                {printf("Noun\n");}
.                           {printf("Symbol\n");}
%%

int main()
{
    yyin = fopen("input.txt","r");
    yylex();
    fclose(yyin);
    return 0;
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
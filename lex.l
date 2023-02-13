%{
#include <stdio.h>
#include <stdlib.h>

#include "y.tab.h"

void yyerror(char *);
%}

DIGIT	[0-9]
ID	[a-zA-Z_]

%%
[a-zA-Z_]	{
	yylval = *yytext;
	return VAR;
}


[0-9]+	{
	yylval = atoi(yytext);
	return INT;
}

[-+()=*/\n]	{
	return *yytext;
} 

[ \t]	{}

.	yyerror("invalid char");
%%

int yywrap() {
	return 1;
}

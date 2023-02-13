%token INT VAR
%left '+' '-'
%left '*' '/'

%{
	#include <stdio.h>

	void yyerror(char *);
	int yylex(void);
	int sym[256];
%}

%%
program:
	program statement '\n'
	|
	;

statement:
	 expr { printf("Result: %d\n", $1); }
	 | VAR '=' expr { sym[$1] = $3; }
	 |
	 ;

expr:
	INT
	| VAR { $$ = sym[$1]; }
	| expr '+' expr { $$ = $1 + $3; } 
	| expr '-' expr { $$ = $1 - $3; }
	| expr '*' expr { $$ = $1 * $3; }
	| expr '/' expr { $$ = $1 / $3; }
	| '(' expr ')' { $$ = $2; }
	;
%%
void yyerror(char *s) {
	fprintf(stderr, "%s\n", s);
}

int main(void) {
	yyparse();
	return 0;
}

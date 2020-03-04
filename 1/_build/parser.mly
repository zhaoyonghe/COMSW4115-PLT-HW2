%{ open Ast %}

%token SEMI PLUS MINUS TIMES DIVIDE EOF ASSIGN
%token <int> LITERAL
%token <string> VARIABLE

%right SEMI
%right ASSIGN
%left PLUS MINUS
%left TIMES DIVIDE

%start expr
%type <Ast.expr> expr

%%

expr:
	  expr SEMI expr { Seq ($1, $3) }
	| expr PLUS expr { Binop ($1, Add, $3) }
	| expr MINUS expr { Binop ($1, Sub, $3) }
	| expr TIMES expr { Binop ($1, Mul, $3) }
	| expr DIVIDE expr { Binop ($1, Div, $3) }
	| VARIABLE ASSIGN expr { Asn ($1, $3) }
	| LITERAL { Lit ($1) }
	| VARIABLE { Var ($1) }
;
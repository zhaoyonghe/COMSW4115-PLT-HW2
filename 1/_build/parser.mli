type token =
  | SEMI
  | PLUS
  | MINUS
  | TIMES
  | DIVIDE
  | EOF
  | ASSIGN
  | LITERAL of (int)
  | VARIABLE of (string)

val expr :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Ast.expr

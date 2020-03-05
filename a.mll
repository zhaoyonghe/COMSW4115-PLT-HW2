let digit = ['0'-'9']
let pdigit = ['1'-'9']
let ex = ['e' 'E']
let sign = ['+' '-']

(*
rule lex_float = parse
	  ((pdigit digit* | '0')) '.' digit* (ex sign? ((pdigit digit* | '0')))? as d { d }
	| '.' digit+ (ex sign? ((pdigit digit* | '0')))? as d { d }
	| (pdigit digit* | '0') ex sign? ((pdigit digit* | '0')) as d { d }
	| eof { "eof" }
*)

rule lex_float = parse
	  digit+ '.' digit* (ex sign? digit+)? as d { d }
	| '.' digit+ (ex sign? digit+)? as d { d }
	| digit+ ex sign? digit+ as d { d }
	| eof { "eof" }

{
	let buf = Lexing.from_channel stdin in
	let f = lex_float buf in
	print_endline f
}

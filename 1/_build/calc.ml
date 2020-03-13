open Ast
(*
let rec eval = function
	  Lit (x) -> x
	| Binop (e1, op, e2) ->
let v1 = eval e1 and v2 = eval e2 in
	match op with
	  Add -> v1 + v2
	| Sub -> v1 - v2
	| Mul -> v1 * v2
	| Div -> v1 / v2
let _ =
let lexbuf = Lexing.from_channel stdin in
let expr = Parser.expr Scanner.token lexbuf in
let result  = eval expr in
print_endline (string_of_int result)
*)
module StringMap = Map.Make(String)
let _ =
(*let rec toString value = 
	match value with
	| Seq (s1, s2) -> "Seq(" ^ (toString s1) ^ ";" ^ (toString s2) ^ ")"
	| Lit a -> "Lit(" ^ string_of_int a ^ ")"
	| Asn (s, e) -> "Asn(" ^ s ^ "=" ^ (toString e) ^ ")"
	| Var s -> "Var(" ^ s ^ ")"
	| Binop (e1, Add, e2) -> "Add(" ^ (toString e1) ^ "," ^ (toString e2) ^ ")"
	| Binop (e1, Sub, e2) -> "Sub(" ^ (toString e1) ^ "," ^ (toString e2) ^ ")"
	| Binop (e1, Mul, e2) -> "Mul(" ^ (toString e1) ^ "," ^ (toString e2) ^ ")"
	| Binop (e1, Div, e2) -> "Div(" ^ (toString e1) ^ "," ^ (toString e2) ^ ")" in*)
let var_map = ref StringMap.empty in
let rec eval value = 
	match value with
	| Seq (s1, s2) -> ignore (eval s1); eval s2 
	| Lit v -> v
	| Asn (s, e) -> let v = (eval e) in ignore (var_map := (StringMap.add s v !var_map)); v
	| Var s -> (*print_endline ("try to find: " ^ s ^ (string_of_int (StringMap.find s !var_map)));*) StringMap.find s !var_map
	| Binop (e1, Add, e2) -> (eval e1) + (eval e2)
	| Binop (e1, Sub, e2) -> (eval e1) - (eval e2)
	| Binop (e1, Mul, e2) -> (eval e1) * (eval e2)
	| Binop (e1, Div, e2) -> (eval e1) / (eval e2) in
let lexbuf = Lexing.from_channel stdin in
let expr = Parser.expr Scanner.token lexbuf in
(*print_endline (toString expr);*)
print_endline (string_of_int (eval expr));
(*StringMap.iter (fun k v -> (print_endline (k ^ ":" ^ (string_of_int v)))) !var_map*)

(*
g=t=t=r=f=6;u=8;u-7-t+r



y=y=t=u;t=7;y-t-u
Seq(Asn(y=Asn(y=Asn(t=Var(u))));Seq(Asn(t=Lit(7));Var(y)-Var(t)-Var(u)))
*)




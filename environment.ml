open Types;;

type fn_type1 = (s_exp -> s_exp)
and fn_type2 =  (s_exp -> s_exp -> s_exp)
and fn_typeN =  (s_exp -> s_exp)
and fn_binding = 
(*  NormalType1 of fn_type1
| NormalType2 of fn_type2*)
| NormalTypeN of fn_typeN
(*| SpecialType1 of fn_type1
| SpecialType2 of fn_type2 *)
| SpecialTypeN of fn_typeN
;;

(* Symbol for SymbolTable *)
module Symbol =
  struct
    type t = string
    (* Pervasives.compare returns 0 if x is equal to y*)
    let compare = Pervasives.compare
  end
;;

module SymbolTable = Map.Make(Symbol);;

let lookup_function fn_name environment=
  let bindings = SymbolTable.find fn_name !environment in
  match bindings with
  | [] -> raise (Error ("Not Found on the current environment : " ^ fn_name )  )
  | x::_ -> x
;;

let add_new name value environment=
  try
    let bindings = SymbolTable.find name !environment
    in environment := SymbolTable.add name (value::bindings) !environment
  with Not_found ->
    environment := SymbolTable.add name [value] !environment
;;


let add_function_binding name defn environment=
  add_new name defn environment
;;

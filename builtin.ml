open Environment;;
open Types;;

(*
let unbox s_exp = function
  | Types.Cons (car, cdr) -> raise (Error "Invalid")
  | _ as s -> Types.String
*)

let eval_funcall args environment =
  match args with
  | Types.Cons (car, cdr) ->
    begin
      match car with
      | Types.Cons (_, _) -> raise (Error "Invalid function")
      | fn_binding ->
        let fn_name = (Types.string_of_s_exp car) in

        try
          let fn_defn = lookup_function fn_name environment in
          begin
            match fn_defn with
            | NormalTypeN fn -> (fn cdr)
            | SpecialTypeN fn -> raise (Error "Special type is not implemented yet")
          end
        with
          _ -> raise (Error (fn_name ^ (" is not applicable")))
    end
  | _ as s -> s
;;

let rec eval_list s_exp environment = 
  match s_exp with
  | Types.Cons (car, cdr) ->
    Types.Cons( (eval car environment),
                (eval_list cdr environment) )
  | _ as s ->s
(* evaluate expression with environment *)
and eval s_exp environment =
  match s_exp with
  | Types.Cons (car, cdr) ->
    (eval_funcall 
       (Types.Cons ( (eval car environment),
                     (eval_list cdr environment) ))
       environment
    )
  | _ as s -> s
;;

let rec arith_plus = function
  | Types.Int i -> Types.Int i
  | Types.Cons (car, cdr) ->
    begin
      match car with
      | Types.Int i ->
        let Types.Int j = (arith_plus cdr) in
        Types.Int (i + j)
      | _ -> raise (Error ("Type Error"))
    end
  | Types.Nil -> Types.Int 0
  | _ -> raise (Error ("Type Error"))
;;


let builtin_functions = 
  [
    "+", NormalTypeN arith_plus;
(*    "eval", SpecialType eval; *)
  ]
;;

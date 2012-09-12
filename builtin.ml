open Environment;;
open Types;;

(*
let unbox s_exp = function
  | Types.Cons (car, cdr) -> raise (Error "Invalid")
  | _ as s -> Types.String
*)

let rec eval_list s_exp environment = 
  match s_exp with
  | Types.Cons (car, cdr) ->
    Types.Cons( (eval car environment),
                (eval_list cdr environment) )
  | _ as s ->s

and eval s_exp environment =
  match s_exp with
  | Types.Cons (car, cdr) ->
    begin
      let fn = (eval car environment) in

      begin
        match fn with
        | Types.Cons (_, _) -> raise (Error "Invalid function")
        | Types.Symbol sb ->
          begin
            let fn_name = sb in

            try
              let fn_defn = lookup_function fn_name environment in
              begin
                match fn_defn with
                | NormalTypeN fn -> (fn (eval_list cdr environment))
                | SpecialTypeN fn -> raise (Error "Special type is not implemented yet")
              end
            with
              _ -> raise (Error (fn_name ^ (" is not applicable")))
          end
        | _ -> raise (Error "Invalid function")
      end
    end
  | _ as  s -> s
;;

(* let eval_define arg1 arg2 environment = *)
  

let rec arith_plus = function
  | Types.Int i -> Types.Int i
  | Types.Cons (car, cdr) ->
    begin
      match car with
      | Types.Int i ->
        begin
          let result = (arith_plus cdr) in
          match result with
          | Types.Int j -> Types.Int (i + j)
          | _ -> raise (Error ("Type Error"))
        end
      | _ -> raise (Error ("Type Error"))
    end
  | Types.Nil -> Types.Int 0
  | _ -> raise (Error ("Type Error"))
;;


let builtin_functions = 
  [
    "+", NormalTypeN arith_plus;
(*    "define", NormalTypeN eval_define; *)
(*    "eval", SpecialType eval; *)
  ]
;;

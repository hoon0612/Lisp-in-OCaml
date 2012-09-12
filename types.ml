type s_exp =
  Int of int
| Float of float
| String of string
| Symbol of string
| Quote
| Nil
| Cons of s_exp * s_exp

let rec listp = function
  | Cons(car, cdr) -> (listp cdr)
  | Nil -> true
  | _ -> false
    
let rec string_of_s_exp = function
  | Int i -> string_of_int i
  | Float f -> string_of_float f
  | String s -> s
  | Symbol s -> s
  | Nil -> "nil"
  | Quote -> "\'"
  | Cons(car, cdr) -> "( " ^ (string_of_s_exp car) ^ ", " ^ (string_of_s_exp cdr) ^ " )"

exception Error of string
        

type s_exp =
  Int of int
| Float of float
| String of string
| Symbol of string
| Quote
| Nil
| Cons of s_exp * s_exp

val listp: s_exp -> bool
val string_of_s_exp: s_exp -> string 

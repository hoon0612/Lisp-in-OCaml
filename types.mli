type s_exp =
  Int of int
| Float of float
| String of string
| Symbol of string
| Quote
| Nil
| Cons of s_exp * s_exp

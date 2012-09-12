type token =
  | Int of (int)
  | Float of (float)
  | String of (string)
  | Symbol of (string)
  | Quote
  | Opener
  | Closer

val pmain :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.s_exp

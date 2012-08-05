(* header section *)
{
  open Parsing
  open Printf

  type result = Int of int
                | Float of float
                | String of string
                | Opener
                | Closer
                | Symbol of string
                | EOF
}

(* definitions section *)
let digit  = ['0'-'9']
let symbol = ['a'-'z' '_' '=' '+' '*' '/' '<' '>' '!' '?' '-']['a'-'z' '0'-'9' '_' '=' '+' '*' '/' '<' '>' '!' '?' '-']*
let opener  = '('
let closer  = ')'
let string  = '\"' ([^ '\\' '\"'] | '\\'_ )* '\"'
let whitespace = (' ' | '\n' | '\t')*
    
(* rules section *)
rule minilisp = parse
  | whitespace { minilisp lexbuf (* remove white space *) }
  | digit+ as inum { Int (int_of_string inum) }
  | digit+ '.' digit* as fnum { Float (float_of_string fnum) }
  | opener { Opener }
  | closer { Closer } 
  | symbol as sb { Symbol sb }
  | string as st {  String st }
  | eof { EOF }
  | _ as c { printf "Parse Error %c\n" c ; raise End_of_file}

(* trailer section *)

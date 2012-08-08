(* header section *)
{
  open Parser
  open Printf
  exception Eof
}

(* definitions section *)
let digit  = ['0'-'9']
let symbol = ['a'-'z' '_' '=' '+' '*' '/' '<' '>' '!' '?' '-']['a'-'z' '0'-'9' '_' '=' '+' '*' '/' '<' '>' '!' '?' '-']*
let opener  = '('
let closer  = ')'
let string  = '\"' ([^ '\\' '\"'] | '\\'_ )* '\"'
let whitespace = (' ' | '\n' | '\t')*
let quote = '\''
    
(* rules section *)
rule minilisp = parse
  | whitespace { minilisp lexbuf (* remove white space *) }
  | digit+ as inum { Int (int_of_string inum) }
  | digit+ '.' digit* as fnum { Float (float_of_string fnum) }
  | opener { Opener }
  | closer { Closer }
  | quote { Quote }
  | symbol as sb { Symbol sb }
  | string as st { String st }
  | eof { raise Eof }

(* trailer section *)

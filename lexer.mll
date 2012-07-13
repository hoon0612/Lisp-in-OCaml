(* header section *)
{
  open Printf
}

(* definitions section *)
let digit  = ['0'-'9']
let symbol = ['a'-'z' '_' '=' '+' '*' '/' '<' '>' '!' '?' '-']['a'-'z' '0'-'9' '_' '=' '+' '*' '/' '<' '>' '!' '?' '-']*
let opener  = '('
let closer  = ')'
let string  = '\"' ([^ '\\' '\"'] | '\\'_ )* '\"'
let whitespace = ' ' | '\n' | '\t'
  
(* rules section *)
rule minilisp = parse
  | whitespace { minilisp lexbuf }
  | digit+ as inum { printf "NUMBER %s\n" inum; minilisp lexbuf }
  | digit+ '.' digit* as fnum { printf "NUMBER %s\n" fnum; minilisp lexbuf }
  | opener { printf "OPEN (\n"; minilisp lexbuf}
  | closer { printf "CLOSE )\n"; minilisp lexbuf }
  | symbol as sb { printf "SYMBOL %s\n" sb; minilisp lexbuf }
  | string as st { printf "STRING %s\n" st; minilisp lexbuf }
  | eof { exit 0 }
  | _ as c { printf "Parse Error %c\n" c } 

(* trailer section *)
{
  let main () =
    let cin =
      if Array.length Sys.argv > 1
      then open_in Sys.argv.(1)
      else stdin
    in
    let lexbuf = Lexing.from_channel cin in
    minilisp lexbuf

  let _ = Printexc.print main ()
}


(* ocamllex lexer.mll; ocaml lexer.ml test.in  *) 

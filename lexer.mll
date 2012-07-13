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
  | whitespace { (* remove white space *) }
  | digit+ as inum { printf "NUMBER %s\n" inum}
  | digit+ '.' digit* as fnum { printf "NUMBER %s\n" fnum }
  | opener { printf "OPEN (\n" }
  | closer { printf "CLOSE )\n" }
  | symbol as sb { printf "SYMBOL %s\n" sb }
  | string as st { printf "STRING %s\n" st }
  | eof { exit 0 }
  | _ as c { printf "Parse Error %c\n" c } 

(* trailer section *)
{

  let rec parse lexbuf =
     let token = minilisp lexbuf in
     (* do nothing in this example *)
     parse lexbuf

  let main () =
    let cin =
      if Array.length Sys.argv > 1
      then open_in Sys.argv.(1)
      else stdin
    in
    let lexbuf = Lexing.from_channel cin in
    try parse lexbuf
    with End_of_file -> ()

  let _ = Printexc.print main ()
}

(* command line : ocamllex lexer.mll; ocaml lexer.ml test.in  *) 

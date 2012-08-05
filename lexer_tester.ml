#use "lexer.ml"

let print_token = function
  | Int i-> print_endline ("NUMBER " ^ string_of_int i)
  | Float f-> print_endline ("FLOAT " ^ string_of_float f)
  | Opener -> print_endline ("OPEN " ^ "(")
  | Closer -> print_endline ("CLOSE " ^ ")")
  | Symbol s-> print_endline ("SYMBOL " ^ s)
  | String s-> print_endline ("STRING " ^ s)
  | EOF -> print_endline ("")
;;

let rec lexer lexbuf =
  let token = minilisp lexbuf in
  if token != EOF then
    begin
      print_token token;
      lexer lexbuf;
    end
;;
  
let main () =
  let cin = if Array.length Sys.argv > 1
    then open_in Sys.argv.(1)
    else stdin
  in
  let lexbuf = Lexing.from_channel cin in
  lexer lexbuf
;;

let _ = Printexc.print main () ;;

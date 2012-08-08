open Lexer
  
let print_token = function
  | Parser.Int i-> print_endline ("NUMBER " ^ string_of_int i)
  | Parser.Float f-> print_endline ("FLOAT " ^ string_of_float f)
  | Parser.Opener -> print_endline ("OPEN " ^ "(")
  | Parser.Closer -> print_endline ("CLOSE " ^ ")")
  | Parser.Symbol s-> print_endline ("SYMBOL " ^ s)
  | Parser.String s-> print_endline ("STRING " ^ s)
  | Parser.Quote -> print_endline ("QUOTE " ^ "\'")
;;

let rec lexer lexbuf =
  let token = Lexer.minilisp lexbuf in
  begin
    print_token token;
    lexer lexbuf;
  end
;;
  
let main () =
  try
    let lexbuf = Lexing.from_channel stdin in
    lexer lexbuf
  with
    Lexer.Eof -> exit 0;
  | _ -> exit 1;
;;

let _ = Printexc.print main () ;;

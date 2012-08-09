open Lexer
open Types
open String
open Buffer

let main() =
  let lexbuf = Lexing.from_channel stdin in
  let read () = Parser.pmain minilisp lexbuf in
  let output = Buffer.create 0 in

  try
    while true do
      let s_exp = read () in
      print_endline (string_of_s_exp s_exp)
    done;
  with
    Lexer.Eof -> print_string (Buffer.contents output)
  | _ -> exit 1;
;;

main();;

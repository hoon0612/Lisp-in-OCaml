open Lexer
open Types
open String
open Buffer
open Environment
open Builtin
open Printexc

let add_functions environment functions =
  List.iter (fun (name,fn) -> add_function_binding name fn environment) functions
;;


let main() =
  let lexbuf = Lexing.from_channel stdin in
  let read () = Parser.pmain minilisp lexbuf in
  let output = Buffer.create 0 in
  let builtin_environment : fn_binding list SymbolTable.t ref 
    = ref SymbolTable.empty in
  add_functions builtin_environment Builtin.builtin_functions ;
  try
    Printexc.record_backtrace true;
    
    while true do
      let s_exp = read () in
      begin
        try
          print_endline ("= " ^  (string_of_s_exp (eval s_exp builtin_environment)));
        with
          Error e -> print_endline ("! " ^ e)
      end
    done;
  with
  |  Lexer.Eof -> print_string (Buffer.contents output)
  | _ -> Printexc.print_backtrace stdout; exit 1
;;

main();;

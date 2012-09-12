open Lexer
open Types
open String
open Buffer

let rec indent level =
  if level > 0 then "  " ^ (indent (level-1))
  else ""
;;

let fst (x, _) = x;;
let snd (_, y) = y;;

let string_of_atom atype value n_indent =
  ((indent n_indent) ^ "{\"type\": \"" ^ atype ^ "\", \"" ^ atype ^ "\": " ^ value ^ "}")  
let rec json_from_s_exp s_exp level in_list =
  begin
    match s_exp with
    | Types.Int i -> string_of_atom "number" (string_of_int i) level
    | Types.Float f -> string_of_atom "number" (string_of_float f) level
    | Types.String s -> string_of_atom "string" ("\"" ^ s ^ "\"")  level
    | Types.Symbol s -> string_of_atom "symbol" ("\"" ^ s ^ "\"")  level
    | Types.Quote -> string_of_atom "symbol" ("\"" ^ "quote" ^ "\"")  level
    | Types.Nil -> string_of_atom "symbol" ("\"" ^ "nil" ^ "\"")  level
    | Types.Cons (car, cdr) ->
      begin
        if in_list && (cdr == Types.Nil) then
          json_from_s_exp car level false
        else if (listp cdr) && (not in_list) then
            ((indent (level)) ^ "{\n") ^
            ((indent (level + 1)) ^ "\"type\": " ^ "\"list\",\n") ^
            ((indent (level + 1)) ^ "\"list\": [\n") ^
            (json_from_s_exp car (level + 2) false) ^
            ",\n" ^
            (json_from_s_exp cdr (level + 2) true) ^
            ("\n" ^ (indent (level + 1)) ^ "]\n") ^
            ((indent (level)) ^ "}")
        else
          begin
            (json_from_s_exp car level false) ^
            ",\n" ^
            (json_from_s_exp cdr level in_list)
          end
      end
  end
;;

let main () =
  let lexbuf = Lexing.from_channel stdin in
  let read () = Parser.pmain minilisp lexbuf in
  let json_buf = Buffer.create 0 in
  try
    while true do
      let s_exp = read () in
      let s_exp_str = (json_from_s_exp s_exp 2 false) in
      if Buffer.length json_buf > 0 then
        Buffer.add_string json_buf ",\n";
      Buffer.add_string json_buf s_exp_str;
    done;
  with
    Lexer.Eof ->
      begin
        print_endline "{";
        print_endline ((indent 1) ^ "\"success\": true,");
        print_endline ((indent 1) ^ "\"forms\": [");
        print_string (Buffer.contents json_buf);
        print_endline ("\n" ^ (indent 1) ^ "]");
        print_endline "}";
        exit 0;
      end
  | _ -> exit 1;
;;

let _ = Printexc.print main () ;;

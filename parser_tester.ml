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

let atom_to_str atype value n_indent =
  ((indent n_indent) ^ "{\"type\": \"" ^ atype ^ "\", \"" ^ atype ^ "\": " ^ value ^ "}")  
                 

let rec print_s_exp s_exp level =
  begin
    match s_exp with
    | Types.Int i -> atom_to_str "number" (string_of_int i) level
    | Types.Float f -> atom_to_str "number" (string_of_float f) level
    | Types.String s -> atom_to_str "string" ("\"" ^ s ^ "\"")  level
    | Types.Symbol s -> atom_to_str "symbol" ("\"" ^ s ^ "\"")  level
    | Types.Quote -> atom_to_str "symbol" ("\"" ^ "quote" ^ "\"")  level
    | Types.Nil -> atom_to_str "symbol" ("\"" ^ "nil" ^ "\"")  level
    | Types.Cons (x, y) ->
      begin
        if y == Types.Nil then
            ((indent (level)) ^ "{\n") ^
            ((indent (level + 1)) ^ "\"type\": " ^ "\"list\",\n") ^
            ((indent (level + 1)) ^ "\"list\": [\n") ^
            (print_s_exp x (level + 2)) ^
            ("\n" ^ (indent (level + 1)) ^ "]\n") ^
            ((indent (level)) ^ "}")
        else
          begin
            (print_s_exp x level) ^
            ",\n" ^
            (print_s_exp y level) ^

            match y with
            | Types.Cons (xx,yy) -> ""
            | _ -> ""
          end ;
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
      let s_exp_str = (print_s_exp s_exp 2) in
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

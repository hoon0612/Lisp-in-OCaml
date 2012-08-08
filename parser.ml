type token =
  | Int of (int)
  | Float of (float)
  | String of (string)
  | Symbol of (string)
  | Quote
  | Opener
  | Closer

open Parsing;;
let yytransl_const = [|
  261 (* Quote *);
  262 (* Opener *);
  263 (* Closer *);
    0|]

let yytransl_block = [|
  257 (* Int *);
  258 (* Float *);
  259 (* String *);
  260 (* Symbol *);
    0|]

let yylhs = "\255\255\
\001\000\003\000\003\000\004\000\004\000\005\000\005\000\006\000\
\006\000\006\000\002\000\002\000\002\000\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\002\000\003\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\002\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\007\000\006\000\009\000\010\000\000\000\000\000\
\014\000\001\000\011\000\008\000\012\000\013\000\004\000\000\000\
\000\000\003\000\005\000"

let yydgoto = "\002\000\
\009\000\016\000\017\000\011\000\012\000\013\000"

let yysindex = "\007\000\
\013\255\000\000\000\000\000\000\000\000\000\000\013\255\255\254\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\013\255\
\002\255\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\003\255\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\006\000\251\255\000\000\000\000\000\000"

let yytablesize = 19
let yytable = "\003\000\
\004\000\005\000\006\000\007\000\008\000\015\000\010\000\001\000\
\019\000\002\000\018\000\000\000\014\000\003\000\004\000\005\000\
\006\000\007\000\008\000"

let yycheck = "\001\001\
\002\001\003\001\004\001\005\001\006\001\007\001\001\000\001\000\
\007\001\007\001\016\000\255\255\007\000\001\001\002\001\003\001\
\004\001\005\001\006\001"

let yynames_const = "\
  Quote\000\
  Opener\000\
  Closer\000\
  "

let yynames_block = "\
  Int\000\
  Float\000\
  String\000\
  Symbol\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 's_exp) in
    Obj.repr(
# 13 "parser.mly"
        ( _1 )
# 85 "parser.ml"
               : Types.s_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 's_exp) in
    Obj.repr(
# 17 "parser.mly"
       ( _1 )
# 92 "parser.ml"
               : 's_exp_list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 's_exp) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 's_exp_list) in
    Obj.repr(
# 18 "parser.mly"
                    ( Types.Cons (_1, _2) )
# 100 "parser.ml"
               : 's_exp_list))
; (fun __caml_parser_env ->
    Obj.repr(
# 22 "parser.mly"
                ( Types.Nil )
# 106 "parser.ml"
               : 'list))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 's_exp_list) in
    Obj.repr(
# 23 "parser.mly"
                           ( Types.Cons (_2, Types.Nil) )
# 113 "parser.ml"
               : 'list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : float) in
    Obj.repr(
# 27 "parser.mly"
        ( Types.Float(_1) )
# 120 "parser.ml"
               : 'number))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 28 "parser.mly"
      ( Types.Int(_1) )
# 127 "parser.ml"
               : 'number))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'number) in
    Obj.repr(
# 32 "parser.mly"
          ( _1 )
# 134 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 33 "parser.mly"
          ( Types.String (_1) )
# 141 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 34 "parser.mly"
          ( Types.Symbol(_1) )
# 148 "parser.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'list) in
    Obj.repr(
# 38 "parser.mly"
       ( _1 )
# 155 "parser.ml"
               : 's_exp))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 39 "parser.mly"
       ( _1 )
# 162 "parser.ml"
               : 's_exp))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 's_exp) in
    Obj.repr(
# 40 "parser.mly"
              ( Types.Quote )
# 169 "parser.ml"
               : 's_exp))
(* Entry pmain *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let pmain (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : Types.s_exp)

type fn_type1 = Types.s_exp -> Types.s_exp
and fn_type2 = Types.s_exp -> Types.s_exp -> Types.s_exp
and fn_typeN = Types.s_exp -> Types.s_exp
and fn_binding =
| NormalTypeN of fn_typeN
| SpecialTypeN of fn_typeN
    
module Symbol : sig type t = string val compare : 'a -> 'a -> int end
module SymbolTable :
  sig
    type key = Symbol.t
    type 'a t = 'a Map.Make(Symbol).t
    val empty : 'a t
    val is_empty : 'a t -> bool
    val mem : key -> 'a t -> bool
    val add : key -> 'a -> 'a t -> 'a t
    val singleton : key -> 'a -> 'a t
    val remove : key -> 'a t -> 'a t
    val merge :
      (key -> 'a option -> 'b option -> 'c option) -> 'a t -> 'b t -> 'c t
    val compare : ('a -> 'a -> int) -> 'a t -> 'a t -> int
    val equal : ('a -> 'a -> bool) -> 'a t -> 'a t -> bool
    val iter : (key -> 'a -> unit) -> 'a t -> unit
    val fold : (key -> 'a -> 'b -> 'b) -> 'a t -> 'b -> 'b
    val for_all : (key -> 'a -> bool) -> 'a t -> bool
    val exists : (key -> 'a -> bool) -> 'a t -> bool
    val filter : (key -> 'a -> bool) -> 'a t -> 'a t
    val partition : (key -> 'a -> bool) -> 'a t -> 'a t * 'a t
    val cardinal : 'a t -> int
    val bindings : 'a t -> (key * 'a) list
    val min_binding : 'a t -> key * 'a
    val max_binding : 'a t -> key * 'a
    val choose : 'a t -> key * 'a
    val split : key -> 'a t -> 'a t * 'a option * 'a t
    val find : key -> 'a t -> 'a
    val map : ('a -> 'b) -> 'a t -> 'b t
    val mapi : (key -> 'a -> 'b) -> 'a t -> 'b t
  end
val lookup_function : string -> 'a list SymbolTable.t ref -> 'a
val add_new : string -> 'a -> 'a list SymbolTable.t ref -> unit
val add_function_binding :
  SymbolTable.key -> 'a -> 'a list SymbolTable.t ref -> unit

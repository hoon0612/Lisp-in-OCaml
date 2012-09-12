val eval_funcall :
  Types.s_exp ->
  Environment.fn_binding list Environment.SymbolTable.t ref -> Types.s_exp

val eval :
  Types.s_exp ->
  Environment.fn_binding list Environment.SymbolTable.t ref -> Types.s_exp

val eval_list :
  Types.s_exp ->
  Environment.fn_binding list Environment.SymbolTable.t ref -> Types.s_exp
  
val arith_plus : Types.s_exp -> Types.s_exp
val builtin_functions : (string * Environment.fn_binding) list

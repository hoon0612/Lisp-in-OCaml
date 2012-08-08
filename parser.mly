%token <int> Int
%token <float> Float
%token <string> String
%token <string> Symbol
%token Quote Opener Closer

%start pmain
%type <Types.s_exp> pmain

%%

pmain:  
  s_exp { $1 } 
;

s_exp_list:
 s_exp { $1 }
 | s_exp s_exp_list { Types.Cons ($1, $2) }
;

list:  
  Opener Closer { Types.Nil }
| Opener s_exp_list Closer { Types.Cons ($2, Types.Nil) }
;

number:
  Float { Types.Float($1) }
| Int { Types.Int($1) }
;      

atom:
 | number { $1 }
 | String { Types.String ($1) }
 | Symbol { Types.Symbol($1) }
;     

s_exp:
  list { $1 }
| atom { $1 }
| Quote s_exp { Types.Quote }
;

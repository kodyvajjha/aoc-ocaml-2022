%{
  
%}

%token EOF 
%token OPPROCKTOK 
%token OPPPAPERTOK 
%token OPPSCISSTOK
%token LOSETOK 
%token DRAWTOK 
%token WINTOK


%start inputfile 
%type <(Syntax.opponent_move * Syntax.ends_as) list> inputfile 

%% 

inputfile:
| moveslist eof {$1 @ $2}

moveslist: 
| round moveslist { [$1] @ $2 } 
| /* empty */ { [ ] } 

round: 
| opponentmove ourmove { ($1,$2) }

opponentmove:
| OPPROCKTOK { Syntax.ORock }
| OPPPAPERTOK { Syntax.OPaper }
| OPPSCISSTOK { Syntax.OScissors }

ourmove:
| LOSETOK { (Syntax.Lose) }
| WINTOK { (Syntax.Win)}
| DRAWTOK { (Syntax.Draw)}


eof:
| EOF { [ ] }



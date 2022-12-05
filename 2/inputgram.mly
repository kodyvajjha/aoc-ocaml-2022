%{
  
%}

%token EOF 
%token OPPROCKTOK 
%token OPPPAPERTOK 
%token OPPSCISSTOK
%token PLAROCKTOK 
%token PLAPAPERTOK 
%token PLASCISSTOK


%start inputfile 
%type <(Syntax.opponent_move * Syntax.player_move) list> inputfile 

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
| PLAROCKTOK { Syntax.PRock }
| PLAPAPERTOK { Syntax.PPaper }
| PLASCISSTOK { Syntax.PScissors }


eof:
| EOF { [ ] }



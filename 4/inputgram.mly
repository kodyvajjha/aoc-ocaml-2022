%{
  
%}

%token EOF 
%token <int> INT 
%token HYPHENTOK 
%token COMMATOK



%start inputfile 
%type <int list list> inputfile 

%% 

inputfile:
| assignpairlist eof {$1 @ $2}

assignpairlist: 
| assignpairs assignpairlist {$1 :: $2}
| /* empty */ { [ ]} 

assignpairs: 
| assignment COMMATOK assignment { $1 @ $3}

assignment: 
| INT HYPHENTOK INT { [$1] @ [$3] }

eof:
| EOF { [ ] }



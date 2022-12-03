%{

%}

%token EOF 
%token <int> INT 


%start inputfile 
%type <int list list> inputfile 

%% 

inputfile:
| calslist eof {$1 @ $2}

calslist:
| cal calslist { [$1] @ $2}
| /* empty */ { [ ] }

cal:
| INT {[$1]}

eof:
| EOF { [ [ ] ] }



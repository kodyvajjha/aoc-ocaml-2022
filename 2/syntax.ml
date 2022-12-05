type opponent_move =
  | ORock
  | OPaper
  | OScissors
[@@deriving show]

type player_move =
  | PRock
  | PPaper
  | PScissors
[@@deriving show]

type ends_as =
  | Lose
  | Draw
  | Win

let shape_score = function
  | PRock -> 1 (* Rock *)
  | PPaper -> 2 (* Paper *)
  | PScissors -> 3 (* Scissors *)

let outcome_score (omv : opponent_move * player_move) =
  match omv with
  | ORock, PRock -> 3
  | OPaper, PPaper -> 3
  | OScissors, PScissors -> 3
  | ORock, PScissors -> 0
  | OPaper, PRock -> 0
  | OScissors, PPaper -> 0
  | OPaper, PScissors -> 6
  | ORock, PPaper -> 6
  | OScissors, PRock -> 6

let choose_outcome (opends : opponent_move * ends_as) =
  match opends with
  | ORock, Lose -> PScissors
  | ORock, Win -> PPaper
  | ORock, Draw -> PRock
  | OPaper, Lose -> PRock
  | OPaper, Win -> PScissors
  | OPaper, Draw -> PPaper
  | OScissors, Lose -> PPaper
  | OScissors, Win -> PRock
  | OScissors, Draw -> PScissors

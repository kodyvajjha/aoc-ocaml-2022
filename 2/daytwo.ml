[@@@warning "-37-32"]

let () =
  let ic = open_in "2/input.txt" in
  let lexbuf = Lexing.from_channel ic in
  let first = List.hd (Inputgram.inputfile Inputlex.token lexbuf) in
  Syntax.pp_opponent_move Format.std_formatter (fst first);
  Syntax.pp_player_move Format.std_formatter (snd first)

(* let open Syntax in
   print_int @@ shape_score PRock;
   print_int @@ shape_score PPaper;
   print_int @@ shape_score PScissors *)

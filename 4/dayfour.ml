[@@@warning "-37-32"]

(* let lines = CCIO.(with_in "4/input.txt" read_lines_l) *)

let contained_in l1 l2 =
  let sorted1 = List.sort compare l1 in
  let sorted2 = List.sort compare l2 in
  let min1, max1 = List.nth sorted1 0, List.nth sorted1 (List.length l1 - 1) in
  let min2, max2 = List.nth sorted2 0, List.nth sorted2 (List.length l2 - 1) in
  min1 <= min2 && max2 <= max1

let fully_contains (l : int list) : bool =
  let a = List.nth l 0 in
  let b = List.nth l 1 in
  let c = List.nth l 2 in
  let d = List.nth l 3 in
  contained_in CCList.(a -- b) CCList.(c -- d)
  || contained_in CCList.(c -- d) CCList.(a -- b)

let indicator (l : int list) =
  if fully_contains l then
    1
  else
    0

let () =
  assert (fully_contains [ 6; 6; 4; 6 ] = true);
  assert (fully_contains [ 2; 8; 3; 7 ] = true)

(* Part 1 *)
let () =
  let ic = open_in "4/input.txt" in
  let lexbuf = Lexing.from_channel ic in
  let rounds = Inputgram.inputfile Inputlex.token lexbuf in
  let indicators = List.map indicator rounds in
  print_int @@ CCList.fold_left ( + ) 0 indicators

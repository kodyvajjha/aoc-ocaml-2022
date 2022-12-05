[@@@warning "-37-32"]

open Syntax

(* Part One *)
let () =
  let ic = open_in "2/input.txt" in
  let lexbuf = Lexing.from_channel ic in
  let rounds = Inputgram.inputfile Inputlex.token lexbuf in
  let outcome_scores = List.map outcome_score rounds in
  let shape_scores = List.map shape_score (List.map snd rounds) in
  let sum_scores = CCList.map2 ( + ) outcome_scores shape_scores in
  print_int @@ CCList.fold_right ( + ) sum_scores 0

(* Part two *)
let () =
  let ic = open_in "2/input.txt" in
  let lexbuf = Lexing.from_channel ic in
  let codes = Inputgramtwo.inputfile Inputlextwo.token lexbuf in
  let plmoves = List.map choose_outcome codes in
  let rounds = List.combine (List.map fst codes) plmoves in
  let outcome_scores = List.map outcome_score rounds in
  let shape_scores = List.map shape_score plmoves in
  let sum_scores = CCList.map2 ( + ) outcome_scores shape_scores in
  print_int @@ CCList.fold_right ( + ) sum_scores 0

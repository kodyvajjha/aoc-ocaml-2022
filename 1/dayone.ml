(* Day 1. Initial attempt was to write a lexer + parser for the files,
   but that turned out to be a huge PITA. So abandoned that and just did
   it the boneheaded way. In particular, I couldn't wire the parser to
   read chunks separated by whitespace.
*)
let preprocess =
  let lines = CCIO.(with_in "1/input.txt" read_lines_l) in
  let str =
    CCFormat.sprintf "%a" CCFormat.(list ~sep:(return ";") string) lines
  in
  let split = Str.split (Str.regexp_string ";;") str in
  let ssplit = List.map (Str.split (Str.regexp_string ";")) split in
  let sssplit = List.map (List.map int_of_string) ssplit in
  sssplit

let sum (l : int list) = CCList.fold_left ( + ) 0 l

let list_max (l : int list) = CCList.fold_left max (List.hd l) l

(* Part 1.*)
let () =
  let sums = List.map sum preprocess in
  let max = list_max sums in
  print_endline (string_of_int max)

(* Part 2.*)

let () =
  let sums = List.map sum preprocess in
  let sorted = CCList.sort compare sums in
  let rev = List.rev sorted in
  let first, second, third = List.nth rev 0, List.nth rev 1, List.nth rev 2 in
  print_int (first + second + third)

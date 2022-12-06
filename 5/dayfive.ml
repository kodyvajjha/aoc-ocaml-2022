[@@@warning "-37-32-34"]

let lines =
  let open CCList in
  let read =
    CCIO.(with_in "5/input.txt" read_lines_l)
    >|= (fun str -> CCString.split str ~by:" ")
    >|= List.filter (fun x -> x <> "move" && x <> "from" && x <> "to")
    >|= fun x -> List.map int_of_string x
  in
  read

type stack = string list [@@deriving show]

type crates = stack array [@@deriving show]

(*
   
[T]     [D]         [L]            
[R]     [S] [G]     [P]         [H]
[G]     [H] [W]     [R] [L]     [P]
[W]     [G] [F] [H] [S] [M]     [L]
[Q]     [V] [B] [J] [H] [N] [R] [N]
[M] [R] [R] [P] [M] [T] [H] [Q] [C]
[F] [F] [Z] [H] [S] [Z] [T] [D] [S]
[P] [H] [P] [Q] [P] [M] [P] [F] [D]
 1   2   3   4   5   6   7   8   9 

*)

let init : crates =
  [|
    [ "T"; "R"; "G"; "W"; "Q"; "M"; "F"; "P" ];
    [ "R"; "F"; "H" ];
    [ "D"; "S"; "H"; "G"; "V"; "R"; "Z"; "P" ];
    [ "G"; "W"; "F"; "B"; "P"; "H"; "Q" ];
    [ "H"; "J"; "M"; "S"; "P" ];
    [ "L"; "P"; "R"; "S"; "H"; "T"; "Z"; "M" ];
    [ "L"; "M"; "N"; "H"; "T"; "P" ];
    [ "R"; "Q"; "D"; "F" ];
    [ "H"; "P"; "L"; "N"; "C"; "S"; "D" ];
  |]

(* move three from eight to nine *)

let move crates l =
  match l with
  | [ qty; first; second ] ->
    let l1, l2 =
      ( CCList.drop qty crates.(first - 1),
        (CCList.take qty crates.(first - 1) |> List.rev) @ crates.(second - 1) )
    in
    crates.(first - 1) <- l1;
    crates.(second - 1) <- l2
  | _ -> failwith "failed!!!!"

(* Part 1. *)
let () =
  List.iter (move init) lines;
  CCFormat.printf "%a" CCFormat.(array (list string)) init

(*
  Answer : [|["T"; "M"; "M"; "Q"; "R"]; ["P"; "R"; "S"; "H"];
  ["G"; "P"; "C"; "D"; "Z"; "T"]; ["V"; "F"]; ["Q"];
  ["P"; "L"; "B"; "H"; "S"; "H"; "W"; "F"; "M"; "R"; "G"; "S"; "M"; "N"; "R";
   "G"; "S"; "P"; "H"; "P"];
  ["F"; "F"];
  ["D"; "P"; "Q"; "D"; "J"; "H"; "N"; "T"; "L"; "W"; "Z"; "L"; "H"; "P"; "R"];
  ["H"]|]
  *)

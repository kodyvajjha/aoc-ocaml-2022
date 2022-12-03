(* let lines = CCIO.(with_in "1/input.txt" read_lines_l) *)

let calslist =
  let ic = open_in "1/input.txt" in
  let lexbuf = Lexing.from_channel ic in
  Inputgram.inputfile Inputlex.token lexbuf

let () = CCFormat.printf "%a" CCFormat.(list (list int)) (List.tl calslist)

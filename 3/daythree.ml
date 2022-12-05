[@@@warning "-37-32"]

let lines = CCIO.(with_in "3/input.txt" read_lines_l)

let break line =
  let n = String.length line in
  let first = ref " " in
  let last = ref " " in
  let () =
    for i = 0 to (n / 2) - 1 do
      first := !first ^ Char.escaped line.[i];
      last := !last ^ Char.escaped line.[(n / 2) + i]
    done
  in
  !first, !last

let explode s = List.init (String.length s) (String.get s)

let check (l1 : string) (l2 : string) : char list =
  let l1 = explode l1 in
  let l2 = explode l2 in
  List.fold_left
    (fun linter e1 ->
      if List.exists (( = ) e1) l2 then
        e1 :: linter
      else
        linter)
    [] l1

let get_common_char str =
  let a, b = break str in
  List.hd @@ check a b

let priorities =
  let upper = List.map Char.chr CCList.(65 -- 90) in
  let lower = List.map Char.chr CCList.(97 -- 122) in
  List.combine (lower @ upper) CCList.(1 -- 52)

let rec sum l =
  match l with
  | [] -> 0
  | x :: xs -> x + sum xs

let get_badge str1 str2 str3 =
  let c12 = check str1 str2 in
  let c23 = check str2 str3 in
  let c13 = check str1 str3 in
  CCList.inter ~eq:( = ) (CCList.inter ~eq:( = ) c12 c23) c13

let badges l =
  let res = ref [] in
  let mul = List.length l / 3 in
  for i = 0 to mul - 1 do
    res :=
      !res
      @ [
          List.hd
          @@ get_badge
               (List.nth lines (3 * i))
               (List.nth lines ((3 * i) + 1))
               (List.nth lines ((3 * i) + 2));
        ]
  done;
  !res

(* Part 1 *)
let () =
  let common_chars = List.map get_common_char lines in
  let common_char_ints =
    List.map (fun x -> List.assoc x priorities) common_chars
  in
  print_int @@ sum common_char_ints

(* Part 2 *)
let () =
  let common_char_ints =
    List.map (fun x -> List.assoc x priorities) (badges lines)
  in
  print_int @@ sum common_char_ints

[@@@warning "-37-32-34"]

let line = CCIO.(with_in "6/input.txt" read_line)

let first_four str = CCString.take 4 str

let explode s = List.init (String.length s) (String.get s)

let rec all_diff_chars str =
  match str with
  | [] -> true
  | x :: xs ->
    if CCList.mem x xs then
      false
    else
      all_diff_chars xs

let is_marker str = str |> first_four |> explode |> all_diff_chars

let windows size l =
  let final = ref [] in
  for i = 0 to List.length l - size do
    let res = ref [] in
    for j = 0 to size - 1 do
      res := !res @ [ List.nth l (i + j) ]
    done;
    final := !final @ [ !res ]
  done;
  List.combine CCList.(size -- List.length l) !final

(* Part 1 *)
let () =
  match line with
  | Some line ->
    let line = explode line in
    print_int @@ fst @@ List.hd
    @@ List.filter
         (fun x -> snd x = true)
         (List.map (fun y -> fst y, all_diff_chars (snd y)) (windows 4 line))
  | None -> failwith "failed"

(* Part 2 *)
let () =
  match line with
  | Some line ->
    let line = explode line in
    print_string "\n";
    print_int @@ fst @@ List.hd
    @@ List.filter
         (fun x -> snd x = true)
         (List.map (fun y -> fst y, all_diff_chars (snd y)) (windows 14 line))
  | None -> failwith "failed"

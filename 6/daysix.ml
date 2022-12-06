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

let windows l =
  let final = ref [] in
  for i = 0 to List.length l - 4 do
    let res = ref [] in
    res := !res @ [ List.nth l i ];
    res := !res @ [ List.nth l (i + 1) ];
    res := !res @ [ List.nth l (i + 2) ];
    res := !res @ [ List.nth l (i + 3) ];
    final := !final @ [ !res ]
  done;
  List.combine CCList.(4 -- List.length l) !final

(* Part 1 *)
let () =
  match line with
  | Some line ->
    let line = explode line in
    print_int @@ fst @@ List.hd
    @@ List.filter
         (fun x -> snd x = true)
         (List.map (fun y -> fst y, all_diff_chars (snd y)) (windows line))
  | None -> failwith "failed"

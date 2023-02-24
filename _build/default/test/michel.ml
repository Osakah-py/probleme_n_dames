open Graphics

let win_height = 500
let win_width = 500

let center_text msg =
  let (text_width, text_height) = text_size msg in
  let x = (win_width - text_width) / 2 in
  let y = (win_height - text_height) / 2 in
  moveto x y;
  draw_string msg

let stop_threads = ref false

let loading_animation () =
  let delay = ref 0.1 in
  let chars = [|"|"; "/"; "-"; "\\"|] in
  let i = ref 0 in
  while (!stop_threads = false) do
    center_text (chars.(!i));
    synchronize ();
    Unix.sleepf !delay ;
    i := (!i + 1) mod (Array.length chars);
    clear_graph ();
  done

let rec main_task i=
  if i = 0 then
    let () = Thread.delay 2. in
    let () = clear_graph () in
    let () = synchronize () in
    let () = stop_threads := true in ()
  else
    let () = Thread.delay 0.5 in
    let () = Printf.printf "Task: %d\n%!" i in
    main_task (i-1)

let () = 
  let () = open_graph "200x200" in
  let loading_thread = Thread.create loading_animation () in
  let task_thread = Thread.create main_task 10 in
  let () = Thread.join task_thread in
  let () = Thread.join loading_thread in
  close_graph ()



(* dessiner l'animation de chargement 
let loading_animation () =
  let delay = ref 0.1 in
  let chars = [|"|"; "/"; "-"; "\\"|] in
  let i = ref 0 in
  while (!stop_threads = false) do
    draw_string chars.(!i);
    synchronize ();
    Unix.sleepf !delay ;
    i := (!i + 1) mod (Array.length chars);
    clear_graph ();
  done;;*)

  (* let () = 
  let loading_thread = Thread.create loading_animation () in
  let result_channel = Event.new_channel () in
  let task_thread = Thread.create (fun () ->
    let result = backtracking arg in
    Event.sync (Event.send result_channel result)) () in
    let () = Thread.join loading_thread in
    let result = Event.sync (Event.receive result_channel) in *)
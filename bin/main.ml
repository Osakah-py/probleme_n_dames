open Graphics;;
open Queen;;
open Dames;;
open Affichage;;

let arg =   
  if Array.length Sys.argv < 2 then
  (* Valeur par défaut si pas d'argument *)
    8
  else 
    int_of_string (Sys.argv.(1));;

let win_height = arg * 50 + 50;;
let win_width = arg * 50 + 10;;


if (arg = 2 || arg = 3) then impossible ()


(* Initialsation de la fenêtre *)
let () = open_graph (Printf.sprintf " %dx%d" win_width win_height)   (* ouvrir une fenêtre graphique *)
let () = set_window_title (Printf.sprintf "Probleme a %d-dames" arg)

let queen = make_image my_queen
let draw_queen x y =
  draw_image queen x y;;

cell_x := (size_x()/arg); cell_y := ((size_y() - 15)/arg);;

(* Fonction permettant d'afficher les dames *)
let afficher_resultat liste = 
  let rec aux liste y = match liste with 
  |[] -> print_newline ();
  |(x,_)::q -> ignore (draw_queen (x*(!cell_x) + 3) (y + 15)); aux q (y + (!cell_y));
    in aux liste 3;;

text_center "Chargement... " (size_x()) (size_y());
(* Calcul du temps d'exécution de la fonction backtracking *)
let start_time = Unix.gettimeofday () in
let result = backtracking arg in
let end_time = Unix.gettimeofday () in

(* Effacement de la fenêtre et affichage du temps d'exécution*)
clear_graph ();
moveto 0 0;
draw_string (Printf.sprintf "Solution trouvee en %f sec" (end_time -. start_time) );

(* Affichage du damier et des dames *)
damier arg;
afficher_resultat result;


ignore (wait_next_event [Key_pressed]);
close_graph ();;  (* fermer la fenêtre graphique *)



















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
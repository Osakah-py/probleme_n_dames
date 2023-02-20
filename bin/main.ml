(* On ouvre le module Graphics ainsi que nos fichiers annexes *)
open Graphics;;
open Queen;;
open Dames;;
open Affichage;;

(* On récupère ici l'argument en entrée *)
let arg =   
  if Array.length Sys.argv < 2 then
  (* Valeur par défaut si pas d'argument *)
    8
  else 
    int_of_string (Sys.argv.(1));;

(* On définit la taille de la fenêtre en fonction du nombre de reine *)
let win_height = if arg < 20 then arg * 50 + 50 else arg * 25 + 50;;
let win_width = if arg < 20 then arg * 50 + 10 else arg * 25 + 10;;

(* Les cas n=2 et n=3 n'ayant pas de solution on interrompt directement le programme ici *)
if (arg = 2 || arg = 3) then impossible ()


(* Initialsation de la fenêtre *)
let () = open_graph (Printf.sprintf " %dx%d" win_width win_height)   (* ouvrir une fenêtre graphique avec les details calculés précédement *)
let () = set_window_title (Printf.sprintf "Probleme a %d-dames" arg)

(* On génère les images des matrices du fichier queen.ml *)
let queen = make_image my_queen;;
let low_queen = make_image queen_low_quality;;

(* Fonction permettant de dessiner une reine *)
let draw_queen x y =
  if arg < 20 then
  draw_image queen x y
  else
    draw_image low_queen x y (* Dans le cas ou n>=20 on dessine une reine + petite *)

  
(* Fonction permettant d'afficher les dames sur l'échéquier *)
let afficher_resultat liste = 
  let rec aux liste y = match liste with 
  |[] -> print_newline (); (* On renvoit le type unit *)
  |(x,_)::q -> ignore (draw_queen (x*(!cell_x) + 3) (y + 15)); aux q (y + (!cell_y));
in aux liste 3;;

(* On affiche un texte de chargement pendant le calcul de la solution (cf affichage.ml) *)
text_center "Chargement... " (size_x()) (size_y());

(* Calcul du temps d'exécution de la fonction backtracking *)
let start_time = Unix.gettimeofday () in
let result = backtracking arg in
let end_time = Unix.gettimeofday () in

(* On re-calcul la taille de la fenêtre (si l'utilisateur a modifié la taille entre temps) *)
cell_x := (size_x()/arg); cell_y := ((size_y() - 15)/arg);

(* Effacement de la fenêtre et affichage du temps d'exécution *)
clear_graph ();
moveto 0 0;
draw_string (Printf.sprintf "Solution trouvee en %f sec" (end_time -. start_time) );

(* Affichage du damier et des dames *)
damier arg;
afficher_resultat result;

(* On attend que l'utilisateur presse une touche pour fermer la fenêtre *)
ignore (wait_next_event [Key_pressed]);
close_graph ();;  (* fermer la fenêtre graphique *)
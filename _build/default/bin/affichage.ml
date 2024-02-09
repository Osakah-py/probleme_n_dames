open Graphics;;

let loading = ref true;;
let cell_x = ref 50 
and cell_y = ref 50
(* Couleur du damier *)
let beautiful_blue = 0x1B9AEF

(* dessiner le texte de chargement *)
let text_center text s_x s_y = 
  let (text_width, text_height) = text_size text in
    set_color black;
    moveto ((s_x /2) - text_width/2 ) ((s_y / 2)- text_height);
    draw_string text;;

(* Les cas n = 2 et n = 3 étant impossible on affiche ceci dans ces cas là*)
let impossible () = 
  let () = open_graph "700x400"  in  (* ouvrir une fenêtre graphique *)
  let () = set_window_title (Printf.sprintf "Probleme tout court") in
  text_center "Il n'existe aucune solution." (size_x()) (size_y());
  text_center "Appuyez sur une touche pour fermer la fenetre." (size_x()) (size_y()-30);
  ignore (wait_next_event [Key_pressed]);
  close_graph ();
  failwith "quit";;

(* Fonction permettant d'afficher le damier *)
let damier arg =
  for i = 0 to arg-1 do
    for j = 0 to arg-1 do
      if (i+j) mod 2 = 0 then set_color beautiful_blue else set_color white;
      fill_rect ( i*(!cell_x) ) (j* (!cell_y) + 15) !cell_x !cell_y;
    done;
  done;;

(* dessiner l'animation de chargement *)
let loading_animation () =
  let delay = ref 0.1 in
  let load_str = [|"Chargement |"; "Chargement /"; "Chargement -"; "Chargement \\"|] in
  let i = ref 0 in
  while (!loading) do
    text_center load_str.(!i) (size_x()) (size_y ());
    synchronize ();
    Thread.yield ();
    Unix.sleepf !delay ;
    i := (!i + 1) mod (Array.length load_str);
    clear_graph ();
  done;;
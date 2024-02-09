(* Dans ce fichier vous retrouverez l'algorithe de backtracking *)

(* Fonction verif de type : int -> int -> (int * int) list -> int -> int * int
** entrées : ** 
| fst : abscisse x ou commence la verif 
| reine : ordonnée sur laquelle se portera la verif 
| current : positions des reines déjà placées 
| n : le nombre de reines à placer (utilisé pour la taille de la ligne ici) 
** Description : ** Cette fonction vérifie si pour la ligne d'une reine en commencant à l'abcisse fst il exite une position valide pour la reine *)
let verif fst reine current n = 
  let rec aux elt curr = match curr with 
    |[] -> (elt, reine) (* aucune reine n'est en prise avec cette case *)
    |(x,y)::q -> if elt = x || elt + reine = x + y || elt - reine = x - y then (* les trois conditions corespondent aux diagonales et a la ligne horizontal *)
          if (elt + 1) < n then aux (elt +1) current
          else (-1,reine) (* -1 est une valeure arbitriare pour dire que aucune position est valide *)
        else aux elt q
  in aux fst current;;

(* Fonction depilage de type : (int * int) list -> int -> int * int * int
** entrées : ** 
|curr : la liste des positions actuelles des reines sur le plateau
| n : le nombre de reines à placer
** Description : ** Cette fonction est appellée quand on veut revenir en arrière car on est dans une impasse. On renvoit :
| (a+1) = l'abscisse + 1 de la dernière reine qui ne sort pas du tableau
| b = la reine en question
| q = ce qui reste dans la liste de nos solution
*)
let rec depilage curr n = match curr with 
  |[] -> failwith "gros soucis la" (* Jamais censé arriver sauf pour n=2 et n=3 *)
  |(a,b)::q -> if (a+1) < n then (a+1),b,q else depilage q n (*on revient à la dame dont on a pas encore 
                                                                  essayé toutes les cases*)

(* Fonction backtracking de type : int -> (int * int) list
** entrées : ** 
| n : le nombre de reines à placer
** Description : ** C'est la fonction principale, on commence à verifier la case 0,0 en posant la reine 0, 
                    ensuite on place une reine par ligne au fur et à mesure, il nous reste alors plus qu'a trouver une abscisse valide
                    Pour cela on verifie si il existe une abscisse valide sur la ligne à l'aide de la fonction verif.
                    Si la fonction vérif renvoit x=-1 alors il n'y pas de case valide pour la reine, cela signifie que dans la configuration actuelle aucune solution est possible.
                    On revient alors à la reine d'avant pour laquelle on test l'abscisse suivante et ainsi de suite.
                    On stocke tout les coordonnées des reines dans une liste current qu'on renvoit à la fin. *)
let backtracking n = 
  let rec aux current reine depart = 
    if reine < n then
      let (x,y) = verif depart reine current n in
      if x = -1 then 
        let (a,b,c) = depilage current n in aux c b a (* Aucune case valide on revient en arrière *)
      else 
        aux ( (x,y)::current ) (reine + 1) 0 (* Cette case est valide on passe à la reine suivante *)
    else current 
  in aux [] 0 0

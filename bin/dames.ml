(* entrées : 
| fst : abscisse x ou commence la verif 
| reine : ordonnée sur laquelle se portera la verif 
| current : positions des reines déjà placées 
| n : le nombre de reines à placer (utilisé pour la taille de la ligne ici) 

Description : Cette fonction vérifie si à  la ligne d'une reine en commencant à l'abcisse fst il exite une position valide pour la reine *)
let verif fst reine current n = 
  let rec aux elt curr = match curr with 
    |[] -> (elt, reine) (* aucune reine n'est en prise avec cette case *)
    |(x,y)::q -> if elt = x || elt + reine = x + y || elt - reine = x - y then (* les trois conditions corespondent aux diagonales et a la ligne horizontal *)
          if (elt + 1) < n then aux (elt +1) current
          else (-1,reine) (* -1 est une valeure arbitriare pour dire que aucune position est valide *)
        else aux elt q
  in aux fst current;;

  (* Cette fonction est appellée quand on veut revenir en arrière car on est dans une impasse*)
let rec depilage curr n = match curr with 
  |[] -> failwith "gros soucis la"
  |(a,b)::q -> if (a+1) < n then (a+1),b,q else depilage q n (*on revient à la dame dont on a pas encore 
                                                                  essayé toutes les cases*)

let backtracking n = 
  let rec aux current reine depart = 
    if reine < n then
      let (x,y) = verif depart reine current n in
      if x = -1 then 
        let (a,b,c) = depilage current n in aux c b a
      else 
        aux ( (x,y)::current ) (reine + 1) 0
    else current 
  in aux [] 0 0

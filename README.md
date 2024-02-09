# Prérequis
Ce projet est conçu avec dune, ce qui implique que pour compiler le projet dune est requis. Pour cela il faut avoir installé Ocaml (et opamm qui est fournit avec) et taper :
```bash
$ opam install dune ocaml-lsp-server
```
Vous allez avoir également besoin de graphics 
```bash
$ opam install graphics
```
Sur Linux pensez à taper : `eval $(opam config env)`pour que les modules d'opam puissent être utilisé dans le terminal
# Compilation
Pour compiler rendez vous dans le dossier racine projet puis tapez : (marche sur Windows & Linux)
```bash
$ dune build bin/main.exe
```
L'éxécutable sera créer dans __build/defaul/bin/main.exe_ (que ce soit sur Windows ou Linux le fichier a le même nom)
Vous pouvez alors copier le fichier dans le répéertoire de votre choix ou accéder au dossier puis taper le nom du fichier puis le nombre de dames que vous voulez :
```bash
$ ./main.exe 10
```
Lancera le fichier pour le problème à 10 dames (même chose sur windows avec un \ au lieu du /)

# Organisation du projet
Les fichiers permettant de compiler l'éxécutable final sont tous stocké dans le dossier `bin/`  
Vous retrouverez la documentation des fichiers directement en commentaire. 
Pour l'aperçu général des fichier :   
**main.ml :** permet de faire le lien entre les fichiers suivant  
**dames.ml :** contient l'algorithme pour trouver une solution au problème de n-dames  
**affichage.ml :** contient les fonctions d'affichage dans la fenetre graphics   
**queen.ml :** Contient uniquement deux matrices de couleur corespondant à l'image de reine en haute/basse qualité.  

# Compléxité 
## Temporelle
Du au fait que nous utilisons un algo de bactracking, théoriquement on ferait toutes les possibilités soit O($n^n$). Hors en réalité on teste bien moins de possibilités car on en élimine beaucoup : déjà toutes les combinaisons ou des dames sont sur la même ligne sont éliminées. Ensuite du au fait de la symétrie des solution la première dame ne parcourera pas + de la moitié de ses cases possibles. Soit n/2 possibilités pour la première dame. (On remarque aussi que pour n>7 la premiere reine est toujours placée sur la case (0,0)). Par le jeu des symétrie on peut comme ça éliminer des solutions ligne par ligne. 
Nous allons donc dire que la compléxité est O($n^n$) même si en réalité elle est bien inférieure.
## Spatiale 
Etant donné qu'on utilise pas de matrice pour representer l'échiquier, et qu'on stock la les coordonnées des dames solutions dans une liste, la compléxité spatiale est O(n)

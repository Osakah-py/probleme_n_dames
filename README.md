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
L'éxécutable sera créer dans __build/defaul/bin_
# Organisation du projet
Les fichiers permettant de compiler l'éxécutable final sont tous stocké dans le dossier bin/
VOus retrouverez la documentation des fichiers directement en commentaire. 
Pour l'aprçu général des fichier :   
**main.ml :** permet de faire le lien entre les fichiers suivant  
**dames.ml :** contient l'algorithme pour trouver une solution au problème de n-dames  
**affichage.ml :** contient les fonctions d'affichage dans la fenetre graphics   
**queen.ml :** Contient uniquement deux matrices de couleur corespondant à l'image de reine en haute/basse qualité.  

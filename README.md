# Projet d'Informatique Scientifique - Pathfinding

Licence informatique parcours mathématiques-informatique  
Nantes Université - 2024/2025

## Description

Implémentation de 3 algorithmes de recherche de plus court chemin sur une carte en Julia :
- **BFS** : recherche non informée sans coûts
- **Dijkstra** : recherche non informée avec coûts
- **A\*** : recherche informée avec heuristique (distance de Manhattan)
- - **Glouton** : recherche informée, rapide mais non optimale

## Structure du projet
```
ProjetSc/
├── src/
│   ├── carte.jl        # types Position, Carte et fonctions de base
│   ├── BFS.jl          # algorithme BFS
│   ├── dijkstra.jl     # algorithme Dijkstra
│   ├── Aetoile.jl      # algorithme Astar
│   ├── glouton.jl      # algorithme Glouton
│   ├── lecture_map.jl  # lecture des fichiers .map
│   └── main.jl         # fonctions algoBFS, algoDijkstra, algoAstar, algoGlouton
├── test/
│   ├── den201d.map
│   ├── den201d.map.scen
│   ├── den009d.map
│   ├── den009d.map.scen
│   ├── combat.map
│   └── combat.map.scen
├── res/
└── doc/
    ├── algorithme.md   # description des algorithmes
    └── comparaison.md  # étude comparative des résultats              
```
## Utilisation

Depuis le dossier `src/` dans le REPL Julia :
```julia
include("main.jl")
```
Puis appeler un algorithme :
```julia
algoBFS("../test/den201d.map", (20,24), (27,24))
algoDijkstra("../test/den201d.map", (20,24), (27,24))
algoAstar("../test/den201d.map", (20,24), (27,24))
algoGlouton("../test/den201d.map", (20,24), (27,24))
```
Les paramètres sont :
- `fname` : chemin vers le fichier `.map`
- `D` : position de départ sous forme `(ligne, colonne)`
- `A` : position d'arrivée sous forme `(ligne, colonne)`
  
## Dépendances

- Julia 1.11 ou plus
- Package `DataStructures.jl` 

Installation de package :
```julia
using Pkg
Pkg.add("DataStructures")
```



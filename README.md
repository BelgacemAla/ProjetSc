# Projet d'Informatique Scientifique - Pathfinding

Licence informatique parcours mathématiques-informatique  
Nantes Université - 2024/2025

## Description

Implémentation de 3 algorithmes de recherche de plus court chemin sur une carte en Julia :
- **BFS** : recherche non informée sans coûts
- **Dijkstra** : recherche non informée avec coûts
- **A\*** : recherche informée avec heuristique 

## Structure du projet

ProjetSc/
├── src/
│   ├── carte.jl        # types et fonctions de base de la carte 
│   ├── BFS.jl          # algorithme BFS 
│   ├── dijkstra.jl     # algorithme Dijkstra
│   ├── Aetoile.jl      # algorithme A*
│   └── main.jl         # tests
├── dat/                # données (pas encore utilisés pour tester) 
│   ├── den201d.map
│   ├── den201d.map.scen
│   ├── den009d.map
│   ├── den009d.map.scen
│   ├── combat.map
│   └── combat.map.scen
├── res/                
└── doc/                



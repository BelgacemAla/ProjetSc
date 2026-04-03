# Projet d’Informatique Scientifique  
**Pathfinding et Planification Multi-Agents (AMR)**  
Licence Informatique – Parcours Mathématiques-Informatique  
Nantes Université – Année 2024/2025  

---

## 1. Objectif du projet

Ce projet a pour objectif l’implémentation et l’étude d’algorithmes de recherche de plus court chemin sur grille, ainsi que leur extension à un contexte multi-agents.

Il est structuré en deux parties :

- **Partie 1 : Pathfinding mono-agent**  
  Implémentation et comparaison de plusieurs algorithmes classiques de recherche de chemin.

- **Partie 2 : Planification multi-agents (AMR)**  
  Coordination de plusieurs robots autonomes se déplaçant simultanément, avec gestion des conflits.

---

## 2. Algorithmes implémentés

Les algorithmes suivants ont été développés :

- **BFS (Breadth-First Search)**  
  Recherche non informée sans prise en compte des coûts.

- **Dijkstra**  
  Recherche non informée avec gestion des coûts.

- **A\***  
  Recherche informée utilisant une heuristique (distance de Manhattan).

- **Glouton (Greedy Best-First Search)**  
  Recherche rapide basée uniquement sur l’heuristique (non optimale).

Ces algorithmes sont appliqués sur des cartes au format `.map` , et sont plus detailler dans le dossier doc avec les resultats de tests.

---

## 3. Structure du projet

```
ProjetSc/
├── src/
│   ├── carte.jl        
│   ├── lecture_map.jl
│   ├── BFS.jl          Algorithmes de recherche de chemin
│   ├── dijkstra.jl         
│   ├── Aetoile.jl
│   ├── glouton.jl
│   ├── AMR.jl          Algorithme principe A* avec gestion des collisions (Partie 2)
│   ├── simulation.jl   Algorithme d'application des mission dur une carte (Partie 2)
│   └── main.jl
│
├── data/               Cartes et scénarios
│   ├── *.map
│   ├── *.scen
│
├── test/
│   └── exemple_presentation.jl
|   └── test_grille_simple.jl
│   └── test_grille_complexe.jl
├── doc/                Principes des 3 algos et résultats des tests     
│   ├── algorithme.md
│   └── comparaison.md   
│
└── README.md
```

---

## 4. Utilisation – Partie 1 (mono-agent)

Se placer dans le dossier `src/`, puis lancer Julia :

```julia
include("main.jl")
```

Exemples d’exécution :

```julia
algoBFS("../data/den201d.map", (20,24), (27,24))
algoDijkstra("../data/den201d.map", (20,24), (27,24))
algoAstar("../data/den201d.map", (20,24), (27,24))
algoGlouton("../data/den201d.map", (20,24), (27,24))
```

### Paramètres

- `fname` : chemin vers le fichier `.map`
- `D` : position de départ `(ligne, colonne)`
- `A` : position d’arrivée `(ligne, colonne)`

---

## 5. Partie 2 – Planification Multi-Agents (AMR)

Cette partie étend A\* au cas multi-agents.

### Contexte

Cette section traite du déplacement simultané de plusieurs robots tout en évitant les collisions.
Chaque robot doit effectuer une mission (aller d’un point à un autre) tout en respectant des contraintes :

- Pas de collision de position (deux agents au même endroit au même temps)
- Pas d’échange de positions entre deux instants consécutifs
- Prise en compte du temps 

### Principe

- Les agents sont planifiés **séquentiellement**
- Chaque trajectoire validée devient une **contrainte** pour les suivantes
- En cas de conflit :
  - le chemin est rejeté
  - un nouveau chemin est recalculé 

---

## 6. Exécution – Simulation multi-agents


## 7. Dépendances

Le projet nécessite :

- **Julia ≥ 1.11**
- Package : `DataStructures.jl`

Installation :

```julia
using Pkg
Pkg.add("DataStructures")
```
---

## 9. Auteur

Projet réalisé dans le cadre du module d’informatique scientifique.  
Nantes Université – 2024/2025

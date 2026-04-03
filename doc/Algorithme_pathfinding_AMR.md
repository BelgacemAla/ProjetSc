# 1- Planification Multi-Agents (AMR)

Cette partie du projet traite le problème de **Multi-Agent Pathfinding ** dans un environnement discret de type grille.  
L’objectif est de coordonner plusieurs robots (AMR) afin qu’ils atteignent leurs destinations respectives **sans collision**.

---

### Principe général

L’approche repose sur une adaptation de l’algorithme **A\*** en version **spatio-temporelle** :

- L’état d’un agent est défini par un couple `(position, temps)`
- Le temps est discret (1 déplacement = 1 unité de temps)
- Les agents sont planifiés **séquentiellement**
- Chaque trajectoire validée devient une contrainte pour les suivantes

---

### Contraintes gérées

L’algorithme prend en compte les principaux cas de conflit :

- **Collision de sommet**  
  Deux agents ne peuvent pas occuper la même case au même instant

- **Collision d’arête (échange de positions)**  
  Interdiction pour deux agents d’échanger leurs positions entre `t` et `t+1`

- **Attente autorisée**  
  Un agent peut rester sur place pour éviter un conflit (coût = +1)

- **Occupation après arrivée**  
  Une fois arrivé, un agent bloque sa position pour les suivants

---

### Implémentation

Le cœur de la logique est implémenté dans `AMR.jl`.

On utilise :

- une version modifiée de **A\*** avec dimension temporelle
- une structure `Set` pour stocker les cases interdites `(x, y, t)`
- une liste d’agents déjà planifiés pour vérifier les conflits dynamiques

Chaque agent est représenté par :

```julia
mutable struct AMR 
    id :: Int
    depart :: Position
    arrive :: Position
    chemin :: Vector{Tuple{Position,Int}}
end
```

---

### Cas de tests

L’implémentation a été validée progressivement sur plusieurs scénarios :

- **Cas simples**
  - croisement de deux agents
  - face-à-face dans un couloir
  - attente devant un passage étroit

- **Cas test de Présentation du projet ( pour verifié que algorithme valide )**
  - plusieurs agents avec conflits simultanés
  - gestion de priorités (ordre de planification)

- **Cas complexes**
  - environnement de type entrepôt
  - plusieurs agents avec des temps de départ différents
  - circulation dense dans des couloirs contraints

---

### Exemple de résultat

Sur un scénario avec plusieurs agents :

- Un agent prioritaire suit un chemin direct
- Un second agent attend pour éviter un conflit au croisement
- Les autres agents adaptent leur trajectoire sans blocage global

Résultat observé :

- toutes les missions sont accomplies
- aucun conflit détecté
- temps total dépendant de la densité du trafic

---
# 2- Simulation multi-agents

La simulation permet d’exécuter et visualiser les déplacements des AMR dans le temps, après planification.
Elle repose sur deux fonctions principales :

- `simulation`  
  Planifie les agents un par un avec `Astar_multi`, puis lance l’exécution temporelle.
  Chaque agent suit son chemin tout en respectant les contraintes de collision.

- `afficher_instant`  
  Affiche l’état de la grille à un instant donné avec la position de chaque AMR.

---

### Lancement

```bash
julia test/exemple_presentation.jl
```

---

### Affichage

- `.` : case libre  
- `+` : obstacle  
- `1, 2, 3, ...` : agents  

---

### Exemple visuel

Cas simple : deux agents en face-à-face

**t = 1**

```
. . . . .
. 1 . 2 .
. . . . .
```

**t = 2**

```
. . . . .
. . 1 2 .
. . . . .
```

**t = 3 (conflit évité)**

```
. . . . .
. . 1 . .
. . 2 . .
```

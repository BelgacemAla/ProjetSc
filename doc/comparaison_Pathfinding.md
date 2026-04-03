# Étude comparative des algorithmes de Pathfinding

Les quatre algorithmes sont testés sur trois instances de la collection movingai :
`den201d.map` (37×37), `combat.map` (177×193), `den009d.map` (50×34).  
Les coûts optimaux de référence proviennent des fichiers `.scen` associés.  
Les déplacements sont limités aux 4 directions (N/S/E/O), sans diagonales.

---

## Instance 1 : `den201d.map`

### D=(23,11) → A=(23,8) | Optimal : 3

| Algorithme | Coût | États explorés | Temps (s) | Optimal ? |
|------------|------|----------------|-----------|-----------|
| BFS        | 3.0  | 24             | 0.000017  | oui       |
| Dijkstra   | 3.0  | 19             | 0.000022  | oui       |
| A*         | 3.0  | 4              | 0.000014  | oui       |
| Glouton    | 3.0  | 4              | 0.000015  | oui       |

### D=(29,23) → A=(21,23) | Optimal : 8

| Algorithme | Coût | États explorés | Temps (s) | Optimal ? |
|------------|------|----------------|-----------|-----------|
| BFS        | 8.0  | 83             | 0.000028  | oui       |
| Dijkstra   | 8.0  | 99             | 0.000052  | oui       |
| A*         | 8.0  | 9              | 0.000014  | oui       |
| Glouton    | 8.0  | 9              | 0.000061  | oui       |


---

## Instance 2 : `combat.map` 

### D=(148,113) → A=(148,117) | Optimal : 4

| Algorithme | Coût | États explorés | Temps (s) | Optimal ? |
|------------|------|----------------|-----------|-----------|
| BFS        | 4.0  | 40             | 0.000208  | oui       |
| Dijkstra   | 4.0  | 37             | 0.000201  | oui       |
| A*         | 4.0  | 5              | 0.000182  | oui       |
| Glouton    | 4.0  | 5              | 0.000165  | oui       |

### D=(15,164) → A=(40,164) | Optimal : 25

| Algorithme | Coût | États explorés | Temps (s) | Optimal ? |
|------------|------|----------------|-----------|-----------|
| BFS        | 25.0 | 739            | 0.000356  | oui       |
| Dijkstra   | 25.0 | 751            | 0.000578  | oui       |
| A*         | 25.0 | 26             | 0.000360  | oui       |
| Glouton    | 25.0 | 26             | 0.000209  | oui       |

### D=(156,37) → A=(75,37) | Optimal : 81

| Algorithme | Coût  | États explorés | Temps (s) | Optimal ? |
|------------|-------|----------------|-----------|-----------|
| BFS        | 81.0  | 8074           | 0.002035  | oui       |
| Dijkstra   | 81.0  | 8181           | 0.006131  | oui       |
| A*         | 81.0  | 82             | 0.000371  | oui       |
| Glouton    | 81.0  | 82             | 0.000418  | oui       |

---

## Instance 3 : `den009d.map` 

### D=(22,13) → A=(22,11) | Optimal : 2

| Algorithme | Coût | États explorés | Temps (s) | Optimal ? |
|------------|------|----------------|-----------|-----------|
| BFS        | 2.0  | 13             | 0.000011  | oui       |
| Dijkstra   | 2.0  | 11             | 0.000019  | oui       |
| A*         | 2.0  | 3              | 0.000010  | oui       |
| Glouton    | 2.0  | 3              | 0.000011  | oui       |

### D=(3,9) → A=(18,9) | Optimal : 15

| Algorithme | Coût | États explorés | Temps (s) | Optimal ? |
|------------|------|----------------|-----------|-----------|
| BFS        | 15.0 | 168            | 0.000105  | oui       |
| Dijkstra   | 15.0 | 169            | 0.000144  | oui       |
| A*         | 15.0 | 16             | 0.000030  | oui       |
| Glouton    | 15.0 | 16             | 0.000093  | oui       |

---

## Synthèse

| Algorithme | Coût optimal garanti | Informé | États explorés | Temps       |
|------------|----------------------|---------|----------------|-------------|
| BFS        | oui (sans coûts)     | non     | Élevé          | Rapide      |
| Dijkstra   | oui                  | non     | Élevé          | Plus lent   |
| A*         | oui                  | oui     | Très faible    | Très rapide |
| Glouton    | non                  | oui     | Très faible    | Très rapide |

## Analyse

**BFS** explore un grand nombre de cases car il avance dans toutes les directions
sans tenir compte des coûts ni de la position de l'arrivée.

**Dijkstra** explore encore plus de cases que BFS car il maintient et met à jour
les coûts de tous les chemins via la file de priorité, ce qui explique aussi son
temps de calcul plus élevé.

**A\*** est le plus efficace : l'heuristique de Manhattan guide la recherche
directement vers l'arrivée. Sur l'instance la plus grande (combat.map, optimal=81),
il explore **100x moins de cases** que BFS et Dijkstra tout en garantissant
le chemin optimal.

**Glouton** explore le même nombre de cases que A\* sur ces instances car les
chemins sont dégagés. Il n'est pas optimal en général mais donne ici les bons
résultats car le chemin le plus direct est aussi le moins coûteux.

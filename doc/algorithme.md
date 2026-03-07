# Algorithmes de Pathfinding

## 1. BFS 

### Description
Algorithme de recherche en largeur il explore les cases voisines niveau par niveau à partir du départ. Utilise une file FIFO et ne tient pas compte des coûts des cases
### Propriétés
- Complet : trouve toujours un chemin s'il existe
- Recherche non informée
- Non optimal : minimise le nombre de cases, pas le coût
  
### Complexité
O(V + E) avec V nombre des cases et E arêtes
Explication : 
Il visite chaque case une seule fois (V cases)
Pour chaque case, il regarde tous ses voisins (E arêtes au total)

### Référence

## 2. Dijkstra

### Description
Explore les cases par ordre de coût croissant depuis le départ. 
Utilise une file de priorité et il tient compte des coûts des cases

### Propriétés
- Complet : trouve toujours un chemin s'il existe
- Optimal : garantit le chemin de coût minimal
- Recherche non informée
- Requiert des coûts non négatifs

### Complexité
O((V + E) log V)
Explication : 
Même principe que BFS mais utilise une file de priorité
Chaque insertion/mise à jour dans la file coûte log V

### Référence

## 3. A* 

### Description
Extension de Dijkstra qui utilise une heuristique h(v) pour guider la recherche vers l'arrivée.
La priorité est f(v) = g(v) + h(v) où g est le coût réel parcouru et h est la distance de Manhattan.

### Propriétés
- Complet : trouve toujours un chemin s'il existe
- Optimal : garantit le chemin de coût minimal si h est admissible
- Recherche informée — explore moins de cases que Dijkstra
- Heuristique utilisée : distance de Manhattan |Δx| + |Δy|
 
### Complexité
O(E) dans le meilleur cas avec bonne heuristique
Il explore seulement les cases sur le chemin optimal, sans se disperser
### Référence

## 4. Glouton  

### Description
Similaire à A* mais ignore le coût déjà parcouru.
La priorité est f(v) = h(v) uniquement alors  il fonce vers l'arrivée sans regarder ce qu'il a déjà coûté.

### Propriétés
- Complet : trouve un chemin s'il existe
- Non optimal 
- Recherche informée 
- Heuristique utilisée : distance de Manhattan

### Complexité
- Temps : O(E log V)

### Référence


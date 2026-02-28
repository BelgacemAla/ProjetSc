
using DataStructures

# initialisation des données utilisé 
function init_d(carte)
    # initialise à valeur grande pour chercher toujours le moins cher cout
    cout = fill(Inf, carte.nb_l,carte.nb_col) 
    cout[carte.depart.x, carte.depart.y] = 0.0 
    parent = fill(Position(0,0), carte.nb_l, carte.nb_col) 
    return cout , parent
end

# algorithme qui trouve le chemin avec cout minimal
function dijkstra(c::Carte)
    D = c.depart
    A = c.arrive
    
    cout, parent = init_d(c)
    # file de priorité qui avance la position avec le plus petit cout
    file = PriorityQueue{Position, Float64}()
    enqueue!(file, D, 0.0)
    while !isempty(file)
        pos = dequeue!(file) 
        # cas d'arrivé on retourne le chemin et le cout utilisé
        if pos == A
            return reconstruction_chemin(parent, D, A), cout[A.x, A.y]
        end

        # explore les voisin et on calcule le chemin avec leur cout et on choisit me moins cher
        for v in voisins(c,pos)
            nouv_cout = cout[pos.x, pos.y] + c.couts[v.x, v.y]
            if nouv_cout < cout[v.x, v.y]
                cout[v.x, v.y]   = nouv_cout
                parent[v.x, v.y] = pos
                enqueue!(file, v, nouv_cout)
            end
        end
    end   
end

println("test : ")
grille = [0  0  1  0 ;
          5 -1 -1  0 ;
          0  2 0  1]

c = creation_carte(grille, Position(3,1), Position(1,1))
affichage_carte(c)
resultat = dijkstra(c)
if resultat == nothing
    println("Aucun chemin trouvé")
else
    chemin, cout = resultat
    println("Chemin : ", chemin)
    println("Coût   : ", cout)
end
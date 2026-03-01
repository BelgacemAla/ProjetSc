#dijkstra.jl
using DataStructures

# initialisation des données utilisé 
function init_d(carte)
    # initialise à valeur grande pour chercher toujours le moins cher cout
    cout = fill(Inf, carte.nb_l,carte.nb_col) 
    cout[carte.depart.x, carte.depart.y] = 0.0 
    parent = fill(Position(0,0), carte.nb_l, carte.nb_col) 
    visite = falses(carte.nb_l, carte.nb_col)
    return cout , parent, visite
end

# algorithme qui trouve le chemin avec cout minimal
function dijkstra(c::Carte)
    D = c.depart
    A = c.arrive
    
    cout, parent, visite = init_d(c)
    noeuds_explores = 0

    # file de priorité qui avance la position avec le plus petit cout
    file = PriorityQueue{Position, Float64}()
    enqueue!(file, D, 0.0)
    while !isempty(file)
        pos = dequeue!(file) 
        noeuds_explores +=1

        if !visite[pos.x, pos.y]
            visite[pos.x, pos.y] = true

            # cas d'arrivé on retourne le chemin et le cout utilisé
            if pos == A
                return reconstruction_chemin(parent, D, A), cout[A.x, A.y], noeuds_explores
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
    nothing, nothing, noeuds_explores
end

#A*.jl
using DataStructures

# distance Manhattan
function heuristique(pos, arrive)
    return abs(pos.x - arrive.x) + abs(pos.y - arrive.y)
end

# initialisation des donnees utilisees 
function init_a(carte)
    g = fill(Inf, carte.nb_l, carte.nb_col)
    g[carte.depart.x, carte.depart.y] = 0.0
    parent = fill(Position(0,0), carte.nb_l, carte.nb_col)
    return g, parent
end

function Aetoile(c::Carte)
    D = c.depart
    A = c.arrive
    
    g, parent = init_a(c)
    # file de priorité qui avance la position avec le plus petit cout
    file = PriorityQueue{Position, Float64}()
    enqueue!(file, D, heuristique(D, A))

    noeuds_explores = 0
    while !isempty(file)
        pos = dequeue!(file) 
        noeuds_explores +=1
            # cas d'arrivé on retourne le chemin et le cout utilisé
            if pos == A
                return reconstruction_chemin(parent, D, A), g[A.x, A.y],noeuds_explores
            end

            # explore les voisin et on calcule le chemin avec leur cout et on choisit me moins cher
            for v in voisins(c,pos)
                nouv_g = g[pos.x, pos.y] + c.couts[v.x, v.y]
                if nouv_g < g[v.x, v.y]
                    g[v.x, v.y]   = nouv_g
                    parent[v.x, v.y] = pos
                    enqueue!(file, v, nouv_g + heuristique(v, A))
                end
            end
        end 
    nothing, nothing, noeuds_explores
end


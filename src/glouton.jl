# glouton.jl
using DataStructures

# identique à Astar mais la difference qu'il fonce vers l'arrivée sans regarder le cout du chemin deja parcouru
function glouton(c::Carte)
    D = c.depart
    A = c.arrive
    
    g, parent, visite = init_a(c)
    file = PriorityQueue{Position, Float64}()
    enqueue!(file, D, heuristique(D, A))
    noeuds_explores = 0

    while !isempty(file)
        pos = dequeue!(file)
        noeuds_explores += 1
        if !visite[pos.x, pos.y]
            visite[pos.x, pos.y] = true
            if pos == A
                return reconstruction_chemin(parent, D, A), g[A.x, A.y], noeuds_explores
            end
            for v in voisins(c, pos)
                nouv_g = g[pos.x, pos.y] + c.couts[v.x, v.y]
                if nouv_g < g[v.x, v.y]
                    g[v.x, v.y]   = nouv_g
                    parent[v.x, v.y] = pos
                    if haskey(file, v)
                        file[v] = heuristique(v, A)
                    else
                        enqueue!(file, v, heuristique(v, A))
                    end
                end
            end
        end
    end
    nothing, nothing, noeuds_explores
end
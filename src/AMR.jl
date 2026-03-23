# Structure représentant un AMR et sa mission avec mise à jour du A* pour plusieurs AMR

include("carte.jl")
include("BFS.jl")  
include("Aetoile.jl")
using DataStructures

mutable struct AMR 
    id :: Int
    depart :: Position
    arrive :: Position
    chemin :: Vector{Tuple{Position,Int}}  # liste de (position, temps)
end

# constructeur AMR 

# Astar modifié pour plusieurs AMR
# cases_interdites : Set des (x, y, t) déjà réservés par les AMR planifiés avant
# t_debut : instant où cet AMR commence sa mission
function Astar_multi(c::Carte, cases_interdites::Set{Tuple{Int,Int,Int}}, t_debut::Int , amrs::Vector{AMR})
    D = c.depart
    A = c.arrive

    g, parent, visite = init_a(c)

    # tableau qui stocke à quel instant on atteint chaque case
    temps = fill(0, c.nb_l, c.nb_col)
    temps[D.x, D.y] = t_debut

    file = PriorityQueue{Position, Float64}()
    enqueue!(file, D, heuristique(D, A))

    noeuds_explores = 0

    while !isempty(file)
        pos = dequeue!(file)
        noeuds_explores += 1

        if !visite[pos.x, pos.y]
            visite[pos.x, pos.y] = true

            if pos == A
                # on reconstruit le chemin comme dans la partie 1
                chemin_pos = reconstruction_chemin(parent, D, A)

                # on construit le chemin avec les temps 
                chemin = [(chemin_pos[i], t_debut + i -1) for i in 1:length(chemin_pos)]
                return chemin, g[A.x, A.y], noeuds_explores
            end

            for v in voisins(c, pos)
                # instant où on arriverait sur ce voisin
                t_voisin = temps[pos.x, pos.y] + 1
                # on passe au voisin suivant si on a case interdite à cet instant 
                if (v.x, v.y, t_voisin) in cases_interdites
                    continue
                end
                
                # on passe au voisin suivant si on fait un echange
                echange = false 
                for amr in amrs
                    for i in 1:length(amr.chemin)-1
                        (avant, t1) = amr.chemin[i]  
                        (apres, t2) = amr.chemin[i+1]
                        # cas d'echange de positions
                        if avant == v && apres == pos && t1 == t_voisin - 1
                            echange = true
                        end
                    end
                end
                if echange
                    continue
                end
                
 
                nouv_g = g[pos.x, pos.y] + c.couts[v.x, v.y]
                if nouv_g < g[v.x, v.y]
                    g[v.x, v.y]      = nouv_g
                    parent[v.x, v.y] = pos
                    # mémorisation d'instant où on atteint ce voisin
                    temps[v.x, v.y]  = t_voisin
                    if haskey(file, v)
                        file[v] = nouv_g + heuristique(v, A)
                    else
                        enqueue!(file, v, nouv_g + heuristique(v, A))
                    end
                end
            end
        end
    end

    return nothing, nothing, noeuds_explores
end


# après planification d'un AMR, on enregistre son chemin dans cases_interdites
# pour que les AMR suivants ne pourront pas passer par ces cases à ces instants
function enregistrer_chemin!(cases_interdites, chemin,amrs)
    for (pos, t) in chemin
        push!(cases_interdites, (pos.x, pos.y, t))
    end
    
    # temps d'arrivée de l'AMR courant
    t_fin = maximum(last(amr.chemin[end]) for amr in amrs)

    # si un AMR déjà planifié arrive avant l'AMR courant
    # on bloque sa position finale jusqu'au temps de fin de l'AMR courant
    for amr in amrs
        (pos_fin, t_fin_avant) = amr.chemin[end]
        if t_fin_avant < t_fin
            for t_extra in t_fin_avant:t_fin
                push!(cases_interdites, (pos_fin.x, pos_fin.y, t_extra))
            end
        end
    end
end
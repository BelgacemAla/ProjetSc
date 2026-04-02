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


const Etat = Tuple{Position, Int}      # etat de robot : position à instant t
const TableCouts = Dict{Etat, Float64} # dictionnaire des couts 
const TableParents = Dict{Etat, Etat}


# Astar modifié pour plusieurs AMR
# cases_interdites : Set des (x, y, t) déjà réservés par les AMR planifiés avant
# t_debut : instant où cet AMR commence sa mission
function Astar_multi(c::Carte, cases_interdites::Set{Tuple{Int,Int,Int}}, t_debut::Int , amrs::Vector{AMR})
    D = c.depart
    A = c.arrive

    g = TableCouts()
    parent = TableParents()
    file =  PriorityQueue{Etat, Float64}()

    depart_etat::Etat = (D, t_debut)
    g[depart_etat] = 0.0
    enqueue!(file, depart_etat, heuristique(D, A))

    noeuds_explores = 0

    while !isempty(file)
        (pos ,t)= dequeue!(file)
        noeuds_explores += 1

        if t > t_debut + 200 continue end

        if pos == A
            return reconstruction_chemin_multi(parent, depart_etat, (pos, t)), g[(pos, t)], noeuds_explores
        end

        # position courante comme voisin permet de rester dur place
        tous_voisins = voisins(c, pos)
        push!(tous_voisins, pos)

        for v in tous_voisins
            t_voisin = t + 1
            etat_voisin = (v, t_voisin)

            # Interdiction passage sur cases occupé instant t
            if (v.x, v.y, t_voisin) in cases_interdites
                continue
            end
                
            # Interdiction de passage au dessus amr
            echange = false 
            for amr in amrs
                # CAS echange positions
                if a_ete_sur_position_a_t(amr, v, t) && a_ete_sur_position_a_t(amr, pos, t_voisin)
                    echange = true
                    break
                end
                # CAS d'un robot deja arrivé à cette position
                (p_fin, t_fin) = amr.chemin[end]
                if v == p_fin && t_voisin >= t_fin  
                    echange = true 
                    break
                end
            end
    
            if echange continue end

            if (v == pos)  # ne bouge pas mais temps passe alors cout = 1
                nouv_g = g[(pos, t)] + 1 
            else 
                nouv_g = c.couts[v.x, v.y] + g[(pos, t)]
            end

            # Position n'a jamais été visité dans ce temps 
            # ou on a trouvé chemin moins couteux à travers  
            if !haskey(g,etat_voisin) || nouv_g < g[etat_voisin]
                g[etat_voisin]   = nouv_g
                parent[etat_voisin] = (pos,t)
                priorite = nouv_g + heuristique(v, A)
                file[etat_voisin] = priorite
            end
        end
    end
    return nothing, nothing, noeuds_explores
end

# reconstruire le chemin des etats à partir de tableau de parents
function reconstruction_chemin_multi(parent, depart_etat, arrive_etat)
    chemin = Etat[]
    courant = arrive_etat
    while courant != depart_etat
        pushfirst!(chemin, courant)
        courant = parent[courant]
    end
    pushfirst!(chemin, depart_etat)
    return chemin
end


# Fonction pour vérifier si un AMR était à une position donnée à un instant t
function a_ete_sur_position_a_t(amr::AMR, pos::Position, t::Int)
    for (p, ti) in amr.chemin
        if p == pos && ti == t
            return true
        end
    end
    return false
end

# après planification d'un AMR, on enregistre son chemin 
# pour que les AMR suivants ne pourront pas passer par ces cases à ces instants
function enregistrer_chemin!(cases_interdites, chemin,amrs)
    for (pos, t) in chemin
        push!(cases_interdites, (pos.x, pos.y, t))
    end
end
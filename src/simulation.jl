# Gère la simulation multi-AMR
#   - afficher_instant : affiche la grille à un instant t avec les AMR positionnés
#   - simulation : planifie les AMR un par un avec Astar_multi et affiche la grille à chaque instant jusqu'à ce que tous arrivent

include("carte.jl")
include("AMR.jl")

function afficher_instant(carte::Carte, amrs::Vector{AMR}, t::Int)

    for i in 1:carte.nb_l
        for j in 1:carte.nb_col

            # voir si un AMR est sur cette case à l'instant t 
            id_cour = nothing
            for amr in amrs
                # cas de l'arrivé avant la fin du temps
                (pos_finale, t_finale) = amr.chemin[end]
                if t > t_finale && pos_finale.x == i && pos_finale.y == j
                    id_cour = amr.id
                    break
                end
                # affichage du reste
                trouve = false            # evité boucle si trouvé 
                for (pos, ti) in amr.chemin
                    if pos.x == i && pos.y == j && ti == t
                        id_cour = amr.id
                        trouve = true
                        break
                    end                    
                end
                if trouve break end
            end
            if id_cour !== nothing
                print(" $(id_cour) ")
            elseif carte.grille[i, j] == -1
                print(" + ")
            else
                print(" . ")
            end
        end
        println()
    end
end

function simulation(carte::Carte, missions::Vector{Tuple{Position,Position,Int}})

    cases_interdites = Set{Tuple{Int,Int,Int}}()
    amrs = AMR[]

    # planification AMR par AMR
    for (id, (depart, arrive, t_debut)) in enumerate(missions) 
        carte_amr = Carte(carte.grille, carte.couts, carte.nb_l, carte.nb_col, depart, arrive)
        chemin, cout, _ = Astar_multi(carte_amr, cases_interdites, t_debut , amrs)

        if chemin === nothing
            println("AMR $id : aucun chemin trouvé")
        else
            amr_courant = AMR(id, depart, arrive, chemin)
            println("AMR $id : $(length(chemin)-1) pas, coût=$cout")      
            push!(amrs, amr_courant)
            enregistrer_chemin!(cases_interdites, chemin, amrs)       
        end
    end

    if isempty(amrs)
        println("Aucun AMR n'a pu être planifié")
        return
    end
    # recherche de temps de la fin
    t_max = maximum(last(amr.chemin[end]) for amr in amrs) 
    for t in 1:t_max
        println("\nt = $t")
        afficher_instant(carte, amrs, t)
    end
end


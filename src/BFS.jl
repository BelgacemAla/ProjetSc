#BFS.jl
using DataStructures

# Permet de touver les parent depuis la position d'arrivé jusqu'au depart
function reconstruction_chemin(parent, depart, arrive)
    chemin = Position[]
    pos = arrive
    # Ajout du case courante du chemin jusqu'à l'arrivé au depart
    while pos != depart
        push!(chemin, pos)
        pos = parent[pos.x, pos.y] # Remonte au parent
    end
    push!(chemin, depart)
    return reverse(chemin)  # Pour avoir du depart à l'arrivé
end

# Initialisation des structures utilisé
# Tableau de bool pour marquer les cases visité
# Tableau de positions initialé à (0,0) pour sauvegarder les chemin vers positions 
function init(c::Carte)
    visite = falses(c.nb_l, c.nb_col) 
    visite[c.depart.x, c.depart.y] = true
    parent = fill(Position(0,0), c.nb_l, c.nb_col)
    return visite, parent
end

# Fonction qui permet de traiter les voisins d'une position courante en l'ajoutant dans la file
function app_voisin(visite, parent, file, voisin, pos)
    if !visite[voisin.x, voisin.y]
        visite[voisin.x, voisin.y] = true
        parent[voisin.x, voisin.y] = pos
        enqueue!(file, voisin)
    end
end

function bfs(c::Carte)
    D = c.depart
    A = c.arrive
    file = Queue{Position}()
    enqueue!(file, D)

    visite , parent = init(c)
    noeuds_explores = 0
    while !isempty(file)
        pos = dequeue!(file)   # défiler le premier element
        noeuds_explores +=1
        # Si on atteint l'arrivé
        if pos == A 
            return reconstruction_chemin(parent, D, A),0.0, noeuds_explores
        end
        # Sinon on traite ses voisins
        for v in voisins(c, pos)
            app_voisin(visite, parent, file, v, pos)
        end
    end
    nothing, nothing, noeuds_explores
end


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
    cout = fill(0.0, c.nb_l, c.nb_col)
    parent = fill(Position(0,0), c.nb_l, c.nb_col)
    return visite, parent, cout
end


function bfs(c::Carte)
    D = c.depart
    A = c.arrive
    file = Queue{Position}()
    enqueue!(file, D)

    visite , parent , cout= init(c)

    noeuds_explores = 0
    while !isempty(file)
        pos = dequeue!(file)   # défiler le premier element
        noeuds_explores +=1
        # Si on atteint l'arrivé
        if pos == A 
            chemin = reconstruction_chemin(parent, D, A)
            return chemin,cout[A.x,A.y], noeuds_explores
        end
        # Sinon on traite ses voisins de la position courante en l'ajoutant dans la file
        for v in voisins(c, pos)
            if !visite[v.x, v.y]        
                visite[v.x, v.y] = true
                parent[v.x, v.y] = pos
                cout[v.x, v.y] = cout[pos.x, pos.y] + c.couts[v.x, v.y]
                enqueue!(file, v)
            end
        end
    end
    nothing, nothing, noeuds_explores
end


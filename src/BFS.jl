
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
        push!(file,voisin)
    end
end

function bfs(c::Carte)
    D = c.depart
    A = c.arrive
    file = [D]
    visite , parent = init(c)
    
    while !isempty(file)
        pos = popfirst!(file)   # défiler le premier element

        # Si on atteint l'arrivé
        if pos == A 
            return reconstruction_chemin(parent, D, A)
        end
        # Sinon on traite ses voisins
        for v in voisins(c, pos)
            app_voisin(visite, parent, file, v, pos)
        end
    end
end

# test 1
grille = [0  0  0  0 ;
          0 -1 -1  0 ;
          0 -1  0  0]

c = creation_carte(grille, Position(3,1), Position(1,4))
affichage_carte(c)
println(" test : normal ")
chemin = bfs(c)
println("Chemin : ", chemin)
println("Longueur : ", length(chemin) - 1)

#####################################################

# test 2 
println()
println(" test : impossible ")
grille = [-1  0  0  0 ;
          0 -1 -1  0 ;
          0 -1  0  0]

c = creation_carte(grille, Position(3,1), Position(1,4))
affichage_carte(c)

chemin = bfs(c)
println("Chemin : ", chemin)

#####################################################

# test 3
println()
println(" test : optimal ")
grille = [0  0  0  0 ;
          0 -1 -1  0 ;
          0 0  0  0]

c = creation_carte(grille, Position(3,1), Position(1,1))
affichage_carte(c)

chemin = bfs(c)
println("Chemin : ", chemin)
println("Longueur : ", length(chemin) - 1)

################################################

#test4
println()
println(" test : même position ")
grille = [0  0  0  0 ;
          0 -1 -1  0 ;
          0 0  0  0]

c = creation_carte(grille, Position(3,1), Position(3,1))
affichage_carte(c)

chemin = bfs(c)
println("Chemin : ", chemin)
println("Longueur : ", length(chemin) - 1)
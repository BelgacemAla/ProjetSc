# fichier qui contient les propriété d'une carte

struct Position
    x::Int  #ligne
    y::Int  #colonne
end 

struct Carte
    grille::Matrix{Int}   # valeurs des cases
    nb_l::Int             # nombre des lignes
    nb_col::Int           # nombre des colonnes
    depart::Position
    arrive::Position
end

# constructeur d'une carte
function creation_carte(grille, depart::Position, arrive::Position)
    l,c = size(grille)
    return Carte(grille, l, c, depart,arrive)
end

# affichage d'une carte dans le terminal
function affichage_carte(c::Carte)
    for i in 1:c.nb_l
        for j in 1:c.nb_col
            v = c.grille[i,j]
            p = Position(i,j)
            if p == c.depart
                print(" D ")
            elseif p == c.arrive
                print(" A ")
            elseif v == -1
                print(" × ")
            else 
                print(" . ")
            end
        end
        println()
    end
end

# test
grille = [0  0  0  0 ;
          0 -1 -1  0 ;
          0  0  0  0]
c = creation_carte(grille, Position(3,1), Position(1,4))
affichage_carte(c)       
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
function creation_carte(grille, depart::Position, arrive:Position)
    l,c = size(grille)
    return Carte(grille, l, c, depart,arrive)
end

# affichage d'une carte dans le terminal
function affichage_carte()
    
end


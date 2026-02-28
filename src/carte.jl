# fichier qui contient les propriété d'une carte

struct Position
    x::Int  #ligne
    y::Int  #colonne
end 

struct Carte
    grille::Matrix{Int}    # valeurs des cases
    couts::Matrix{Float64} # cout de traverse 
    nb_l::Int              # nombre des lignes
    nb_col::Int            # nombre des colonnes
    depart::Position
    arrive::Position
end

# constructeur d'une carte
function creation_carte(grille, depart, arrive)
    l, c = size(grille)
    couts = ones(Float64, l, c)     # initialise les couts par defaut à 1
    for i in 1:l, j in 1:c
        # cas d'obstacle
        if grille[i,j] == -1
            couts[i,j] = 0  
        # zone pénalisante      
        elseif grille[i,j] == 5
            couts[i,j] = 5.0         
        end
    end
    return Carte(grille, couts, l, c, depart, arrive)
end

# affichage d'une carte dans le terminal
function affichage_carte(c)
    for i in 1:c.nb_l
        for j in 1:c.nb_col
            v = c.grille[i, j]
            p = Position(i, j)
            if p == c.depart
                print(" D ")
            elseif p == c.arrive
                print(" A ")
            elseif v == -1
                print(" × ")
            elseif v == 5
                print(" 5 ")   
            else
                print(" . ")
            end
        end
        println()
    end  
end

# retourne les voisins valides d'une position 
function voisins(carte::Carte, pos::Position)
    result = Position[]
    # Nord
    if pos.x - 1 >= 1 && carte.grille[pos.x-1, pos.y] != -1  
        push!(result, Position(pos.x-1, pos.y)) 
    end  
    # Sud
    if pos.x + 1 <= carte.nb_l && carte.grille[pos.x+1, pos.y] != -1  
        push!(result, Position(pos.x+1, pos.y)) 
    end  
    # Est
    if pos.y + 1 <= carte.nb_col && carte.grille[pos.x, pos.y+1] != -1  
        push!(result, Position(pos.x, pos.y+1)) 
    end  
    # Ouest
    if pos.y - 1 >= 1  && carte.grille[pos.x, pos.y-1] != -1  
        push!(result, Position(pos.x, pos.y-1))  
    end 
    return result
end
# test
grille = [0  0  5  0 ;
          0 -1 -1  0 ;
          0  0  0  0]
c = creation_carte(grille, Position(3,1), Position(1,4))
affichage_carte(c)
println("tableau des couts")
println(c.couts)       
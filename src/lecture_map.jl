include("carte.jl")
function char_to_val(c)
     # obstacle
    if c == '@' || c == 'O' || c == 'T'
        return -1  
    elseif c == 'S'
        return 5   
    elseif c == 'W'
        return 8   
    else
        return 0    # terrain normal
    end
end

function map_to_carte(fichier, depart::Position, arrive::Position)
    lines = readlines(fichier)
    height = parse(Int, split(lines[2])[2])    
    width  = parse(Int, split(lines[3])[2])
    grille = zeros(Int, height, width)

    for i in 1:height
        ligne = lines[4 + i]   
        for j in 1:width
            grille[i,j] = char_to_val(ligne[j])
        end
    end

    return creation_carte(grille, depart, arrive)

end

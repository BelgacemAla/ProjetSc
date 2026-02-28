using DataStructures

# initialisation des données utilisé 
function init(carte)
    # initialise à valeur grande pour chercher toujours le moins chere cout
    cout = fill(Inf, c.nb_l,c.nb_col) 
    cout[carte.depart.x, carte.depart.y] = 0.0 
    parent = fill(Position(0,0), carte.nb_l, carte.nb_col) 
    return parent, cout
end


using DataStructures

# distance Manhattan
function heuristique(pos, arrive)
    return abs(pos.x - arrive.x) + abs(pos.y - arrive.y)
end

# initialisation des donnees utilisees 
function init_a(carte)
    g = fill(Inf, carte.nb_l, carte.nb_col)
    g[carte.depart.x, carte.depart.y] = 0.0
    parent = fill(Position(0,0), carte.nb_l, carte.nb_col)
    return g, parent
end
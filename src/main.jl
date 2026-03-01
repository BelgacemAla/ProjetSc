include("carte.jl")
include("BFS.jl")
include("Aetoile.jl")
include("dijkstra.jl")

grille = [3  0  0  0 ;
          -1 -1 -1 0;
          0  5  0  0]
c = creation_carte(grille, Position(3,1), Position(1,4))
affichage_carte(c)

function tester_algo(algo, carte, nom_algo)
    t_start = time()
    chemin, cout, noeuds = algo(carte)
    t_end = time()
    temps = t_end - t_start

    if chemin === nothing
        println("$nom_algo : Aucun chemin trouvé")
    else
        println("$nom_algo :")
        println("  Longueur chemin : ", length(chemin)-1)
        println("  Coût total      : ", cout)
        println("  Noeuds explorés : ", noeuds)
        println("  Temps           : ", temps)
    end
end

tester_algo(bfs, c, "BFS")
tester_algo(Aetoile, c, "A*")
tester_algo(dijkstra, c, "Dijkstra")  
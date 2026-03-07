include("carte.jl")
include("BFS.jl")
include("Aetoile.jl")
include("dijkstra.jl")
include("glouton.jl")
include("lecture_map.jl")

# Application directe des algorithmes sur les maps dans dossier test 

function algoBFS(fname, D::Tuple{Int64,Int64}, A::Tuple{Int64,Int64})
    c = map_to_carte(fname, Position(D[1],D[2]), Position(A[1],A[2]))
     t = @elapsed chemin, cout, noeuds = bfs(c)
    if chemin === nothing
        println("Aucun chemin trouvé")
    else
        println("Distance D → A : ", cout)
        println("Nombre d'états explorés : ", noeuds)
        println("Temps de calcul : ", round(t, digits=6), " s")
        print("Path D → A : ")
        println(join(["($(p.x), $(p.y))" for p in chemin], "→"))
    end
end

function algoDijkstra(fname::String, D::Tuple{Int64,Int64}, A::Tuple{Int64,Int64})
    c = map_to_carte(fname, Position(D[1],D[2]), Position(A[1],A[2]))
     t = @elapsed chemin, cout, noeuds = dijkstra(c)
    if chemin === nothing
        println("Aucun chemin trouvé")
    else
        println("Distance D → A : ", cout)
        println("Nombre d'états explorés : ", noeuds)
        println("Temps de calcul : ", round(t, digits=6), " s")
        print("Path D → A : ")
        println(join(["($(p.x), $(p.y))" for p in chemin], "→"))
    end
end

function algoAstar(fname::String, D::Tuple{Int64,Int64}, A::Tuple{Int64,Int64})
    c = map_to_carte(fname, Position(D[1],D[2]), Position(A[1],A[2]))
     t = @elapsed chemin, cout, noeuds = Astar(c)
    if chemin === nothing
        println("Aucun chemin trouvé")
    else
        println("Distance D → A : ", cout)
        println("Nombre d'états explorés : ", noeuds)
        println("Temps de calcul : ", round(t, digits=6), " s")
        print("Path D → A : ")
        println(join(["($(p.x), $(p.y))" for p in chemin], "→"))
    end
end

function algoGlouton(fname::String, D::Tuple{Int64,Int64}, A::Tuple{Int64,Int64})
    c = map_to_carte(fname, Position(D[1],D[2]), Position(A[1],A[2]))
     t = @elapsed chemin, cout, noeuds = glouton(c)
    if chemin === nothing
        println("Aucun chemin trouvé")
    else
        println("Distance D → A : ", cout)
        println("Nombre d'états explorés : ", noeuds)
        println("Temps de calcul : ", round(t, digits=6), " s")
        print("Path D → A : ")
        println(join(["($(p.x), $(p.y))" for p in chemin], "→"))
    end
end
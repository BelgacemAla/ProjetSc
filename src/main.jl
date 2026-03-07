include("carte.jl")
include("BFS.jl")
include("Aetoile.jl")
include("dijkstra.jl")
include("lecture_map.jl")

function algoBFS(fname, D::Tuple{Int64,Int64}, A::Tuple{Int64,Int64})
    c = map_to_carte(fname, Position(D[1],D[2]), Position(A[1],A[2]))
    chemin, cout, noeuds = bfs(c)
    if chemin === nothing
        println("Aucun chemin trouvé")
    else
        println("Distance D → A : ", cout)
        println("Nombre d'états explorés : ", noeuds)
        print("Path D → A : ")
        println(join(["($(p.x), $(p.y))" for p in chemin], "→"))
    end
end

function algoDijkstra(fname::String, D::Tuple{Int64,Int64}, A::Tuple{Int64,Int64})
    c = map_to_carte(fname, Position(D[1],D[2]), Position(A[1],A[2]))
    chemin, cout, noeuds = dijkstra(c)
    if chemin === nothing
        println("Aucun chemin trouvé")
    else
        println("Distance D → A : ", cout)
        println("Nombre d'états explorés : ", noeuds)
        print("Path D → A : ")
        println(join(["($(p.x), $(p.y))" for p in chemin], "→"))
    end
end

function algoAstar(fname::String, D::Tuple{Int64,Int64}, A::Tuple{Int64,Int64})
    c = map_to_carte(fname, Position(D[1],D[2]), Position(A[1],A[2]))
    chemin, cout, noeuds = Astar(c)
    if chemin === nothing
        println("Aucun chemin trouvé")
    else
        println("Distance D → A : ", cout)
        println("Nombre d'états explorés : ", noeuds)
        print("Path D → A : ")
        println(join(["($(p.x), $(p.y))" for p in chemin], "→"))
    end
end

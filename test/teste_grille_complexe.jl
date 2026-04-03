# TESTE SUR UNE GRILLE COMPLEXE
include("../src/simulation.jl")

grille = [-1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1;
          -1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 -1;
          -1  0  0  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0  0  0 -1;
          -1  0  0  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0  0  0 -1;
          -1  0  0  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0  0  0 -1;
          -1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 -1;
          -1  0  0  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0  0  0 -1;
          -1  0  0  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0  0  0 -1;
          -1  0  0  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0  0  0 -1;
          -1  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0  0 -1;
          -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 -1  0 -1 -1 -1 
        ]

couts = ones(Float64, 11, 37)
carte_entrepot = Carte(grille, couts, 11, 37, Position(1, 1), Position(1, 1))


# MISSION 
println("\n TESTES SUR UNE GRILLE COMPLEXE")

# MENU INTERACTIF 
println("\n=== CHOISISSEZ VOTRE SCÉNARIO DE TEST ===")
println("1. Mission SANS conflit ")
println("2. Mission AVEC conflit ")
println("3. Ajout progressif / 5 agents")
print("Votre choix (1, 2 ou 3) : ")

choix = readline()

if choix == "1"
    println("--- Missions sans conflit ---")
    m = [ (Position(1, 9), Position(1, 24), 1) ]
    simulation(carte_entrepot, m)
elseif choix == "2"
    println("\n--- Missions avec conflit ---")
    m = [
        (Position(11, 19), Position(1, 19), 1), 
        (Position(1, 19), Position(11, 19), 3)
    ]
    simulation(carte_entrepot, m)
elseif choix == "3"
    println("\n--- Ajout progressif ---")
    m = [
        (Position(11, 19), Position(1, 19), 1), 
        (Position(1, 19), Position(11, 19), 9), 
        (Position(1, 9), Position(1, 24), 5),
        (Position(1, 4), Position(11, 29), 4),
        (Position(11, 4), Position(11, 14), 6)
    ]
    simulation(carte_entrepot, m)
else
    println("\n CHOIX INVALIDE")
    return
end
println("\nSimulation terminée : Évolution temporelle tracée")
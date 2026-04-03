include("exemple_presentation.jl")

# --- TEST 1 : INTERSECTION COMPLEXE ---
# Ce test vérifie la capacité des AMR à naviguer dans une grille avec obstacles
# et à gérer des missions croisées (AMR 1 et AMR 3 en sens inverse)
println("\n")
println(" TEST 1 : MISSIONS CROISÉES & OBSTACLES ")

grille_c = [ -1 -1 -1 -1 -1 -1 -1 -1;
              0  0  0  0  0  0  0  0;
             -1 -1  0  0  0  0  0  0]

carte_c = creation_carte(grille_c, Position(1,1), Position(1,1))

missions_c = [
    (Position(2,1), Position(2,8), 1), # AMR 1 : Traversée complète
    (Position(1,4), Position(3,4), 1), # AMR 2 : Traversée verticale
    (Position(2,8), Position(2,1), 1), # AMR 3 : Retour (conflit avec 1)
]

simulation(carte_c, missions_c)


# --- TEST 2 : CONFLIT FACE-À-FACE ---
# il doit forcer l'un des robots à attendre ou à trouver une zone de dégagement.
println("\n")
println(" TEST 2 : CONFLIT FACE-À-FACE ")

grille_corr = [
    -1 -1 -1 -1 -1 -1 -1 -1 -1 -1;
     0  0  0  0  0  0  0  0  0  0; # Unique voie de passage
    -1 -1 -1 -1 -1 -1 -1 -1 -1 -1
]

carte_corr = creation_carte(grille_corr, Position(2,1), Position(2,10))

missions_conflit = [
    (Position(2, 2), Position(2, 9), 1), # AMR 1 : Gauche vers Droite
    (Position(2, 8), Position(2, 3), 1)  # AMR 2 : Droite vers Gauche
]

simulation(carte_corr, missions_conflit)


# --- TEST 3 : ATTENTE TEMPORELLE ---
#  l'AMR 1 bloque une intersection 
# L'AMR 2 doit attendre
println("\n")
println(" TEST 3 : ATTENTE ")
grille_porte = [
    -1 -1 -1  0 -1 -1 -1;  # Mur avec porte étroite
     0  0  0  0  0  0  0;  # Couloir principal
    -1 -1 -1 -1 -1 -1 -1   
]

carte_porte = creation_carte(grille_porte, Position(2,1), Position(2,7))

missions_attente = [
    (Position(2, 4), Position(1, 4), 1), # AMR 1 : Se gare dans l'ouverture
    (Position(2, 1), Position(2, 7), 1)  # AMR 2 : Doit passer l'ouverture après AMR 1
]

simulation(carte_porte, missions_attente)
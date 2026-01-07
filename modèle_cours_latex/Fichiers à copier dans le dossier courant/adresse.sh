#!/bin/bash

read -p "Écrire le nom du cours : " nom

mkdir -p "$nom"

# On renvoie le chemin pour make
echo "$(pwd)/$nom"


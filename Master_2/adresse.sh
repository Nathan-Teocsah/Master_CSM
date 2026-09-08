#!/bin/bash

FILE=$PATH/Master_CSM/Master_2

read -p "Écrire le nom du cours : " nom

mkdir -p $FILE"/$nom"

# On renvoie le chemin pour make
echo $FILE"/$nom"


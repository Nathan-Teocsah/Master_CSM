#!/bin/bash
ADRESSE=$HOME/Master_CSM/modèle_cours_latex
ADRESSE_COURS=$HOME/Master_CSM/Master_2

read nom

mkdir -p $ADRESSE_COURS/$nom

cp $ADRESSE/cours.tex $ADRESSE_COURS/$nom


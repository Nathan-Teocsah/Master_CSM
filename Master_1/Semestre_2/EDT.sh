#!/bin/bash

FILE="/home/maenwe/Téléchargements/ADECal.ics"
MASTER1="/home/maenwe/Master_CSM/Master_1/Semestre_2"

# Vérification
if [ ! -f "$FILE" ]; then
    echo "Fichier introuvable"
    exit 1
fi

# Heure actuelle
NOW=$(date -u +"%Y%m%dT%H%M%SZ")

# Parser
valeur=$(awk -v now="$NOW" -v MASTER="$MASTER" '
BEGIN { in_event=0 }
/BEGIN:VEVENT/ { in_event=1 }
/END:VEVENT/ {
    if (start <= now && end >= now) {        
        print summary
        exit
    }
    in_event=0
}
in_event {
    if ($0 ~ /^DTSTART:/) { start=substr($0,9) }
    if ($0 ~ /^DTEND:/) { end=substr($0,7) }
    if ($0 ~ /^SUMMARY:/) { summary=substr($0,9) }
}
' "$FILE")

cd $Master1
echo $valeur
if [[ $valeur = *"ELFI"* ]]
then
   texstudio ELFI/cours.tex
elif [[ $valeur = *"MODA1"* ]]
then
 	texstudio MODA/Cours.tex
elif [[ $valeur = *"EDP"* ]]
then
   texstudio EDP/Cours.tex
elif [[ $valeur = *"APST"* ]]
then
	code --session
elif [[ -z "$valeur" ]] 
then
   echo "Aucun cours"
else
	echo "Aucun cours ne correspond dans les dossiers"
fi

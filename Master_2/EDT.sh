#!/bin/bash
wget -O adecal1.ics https://planning.univ-rennes.fr/jsp/custom/modules/plannings/83DMglYx.shu
if [ $? != 4 ]
then
	rm -rf adecal.ics
	mv adecal1.ics adecal.ics
else
	rm -rf adecal1.ics
fi
echo "-------------------------------------------------------------"

Master1="/home/maenwe/Master_CSM/Master_2"
FILE=$Master1/adecal.ics

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
if [[ $valeur = *"Prog Objet C++ bases CM"* ]]
then
   texstudio Prog_obj_C++/cours.tex
elif [[ $valeur = "Phénomènes de Propagation CM"* || $valeur = "Phénomènes de Propagation TD"* ]]
then
	if [ ! -d phenomene_propagation ]
	then
		echo "--- Création du cours ---"
		make
	fi
 	texstudio phenomene_propagation/cours.tex
elif [[ -z "$valeur" ]] 
then
   echo "Aucun cours"
else
	echo "Aucun cours ne correspond dans les dossiers"
fi

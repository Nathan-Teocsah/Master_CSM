#!/bin/bash
Master1="/home/maenwe/Master_CSM/Master_2"
FILE=$Master1/adecal.ics

cd $Master1
wget -O adecal1.ics https://planning.univ-rennes.fr/jsp/custom/modules/plannings/83DMglYx.shu 
if [ $? != 4 ]
then
	rm -rf adecal.ics
	mv adecal1.ics adecal.ics
else
	rm -rf adecal1.ics
fi
echo "-------------------------------------------------------------"

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
	name="Prog_obj_C++"
	if [ ! -d $name ]
	then
		echo $name|adresse.sh
	fi
   texstudio $name/cours.tex
elif [[ $valeur = "Phénomènes de Propagation CM"* || $valeur = "Phénomènes de Propagation TD"* ]]
then
	name=phenomene_propagation
	if [ ! -d $name ]
	then
		echo $name|adresse.sh
	fi
 	texstudio $name/cours.tex
elif [[ $valeur = "Machine learning for biology CM"* ]]
then
	name="machine_learning_for_biology"
	if [ ! -d $name ]
	then
		echo $name|adresse.sh
	fi
	fichier_recent=$(find $name -type f -name "*.pdf" -printf "%T@ %p\n" | sort -n | tail -n 1 | cut -d' ' -f2-)
 	firefox $fichier_recent
elif [[ $valeur = "Pratique Logiciels EF CM"* ]]
then
	name="pratique_logiciel_EF"
	if [ ! -d $name ]
	then
		echo $name|adresse.sh
	fi
	fichier_recent=$(find $name -type f -name "*.pdf" -printf "%T@ %p\n" | sort -n | tail -n 1 | cut -d' ' -f2-)
 	firefox $fichier_recent
elif [[ $valeur = "Programmation parallèle et sur GPU"* ]]
then
	name="programmation_parallèle"
	if [ ! -d $name ]
	then
		echo $name|adresse.sh
	fi
	fichier_recent=$(find $name -type f -name "*.pdf" -printf "%T@ %p\n" | sort -n | tail -n 1 | cut -d' ' -f2-)
 	firefox $fichier_recent
 	code $name/
elif [[ -z "$valeur" ]] 
then
   echo "Aucun cours"
else
	echo "Aucun cours ne correspond dans les dossiers"
fi

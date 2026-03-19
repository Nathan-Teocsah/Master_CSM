#!/bin/bash

FILE="/home/maenwe/Téléchargements/ADECal.ics"
MASTER=$(pwd)

# Vérification
if [ ! -f "$FILE" ]; then
    echo "Fichier introuvable"
    exit 1
fi

# Heure actuelle
NOW=$(date -u +"%Y%m%dT%H%M%SZ")
NOW=20260318T133013Z
# Parser
awk -v now="$NOW" -v MASTER="$MASTER" '
BEGIN { in_event=0 }
/BEGIN:VEVENT/ { in_event=1 }
/END:VEVENT/ {
    if (start <= now && end >= now) {
        if (summary ~ /^ELFI/) {
            system("texstudio \"" MASTER "/ELFI/cours.tex\" &")
            system("nautilus \"ELFI\" &")
        }
        else if (summary ~ /^MODA1/) {
            system("texstudio \"" MASTER "/Modelisation_en_action/Cours.tex\" &")
            system("nautilus \"Modelisation_en_action\" &")
        }
        else if (summary ~ /^EDP/) {
            system("texstudio \"" MASTER "/EDP/Cours.tex\" &")
			   system("nautilus \"EDP\" &")
        }
        else if (summary ~ /^APST/) {
            system("code --session")
        }
        
        print "Cours en cours :", summary
        exit
    }
    in_event=0
}
in_event {
    if ($0 ~ /^DTSTART:/) { start=substr($0,9) }
    if ($0 ~ /^DTEND:/) { end=substr($0,7) }
    if ($0 ~ /^SUMMARY:/) { summary=substr($0,9) }
}
' "$FILE"

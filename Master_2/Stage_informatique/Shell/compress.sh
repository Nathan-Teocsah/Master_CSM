nom_compress="$1.tar"
nom_fichier_exclusion="exclusion"
for nom_fichier in $(find $1 -type f)
do
	if [[ $nom_fichier = *$(pwd) ]]
	then
		echo $nom_fichier
		continue
	fi
	err=0
	while read -r ligne
	do
		if [[ $nom_fichier = *$ligne ]]
		then
			err=1
			break
		fi
	done < $nom_fichier_exclusion
	
	if [ $err = 0 ]
	then
		tar -rvf $nom_compress $nom_fichier
	fi
done

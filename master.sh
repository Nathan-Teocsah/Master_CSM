absolu=$(pwd)
read -p "Quelle année (1 = Master_1 et 2 = Master_2) ? " choice
cd $absolu"/Master_CSM/Master_"$choice
read -p "Quelle matière ? " choice
nautilus $(find . -name $choice)

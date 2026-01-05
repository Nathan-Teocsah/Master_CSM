if [ -e "resultat.txt" ]
then
	rm -f resultat.txt
fi
touch resultat.txt
rm -f a.out
gcc main.c initiate_A_b.c produit.c difference.c norme1.c -llapacke -llapack -lblas -lcblas -lm
if [ -e "a.out" ]
then
	a.out
fi

if [ -e "resultat_m.txt" ]
then
	rm -f resultat_m.txt
fi
touch resultat_m.txt
rm -f a.out
gcc monolithique.c -llapacke -llapack -lblas -lcblas -lm
if [ -e "a.out" ]
then
	a.out
fi

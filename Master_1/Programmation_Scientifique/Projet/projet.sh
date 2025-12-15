if [ -e "resultat.txt" ]
then
	rm -f resultat.txt
fi
touch resultat.txt
rm -f a.out
gcc main.c initiate_A_b.c produit.c difference.c -llapacke -llapack -lblas -lcblas -lm
if [ -e "a.out" ]
then
	a.out
fi

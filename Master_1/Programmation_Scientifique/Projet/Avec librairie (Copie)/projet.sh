if [ ! -f "fonction.o" ]
then
	if [ ! -e "libfonction.a" ]
	then
		gcc -c fonction.c
		ar crs libfonction.a fonction.o
	fi	
fi

if [ -e "libfonction.a" -a -f "fonction.o" ]
then
	if [ -e "resultat.txt" ]
	then
		rm -f resultat.txt
	fi
	touch resultat.txt
	rm -f a.out
	gcc main.c -L. -lfonction -llapacke -llapack -lblas -lcblas -lm
	if [ -e "a.out" ]
	then
		a.out
	fi
fi

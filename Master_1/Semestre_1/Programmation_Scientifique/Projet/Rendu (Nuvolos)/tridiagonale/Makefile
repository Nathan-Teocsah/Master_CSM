CC = gcc
CFLAGS = -L. -lfonction -llapacke -llapack -lblas -lcblas -lm

a.out : main.c libfonction.a
	$(CC) $(LDFLAGS) $(CPPFLAGS) main.c $(CFLAGS)

libfonction.a : fonction.o
	ar crs libfonction.a fonction.o
		
fonction.o : fonction.c
	$(CC) -c fonction.c

resultat_tri_simple.txt :
	touch resultat_tri_simple.txt

clean : resultat_tri_simple.txt libfonction.a fonction.o a.out
	rm -rf resultat_tri_simple.txt libfonction.a fonction.o a.out

run : a.out resultat_tri_simple.txt 
	a.out
	cat resultat_tri_simple.txt
		



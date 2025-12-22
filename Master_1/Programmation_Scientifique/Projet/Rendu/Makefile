CC = gcc
CFLAGS = -L. -lfonction -llapacke -llapack -lblas -lcblas -lm

a.out : main.c libfonction.a
	$(CC) $ main.c $(CFLAGS)

libfonction.a : fonction.o
	ar crs libfonction.a fonction.o
		
fonction.o : fonction.c
	$(CC) -c fonction.c

resultat.txt :
	touch resultat.txt

clean : libfonction.a fonction.o a.out
	rm -rf libfonction.a fonction.o a.out

run : a.out resultat.txt 
	a.out
	cat resultat.txt
		



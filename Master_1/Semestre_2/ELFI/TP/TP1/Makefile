CC = gcc

a.out :
	rm -f a.out
	$(CC) main.c Creer_maillage.c etiqAr.c

maillage.txt :
	touch maillage.txt

clean : maillage.txt a.out
	rm -rf maillage.txt a.out

run : maillage.txt
	a.out
	cat maillage.txt
	

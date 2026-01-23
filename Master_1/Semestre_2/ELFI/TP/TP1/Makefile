CC = gcc 

a.out : Creer_maillage.c etiqAr.c main.c
	$(CC) main.c Creer_maillage.c etiqAr.c

maillage.txt :
	touch maillage.txt

clean :
	rm -rf maillage.txt a.out

run : maillage.txt Creer_maillage.c etiqAr.c main.c a.out 
	a.out
	cat maillage.txt
	

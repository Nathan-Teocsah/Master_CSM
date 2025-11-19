#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include "header.h"

double nombre(FILE *f)
{
  int c;
  // un nombre décimale est décrit par un signe (+/-), une partie entiere et une partie décimale ou ne contient pas de partie
  do{
    c = fgetc(f);
    if (c==EOF){ //EOF = End Of File
      printf("Le fichier est vide\n");
      exit(EXIT_FAILURE);
    }
  }while ((c!='+')&&(c!='-')&&(c<='0')&&(c>='9')&&(c!='.')&&(c!=','));
  
  int taille_max = sizeof(double)-1;
  double x =0;
  
  char sgn = '+';
  if (c=='-'){
    sgn = '-'; // le signe du nombre
  }
  
  // Partie entière
  while((c>='0')&&(c<='9')){
    taille_max--;
    x = 10*x+c-'0';
    c = fgetc(f); 
  }
  
  while ((c=='.')||(c==',')){
    c = fgetc(f);
  }
  
  double exp = 0.1;
  while ((c>='0')&&(c<='9')){
    taille_max--;
    x = x+(c-'0')*exp;
    exp *= 0.1;
    c = fgetc(f);
  }
  
  if (taille_max<0){
    printf("Le nombre choisi est trop grand ou petit\n");
    exit(EXIT_FAILURE);
  }
  
  if (sgn=='+') return x;
  else return -x;
}


int dim(FILE *fp){
  return (int) nombre(fp);
}



void get_matrix(FILE *fp, Matrix *T,Matrix *b)
{ 
    int n = T->nrow;
    for (int i = 0; i <n;i++){
      for (int j = 0; j<4;j++){
        if (j<3) T->mat[i*3+j] = nombre(fp);
        else b->mat[i] = nombre(fp);
      }
    }    
}



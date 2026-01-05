#include <stdio.h>
#include <stdlib.h>
#include "header.h"

int main(){
printf("Algorithme de thomas resolvant le système TX = b où T est une matrice tribande\n\n");


//ouverture et lecture du fichier
//--------------------------------------------------------------------------
char NOM[] = "thomas.inp";
FILE *fp = fopen(NOM, "r");
if (fp == NULL)
    {
        fprintf(stderr, "Le fichier %s n'a pas pu être ouvert\n",NOM);
        return EXIT_FAILURE;
    }
    
int n = dim(fp);
Matrix T, b;

T.nrow = n;
b.nrow = n;

T.mat = malloc(n*3*sizeof(*T.mat));
b.mat = malloc(n*sizeof(*b.mat));

get_matrix(fp,&T,&b);
//----------------------------------------------------------------------------


if (T.nrow<3)
{
printf("\nIl faut choisir une taille de matrice au moins égal à 3, elle est égale à %d !\n\n",n);
exit(0);
}



printf("Vous avez donc définie T comme : \n\n");
for (int i = 0; i<n;i++)
{
  for (int j=0; j<n; j++)
  {
    if ((i!=0)&&(i!=n-1))
    {
      if ((j==i-1)||(j==i)||(j==i+1))
      {
        printf("%lf  ",T.mat[i*3+j-i+1]);
      }        
      else
      {
        printf("   0      ");
      }
    }
    else if (i==0)
    {
      if ((j==0)||(j==1))
      {
        printf("%lf  ",T.mat[i*3+j+1]);
      }        
      else
      {
        printf("   0      ");
      }
    }
    else
    {
      if ((j==n-2)||(j==n-1))
      {
        printf("%lf  ",T.mat[(n-1)*3+j-n+2]);
      }        
      else
      {
        printf("   0      ");
      }
    }
  }
  printf("\n");
}
printf("------------------------------------------------\n\n");

Matrix copie_b;copie_b.mat = malloc(n*sizeof(*copie_b.mat)); for (int i=0;i<n;i++) copie_b.mat[i]=b.mat[i];
Matrix copie_T;copie_T.mat = malloc(n*n*sizeof(*copie_T.mat)); 
for (int i=0;i<n;i++) {
  for (int i = 0; i<n;i++)
  {
    for (int j=0; j<n; j++)
    {
      if ((i!=0)&&(i!=n-1))
      {
        if ((j==i-1)||(j==i)||(j==i+1))
        {
          copie_T.mat[i*3+j] = T.mat[i*3+j-i+1];
        }        
        else
        {
          copie_T.mat[i*3+j] = 0;
        }
      }
      else if (i==0)
      {
        if ((j==0)||(j==1))
        {
          copie_T.mat[i*n+j] = T.mat[i*3+j+1];
        }        
        else
        {
          copie_T.mat[i*3+j]=0;
        }
      }
      else
      {
        if ((j==n-2)||(j==n-1))
        {
          copie_T.mat[i*n+j]=T.mat[(n-1)*3+j-n+2];
        }        
        else
        {
          copie_T.mat[i*3+j] = 0;
        }
      }
    }
  }
}

copie_T.nrow = n; copie_b.nrow = n;
thomas(&T,&b);

Matrix x; 
x.nrow = n;
x.mat = malloc(n*sizeof(*x.mat));
x.mat[n-1] = b.mat[n-1]/T.mat[3*(n-1)+1];
for (int i = n-2;i>-1;i--)
{
  x.mat[i] = (b.mat[i]-T.mat[3*i+2]*x.mat[i+1])/T.mat[i*3+1];
}

printf("\n----------");
printf("\nx = ");
mat_print(x);
printf("----------\n");

printf("\nVérification Tx = b : ");
matmul(&copie_T,&x); //Le résultat de la multiplication se trouve dans x.


printf("Tx        b\n");
for (int i=0; i<n; i++)
{
  printf("%lf %lf\n",x.mat[i],copie_b.mat[i]);
}

if (fclose(fp) == EOF)
    {
        printf("Erreur lors de la fermeture du flux\n");
        return EXIT_FAILURE;        
    }
free(T.mat);
free(b.mat);
free(x.mat);
free(copie_T.mat);
free(copie_b.mat);


}

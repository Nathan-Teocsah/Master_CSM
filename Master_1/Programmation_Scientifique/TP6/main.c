#include <stdio.h>
#include <stdlib.h>
#include "header.h"

int main(){
printf("Algorithme de thomas resolvant le système TX = b où T est une matrice tribande\n\n");

printf("Taille de la matrice (supérieur à 3) : ");
Matrix T;
scanf("%d",&T.nrow);
if (T.nrow<3)
{
printf("\nIl faut choisir une taille de matrice au moins égal à 3 !\n\n");
exit(0);
}
int n = T.nrow;
T.mat = malloc(n*3*sizeof(*T.mat));


printf("\n\n--------------------------------------------");
printf("\nT est de la forme : \n\n");
for (int i = 0; i<n;i++)
{
  for (int j=0; j<n; j++)
  {
    if ((i!=0)&&(i!=n-1))
    {
      if ((j==i-1)||(j==i)||(j==i+1))
      {
        printf("a[%d,%d]  ",i,j);
      }        
      else
      {
        printf("   0    ");
      }
    }
    else if (i==0)
    {
      if ((j==0)||(j==1))
      {
        printf("a[%d,%d]  ",i,j);
      }        
      else
      {
        printf("   0    ");
      }
    }
    else
    {
      if ((j==n-2)||(j==n-1))
      {
        printf("a[%d,%d]  ",i,j);
      }        
      else
      {
        printf("   0    ");
      }
    }
  }
  printf("\n");
}
printf("--------------------------------------------\n\n");

printf("\n Rentrer les valeurs de T.\n");
printf("a[%d][%d] = ",0,0);
scanf("%lf",T.mat+1);
printf("a[%d][%d] = ",0,1);
scanf("%lf",T.mat+2);

for (int i = 1;i<n-1;i++)
{
  for (int j = 0; j<3;j++)
  {
    printf("a[%d][%d] = ",i,j+i-1);
    scanf("%lf",T.mat+i*3+j);
  }
}

printf("a[%d][%d] = ",n-1,n-2);
scanf("%lf",T.mat + (n-1)*3);
printf("a[%d][%d] = ",n-1,n-1);
scanf("%lf",T.mat + (n-1)*3 + 1);

printf("\n\n------------------------------------------------\n");
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

printf("\nRentrer b :\n");
Matrix b;
b.nrow = n;
b.mat = malloc(n*sizeof(*b.mat));
for (int i = 0; i<n;i++)
{
  printf("b[%d] = ",i);
  scanf("%lf",b.mat+i);
}

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
free(T.mat);
free(b.mat);
free(x.mat);
free(copie_T.mat);
free(copie_b.mat);


}

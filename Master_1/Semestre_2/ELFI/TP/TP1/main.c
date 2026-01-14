#include <stdio.h>
#include <stdlib.h>
#include "header.h"

int main(){
FILE *fp = fopen("maillage.txt", "w");
Creer_maillage(0, 4, 0, 4, 5, 5, 1, fp);
}

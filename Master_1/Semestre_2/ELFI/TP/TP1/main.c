#include <stdio.h>
#include <stdlib.h>
#include "header.h"

int main(){
FILE *fp = fopen("maillage.txt", "w");
Creer_maillage(0, 1, 0, 1, 5, 5, 2, fp);
}

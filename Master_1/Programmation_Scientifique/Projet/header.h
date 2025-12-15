typedef struct{
  int nrow;
  int ncol;
  double** mat;
  double* p; // Matrice A stockée sous-forme d'un vecteur ligne
} Matrix;

typedef struct{
  int nrow;
  int ncol;
  float** mat;
  float* p; // Matrice A stockée sous-forme d'un vecteur ligne
} Matrix_double;

void initiate_A_b(Matrix *, Matrix *, Matrix *, Matrix_double *, Matrix_double *,  double);

void produit(Matrix*, Matrix*, Matrix_double*);

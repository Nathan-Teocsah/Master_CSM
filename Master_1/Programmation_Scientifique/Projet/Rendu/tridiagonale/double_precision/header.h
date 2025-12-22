typedef struct{
  int nrow;
  int ncol;
  float** mat;
  float* p; // Matrice A stockée sous-forme d'un vecteur ligne
} Matrix;

typedef struct{
  int nrow;
  int ncol;
  double** mat;
  double* p; // Matrice A stockée sous-forme d'un vecteur ligne
} Matrix_double;

void initiate_A_b(Matrix_double *, Matrix_double *, Matrix_double *, Matrix_double *, Matrix_double *, Matrix_double *, Matrix_double *,  double);

void produit(Matrix_double, Matrix_double, Matrix_double*);

void difference(Matrix_double* ,Matrix_double);

double norme1(Matrix_double);

void fonction(void);

typedef struct
{
  int nrow;
  double* mat;
} Matrix;

void thomas(Matrix *,Matrix *);

void mat_print(Matrix);

void matmul(Matrix*,Matrix*);

void get_matrix(FILE *,Matrix*,Matrix*);

int dim(FILE *);

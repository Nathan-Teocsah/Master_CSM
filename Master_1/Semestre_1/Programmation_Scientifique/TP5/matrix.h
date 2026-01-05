// Structure of a 2D - matrix as a vector for efficiency

typedef struct
{
  int nrow ;
  int ncol ;
  double * mat ;
} Matrix ;

void mat_create ( Matrix * , int , int ) ;
void mat_free ( Matrix ) ;
void mat_init ( Matrix *) ;
void mat_print ( Matrix ) ;
void matsum ( Matrix , Matrix , Matrix *) ;

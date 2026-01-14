void Creer_maillage(double a, double b, double c, double d, int n1, int n2, int t, FILE *fp)
//====================== Cette ALGORITHME Créer un maillage sur un quadrangle ==============================
// Omega = [a;b] x [c; d] avec a < b  et c < d


  int n = n1 * n2; // n = est le nombre de noeuds
  ecrire dans le fichier : "n"
  ecrire dans le fchier : n
  
  double h1 = (b-a)/(n1-1); // 
  double h2 = (d-c)/(n2-1);
  
  ecrire dans le fichier : "Coordonnée des noeuds \n"
  for (int i_y = 0; i_y < n1; i_y++) // Boucle sur les lignes (ordonnée)
  {
    for (int i_x = 0; i_x< n2, i_x++) // Boucle sur les colonnes (abscisse)
    {
      ecrire dans le fichier : "(a + h1 * i_x, b + h2 * i_y) \n"
    }
  }
  
  m = (n1 - 1)*(n2 - 1); // Nombre d'éléments (triangle ou quadrangle)
  switch t {
	  case 1 : // t = 1 : quadrangle
	    p = 4; // p = 4 (nombre de noeuds par éléments)
	    ecrire dans fichier : m, t, p 
	    for (int i = 0; i < (n1-2); i++) // boucle sur les lignes
	    {
	      for (int j = 0; j< (n2-2); p++) // boucle sur les colonnes
	      {
	        int e0 = 2 + n1 * i + j ; //On récupère le numéro global du 1er sommet de l'élément (i+1)*(j+1)
	        ecrire dans le fichier : e0, e0 + n1, e0 + n1 - 1, e0 - 1   
	      }
	    }
	    
	  case 2 : // t = 2: triangle
	    m = 2*m;
	    p = 3; // p = 3
	    excrire dans le fichier : m, t, p
	    for (int i = 0; i < (n1-2); i ++) // boucle sur les lignes
	    {
	      for (int j = 0; j< (n2-2); p++) // boucle sur les colonnes
	      {
	        int e0 = 2 + n1 * i + j ; //On récupère le numéro global du 1er sommet du triangle du bas
	        ecrire dans le fichier : e0, e0 + n1, e0- 1 // Triangle du bas
	        ecrire dans le fichier : e0 + n1 - 1, e0, e0 + n1 // Triangle du haut
	      }
	    }
  }

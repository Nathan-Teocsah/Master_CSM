function y = fixe(f,t,h,y0,tol,nitmax)
  %% Methode du point fixe pour trouver le point fixe pour la méthode implicite

  ti = t + h/2 ;
  yn = y0 ;
  y = yn + h*f(ti,(yn+y0)/2)' ;
  nit=1 ;

  while norm(y-yn,inf)>tol ;
    yn = y ;
    y = y0 + h*f(ti,(y0+yn)/2)' ;
    nit = nit+1 ;

    if (nit > nitmax)
      disp("Nombre maximal d iterations atteint") ;
      return ;
    end
  end

function [x,nit,vecte]=IterJac(A,b,x0,epsil,nitmax)

  D = diag(diag(A));
  L = tril(A,-1);
  U = triu(A,1);

  x = x0;
  vecte = zeros(nitmax,1);
  nit = 0;

  for k = 1:nitmax
      xnew = D \ (b - (L+U)*x);

      r = b - A*xnew;
      vecte(k) = norm(r,2);

      nit = k;
      if vecte(k) < epsil
          vecte = vecte(1:k);
          x = xnew;
          return
      end

      x = xnew;
  end

  vecte = vecte(1:nit);


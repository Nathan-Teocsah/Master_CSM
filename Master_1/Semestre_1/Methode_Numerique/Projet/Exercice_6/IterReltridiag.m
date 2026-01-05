function [x,nit,vecte] = IterReltridiag(d,l,u,b,omega,x0,epsil,nitmax)

  n = length(d);
  x = x0;
  vecte = zeros(nitmax,1);
  nit = 0;

  for k = 1:nitmax
      xold = x;

      % première composante
      x(1) = (1-omega)*xold(1) + omega/d(1)*(b(1) - u(1)*xold(2));

      % composantes internes
      for i = 2:n-1
          x(i) = (1-omega)*xold(i) ...
               + omega/d(i)*(b(i) - l(i-1)*x(i-1) - u(i)*xold(i+1));
      end

      % dernière composante
      x(n) = (1-omega)*xold(n) + omega/d(n)*(b(n) - l(n-1)*x(n-1));

      % résidu
      r = zeros(n,1);
      r(1) = d(1)*x(1) + u(1)*x(2) - b(1);
      for i = 2:n-1
          r(i) = l(i-1)*x(i-1) + d(i)*x(i) + u(i)*x(i+1) - b(i);
      end
      r(n) = l(n-1)*x(n-1) + d(n)*x(n) - b(n);

      vecte(k) = norm(r,2);
      nit = k;

      if vecte(k) < epsil
          vecte = vecte(1:k);
          return
      end
  end

  vecte = vecte(1:nit);


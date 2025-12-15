function [Ir] = rectgf(a,b,n,f)
% Calcul de l'integrale de a jusqu'a b de la fonction de pointeur f
% par la methode des rectangles a gauche avec une subdivision
% de (b-a)/n: x0, x1, ..., xn.
%            ((b-a)/n) * somme(i=0,n-1) f(xi)
%
pas=(b-a)/n; s=0; xi=a;
for i=0:n-1
   s=s+f(xi);
   xi=xi+pas;
end
s=s*pas;
Ir=s;

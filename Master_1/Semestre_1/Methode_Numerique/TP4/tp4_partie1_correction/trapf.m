function [Ir] = trapf(a,b,n,f)
% Calcul de l'integrale de a jusqu'a b de la fonction de pointeur f
% par la methode des trapezes avec une subdivision
% de pas (b-a)/n: x0, x1, ..., xn.
%         ((b-a)/n) * [(f(a)+f(b))/2 + somme(i=1,n-1) f(xi)]
%
pas=(b-a)/n;
Ir = pas*sum([f(a)/2,f(a+[1:n-1]*pas),f(b)/2]);
%
% Ou en developpant l'algorithme (execution plus longue) :
%
%pas=(b-a)/n; xi=a+pas;
%s=(f(a)+f(b))/2;
%for i=1:n-1
%   s=s+f(xi);
%   xi=xi+pas;
%end
%s=s*pas;
%Ir=s;

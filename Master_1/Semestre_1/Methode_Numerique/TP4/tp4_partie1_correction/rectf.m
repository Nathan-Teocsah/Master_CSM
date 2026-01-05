function [Ir] = rectf(a,b,n,f)
% Calcul de l'integrale de a jusqu'a b de la fonction de pointeur f
% par la methode des rectangles a droite avec une subdivision
% de (b-a)/n: x0, x1, ..., xn.
%            ((b-a)/n) * somme(i=1,n) f(xi)
%
pas=(b-a)/n;
Ir = pas*sum(f(a+[1:n]*pas));
%
% Ou en developpant l'algorithme (execution plus longue) :
%
%pas=(b-a)/n; s=0; xi=a+pas;
%for i=1:n
%   s=s+f(xi);
%   xi=xi+pas;
%end
%s=s*pas;
%Ir=s;

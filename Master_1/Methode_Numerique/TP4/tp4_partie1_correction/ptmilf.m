function [Ir] = ptmilf(a,b,n,f)
% Calcul de l'integrale de a jusqu'a b de la fonction de pointeur f
% par la methode du point milieu (variante de la methode
% des rectangles ou on choisit l'evaluation de la fonction
% au point milieu de l'intervalle) avec une subdivision
% de pas (b-a)/n: x0, x1, ..., xn.
%         ((b-a)/n) * somme(i=0,n-1) f((x_{i} + x_{i+1})/2)
%
pas=(b-a)/n;
Ir = pas*sum(f(a+[0.5:n-0.5]*pas));
%
% Ou en developpant l'algorithme (execution plus longue) :
%
%pas=(b-a)/n; xi=a+pas/2; s=0;
%for i=0:n-1
%   s=s+f(xi);
%   xi=xi+pas;
%end
%s=s*pas;
%Ir=s;

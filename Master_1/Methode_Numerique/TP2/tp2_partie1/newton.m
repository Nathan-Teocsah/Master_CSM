function [r,nit]=newton(f,fp,x0,epsilon,Nmax)
%
% [r,nit]=newton(f,fp,x0,epsilon,Nmax)
%
%  Methode de Newton pour la recherche de racine dans R.
%  f:       fonction
%  fp:      fonction derivee de f
%  x0:      valeur d'initialisation
%  epsilon: precision demandee |f(r)| <= epsilon
%  Nmax:    nombre maximal d'iterations
%  r:       valeur calculee de la racine (quand l'algorithme converge)
%  nit:     nombre d'iterations
%
r = x0;
fx = f(r);
nit = 0;
while (abs(fx) > epsilon) & (nit < Nmax)
   nit = nit + 1;
   fprimx = fp(r);
   r = r - fx / fprimx;
   fx = f(r);
end

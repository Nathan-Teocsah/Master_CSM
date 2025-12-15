function [xk]=iter(g,x0,N)
% 
%  Methode d'iteration pour recherche de point fixe
%  g: fonction
%  x0: valeur initiale
%  N: nombre d'iteres a calculer
%  xk: N iteres de la fonction g a partir de x0
% 
xk=[x0];
for i=1:N
  x0 = g(x0);
  xk = [xk x0];
end


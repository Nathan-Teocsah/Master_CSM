function [p,n]=lagrangem(f,x,k)
  % Interpolation de Lagrange par morceaux
  % de degre k avec des points equidistants
  % sur chaque sous-intervalle [x {i}, x {i+1}]
  % pour la fonction f.
  % p est une matrice dont la ligne i donne les k+1 coefficients
  % du polynome d’interpolation sur [x {i}, x {i+1}]
  n=length(x)-1 ;
  for i=1 :n
    xint=linspace(x(i),x(i+1),k+1) ;
    p(i, :)=polyfit(xint,f(xint),k) ;
  end
end

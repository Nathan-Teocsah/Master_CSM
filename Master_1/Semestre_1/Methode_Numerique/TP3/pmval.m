function [y,xe]=pmval(p,x,nbpi)
  % Evaluation d’une fonction
  % polynomiale par morceaux sur les [x(i),x(i+1)].
  % On suppose que x0 < x1 < ... < xn
  % La ligne i de p contient les coefficients du polynome
  % correspondant a l’intervalle [x(i),x(i+1)].
  % Sur [x(i),x(i+1)] on evalue p en nbpi+2 points equidistants.
  % y : vecteur des valeurs du polynome aux pts d’evaluation xe.
  n=length(x)-1 ;xe=[] ;y=[] ;
  for i=1 :n
    ptsi=linspace(x(i),x(i+1),nbpi+2) ;ptsi=ptsi(1 :nbpi+1) ;
    xe=[xe ptsi] ;y=[y polyval(p(i, :),ptsi)] ;
  end
  xe=[xe, x(n+1)] ; y=[y polyval(p(n, :),x(n+1))] ;
end

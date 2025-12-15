function [Nx,y] = lagrangeEval(nbP,x,p)
  %% nbP = Nb de points en lesquels on découpe chaque
  %% sous-intervalle [xi, xi+1]

  n = length(x);
  Nx = []; y = [];
  for i=1:(n-1)
    pInter=linspace(x(i),x(i+1),nbP+1) ;
    pInter=pInter(1 :nbP) ; %% Pour éviter le chevauchement
    Nx=[Nx pInter] ;
    y=[y polyval(p(i, :),pInter)] ;
  end
  Nx=[Nx, x(n)] ; y=[y polyval(p(n-1, :),x(n))] ;

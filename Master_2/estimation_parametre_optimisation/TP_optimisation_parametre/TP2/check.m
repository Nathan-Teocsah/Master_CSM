clear, close all
VectGMC=[]; VectGMO = []; VectCGM = []; Vectcond = [];
Tol=1e-6; itmax=100000; rho = 0.001;
for n=10:5:30
  n
  [A,b] = construct(n);
  x0 = zeros(n,1); c=cond(A); Vectcond=[Vectcond;c];
  [x,err,it,Vecteur,temps] = CGM(A,b,x0,Tol,itmax);
  VectCGM = [VectCGM, it];
  [x,err,it,Vecteur,temps] = GMO(A,b,x0,Tol,itmax);
  VectGMO = [VectGMO, it];
  [x,err,it,Vecteur,temps] = GMC(A,b,x0,rho,Tol,itmax);
  VectGMC = [VectGMC, it];
end
figure
plot(Vectcond)
figure
plot(VectCGM)
figure
plot(VectGMO)
figure
plot(VectGMC)

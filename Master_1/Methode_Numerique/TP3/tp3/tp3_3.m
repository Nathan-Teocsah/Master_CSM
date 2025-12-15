% TP3 - 3 - Interpolation de Lagrange par morceaux d'ordre 1 et 2
% de f(x) = 1/(1+x^2) sur [-5,5] pour des points equidistants.
%
tn=[2,4,8,16,32,64,128]; nbn=length(tn); c=['g' 'k' 'm' 'c' 'r' 'b' 'w' 'y'];
nbpi=100; % pour tracer le graphique et faire le calcul de norme
xg=linspace(-5,5,1000);err=[];
figure(1);plot(xg,f(xg));hold on;
disp('  n            ||f-p||');
disp('         k=1           k=2');
for j=1:nbn
    n=tn(j);x=-5+10*[0:n]/n;
    k=1;
    p=lagrangem(@f,x,k);[yp,xe]=pmval(p,x,nbpi);
    plot(xe,yp,c(j));
    yf=f(xe);err(k,j)=norm(yf-yp,inf);
    k=2;
    p=lagrangem(@f,x,k);[yp,xe]=pmval(p,x,nbpi);
    yf=f(xe);err(k,j)=norm(yf-yp,inf);
    disp(sprintf('%3d  %.7e  %.7e',n,err(1,j),err(2,j)));
end
hold off
% ordre de convergence
coeff=polyfit(log10(10./tn(nbn-1:nbn)),log10(err(1,nbn-1:nbn)),1);ord(1)=coeff(1);
coeff=polyfit(log10(10./tn(nbn-1:nbn)),log10(err(2,nbn-1:nbn)),1);ord(2)=coeff(1);
disp(sprintf('Convergence :\n         %g      %g',ord(1),ord(2)));
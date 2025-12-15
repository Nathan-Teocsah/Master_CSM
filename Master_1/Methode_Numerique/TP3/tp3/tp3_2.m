% TP3 - 2 - Phenomene de Runge pour l'interpolation de Lagrange
% de f(x) = 1/(1+x^2) sur [-5,5] pour les points de Chebishev.
%
tn=[2,4,10,12]; nbn=length(tn); c=['y' 'm' 'c' 'r' 'g' 'b' 'w' 'k'];
xg=linspace(-5,5,10000); % pour tracer le graphique et faire le calcul de norme
yf=f(xg);
figure(1);plot(xg,yf);hold on;
disp('  n    ||f-p||');
for j=1:nbn
    n=tn(j);x=5*cos((2*[0:n]+1)*pi/(2*n+2));y=f(x);
    p=polyfit(x,y,n);yp=polyval(p,xg);
    plot(xg,yp,c(j));
    disp(sprintf('%3d  %.7e',n,norm(yf-yp,inf)));
end
hold off
tn=[20,40,60,80]; nbn=length(tn);
for n=tn
    x=5*cos((2*[0:n]+1)*pi/(2*n+2));y=f(x);
    p=polyfit(x,y,n);yp=polyval(p,xg);
    disp(sprintf('%3d  %.7e',n,norm(yf-yp,inf)));
end

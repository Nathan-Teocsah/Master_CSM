tn=[20 40 60 80]; nbn=length(tn);
c=['y' 'm' 'c' 'r' 'g' 'b' 'w' 'k']; %couleur des courbes
xg=linspace(-3.7,3.7,10000); yf=f(xg);
plot(xg,yf); hold on;
disp(' ');
disp(' n  |  ||f-p||');
disp('----------------------');
for j=1:nbn
  n=tn(j); x=5*cos((2*[0 :n]+1)*pi/(2*n+2)); y = f(x);
  p=polyfit(x,y,n); yp=polyval(p,xg);
  plot(xg,yp,c(j));
  disp(sprintf('%3d |  %.7e',n,norm(yf-yp,inf)));
end
legend('f','20','40','60','80');
hold off

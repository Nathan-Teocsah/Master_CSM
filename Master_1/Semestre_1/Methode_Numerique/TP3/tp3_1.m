tn=[2,4,10,12]; nbn=length(tn);
c=['y' 'm' 'c' 'r' 'g' 'b' 'w' 'k']; %couleur des courbes
xg=linspace(-5,5,10000); yf=f(xg);
plot(xg,yf); hold on;
disp(' ');
disp(' n  |  ||f-p||');
disp('----------------------');
for j=1:nbn
  n=tn(j); x=-5+10*[0:n]/n; y = f(x);
  p=polyfit(x,y,n); yp=polyval(p,xg);
  plot(xg,yp,c(j));
  disp(sprintf('%3d |  %.7e',n,norm(yf-yp,inf)));
end
legend('f','2','4','10','12');
hold off

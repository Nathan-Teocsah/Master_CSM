clear all; close all;
graphics_toolkit('gnuplot')
global a b p q
a = 3; b = 2; p = 2.5; q = 2;

t0 = 0; tf = 16;
N0 = 1.5; P0 = 3.5;
y0 = [N0,P0];
n = [10000 2000 500 350 300];

for i=1:1:5;
  figure(i);
  hold on;
  [tt,y] = meuler(t0,tf,n(i),y0,@flv);
  N = y(:,1);
  P = y(:,2);
  gnuplot(tt,N,'-db');
  gnuplot(tt,P,'-or');
  title(['Courbe pour n = ',num2str(n(i))]);
  legend('N','P');
  hold off;
end


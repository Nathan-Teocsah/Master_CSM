clear, close all;
%% QUESTION 2
global a b p q;
a=3;b=2;p=2.5;q=2;

tol = 1e-10;
nitmax = 100;
t0 = 0;
tf = 16;
n = 2000;

N0 = 1.5;
P0 = 2:1:5;

figure(1)
hold on
for p0=P0
  y0 = [N0;p0];
  [tt,y] = metimp(t0,tf,n,y0,@f,tol,nitmax);
  plot(y(:,1),y(:,2));
  [np,m]=size(y);
  plot(N0,P0,'or',y(np,1),y(np,2),'og')
  text(N0+.1,p0,['P0=',num2str(p0)]);
end
hold off;
title('Portrait de phase')
xlabel('nombre de proies N')
ylabel('nombre de predateurs P')

%% QUESTION 3

prec = 1e-2;
disp(["N0 = ",num2str(N0)]);
for p0=P0
  y0 = [N0;p0];
  [tt,y] = metimp(t0,tf,n,y0,@f,tol,nitmax);
  T = periode(y(:,1),tt,prec);
  disp(["Période pour N0 : ",num2str(T)]);
  T = periode(y(:,2),tt,prec);
  disp(["Période pour P0 = ",num2str(p0)," : ",num2str(T)]);
  disp(" ");
end



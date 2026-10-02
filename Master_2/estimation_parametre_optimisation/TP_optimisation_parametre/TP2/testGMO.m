n = floor(100*rand(1))+1;

b = 100*(rand(n,1)-0.5);
A = 20*(rand(n,n)-0.5);
A = A'*A+0.1*eye(n,n);
itmax = 10000;
x0 = zeros(n,1);
Tol = 1.e-4;
[x,err,it,Vecteur,temps] = GMO(A,b,x0,Tol,itmax);


figure
plot(0:length(Vecteur)-1, Vecteur)
grid on

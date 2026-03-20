f = @(x) sin(pi*x);
u = @(x) 1/pi^2 * sin(pi*x);

N = 25;
h = 1/N;

A = zeros(N-1,N-1);
F = zeros(N-1,1);

F(1) = f(0);
A(1,[1,2])=[2,-1];
for i = 2:N-2
    A(i,[i-1,i,i+1])=[-1,2,-1];
    F(i) = f(i*h);
end
A(N-1,[N-2,N-1])=[-1,2];
F(N-1) = f((N-1)*h);
A = 1/h^2 *A;

t=cputime;
U1=A\F;
disp(['Temps CPU méthode de Matlab pour un stockage plein : ',num2str(cputime-t)]);
t=cputime;
U2=sparse(A)\F;
disp(['Temps CPU méthode de Matlab pour un stockage sparse : ',num2str(cputime-t)]);
t=cputime;
U3=choltrd(A,F);
disp(['Temps CPU méthode de Choleski pour matrice tridiagonale pleine : ',num2str(cputime-t)]);
t=cputime;
U4=choltrd(sparse(A),F);
disp(['Temps CPU méthode de Choleski pour matrice tridiagonale sparse : ',num2str(cputime-t)]);
clear,close all;


%% QUESTION 2

A = [5 -2 1 ; -2 8 -1 ; 1 -1 9];
b = [-8 ; 17 ; 6];
x0 = [10 ; 10 ; 10];

omega = 1.0;
epsil = 1e-6;
nitmax = 100;

[x,nit,vecte] = IterRel(A,b,omega,x0,epsil,nitmax);

disp('Solution approchée :')
disp(x)
disp(['Nombre d''itérations : ',num2str(nit)])

figure
semilogy(vecte,'o-')
xlabel('Itération')
ylabel('||r_k||_2')
title('Convergence de Gauss-Seidel')
grid on





%% QUESTION 3

D = diag(diag(A));
L = tril(A,-1);
U = triu(A,1);

Lomega = (D + omega*L) \ ((omega-1)*D + omega*U);

rho = max(abs(eig(Lomega)));
disp(['log10(rho(Lomega)) = ', num2str(log10(rho))])









%% QUESTION 4


n = 10;
A = 2*eye(n) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);

b = zeros(n,1);
b(1) = 1; b(n) = 1;

x0 = zeros(n,1);
epsil = 1e-6;
nitmax = 200;

omega_vals = 0.1:0.1:1.9;
rho_vals = zeros(length(omega_vals),1);

D = diag(diag(A));
L = tril(A,-1);
U = triu(A,1);

for k = 1:length(omega_vals)
    omega = omega_vals(k);
    Lomega = (D + omega*L) \ ((omega-1)*D + omega*U);
    rho_vals(k) = max(abs(eig(Lomega)));
end

figure
plot(omega_vals,rho_vals,'o-')
xlabel('\omega')
ylabel('\rho(L_\omega)')
title('Rayon spectral de la matrice d''itération')
grid on





%% QUESTION 5

nvals = [16 32 64 128 256 512];
epsil = 1e-6;
nitmax = 2000;

tJac = zeros(length(nvals),1);
tGS  = zeros(length(nvals),1);
tSOR = zeros(length(nvals),1);

for k = 1:length(nvals)
    n = nvals(k);
    A = 2*eye(n) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);
    b = zeros(n,1); b(1)=1; b(n)=1;
    x0 = zeros(n,1);

    % Jacobi
    tic
    IterJac(A,b,x0,epsil,nitmax);
    tJac(k) = toc;

    % Gauss-Seidel
    tic
    IterRel(A,b,1,x0,epsil,nitmax);
    tGS(k) = toc;

    % Relaxation optimale
    omega_opt = 2/(1+sin(pi/(n+1)));
    tic
    IterRel(A,b,omega_opt,x0,epsil,nitmax);
    tSOR(k) = toc;
end

figure
plot(log10(nvals),log10(tJac),'o-', ...
     log10(nvals),log10(tGS),'s-', ...
     log10(nvals),log10(tSOR),'d-')
xlabel('log_{10}(n)')
ylabel('log_{10}(temps)')
legend('Jacobi','Gauss-Seidel','Relaxation','Location','NorthWest')
grid on



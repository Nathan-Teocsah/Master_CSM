clear, close all;

nvals = [16 32 64 128 256 512];
epsil = 1e-6;
nitmax = 2000;

tRel = zeros(length(nvals),1);
tTri = zeros(length(nvals),1);

for k = 1:length(nvals)
    n = nvals(k);

    % données
    d = 2*ones(n,1);
    l = -ones(n-1,1);
    u = -ones(n-1,1);

    A = 2*eye(n) - diag(ones(n-1,1),1) - diag(ones(n-1,1),-1);

    b = zeros(n,1);
    b(1) = 1; b(n) = 1;
    x0 = zeros(n,1);

    omega = 2/(1+sin(pi/(n+1)));

    % Relaxation matrice pleine
    tic
    IterRel(A,b,omega,x0,epsil,nitmax);
    tRel(k) = toc;

    % Relaxation tridiagonale
    tic
    IterReltridiag(d,l,u,b,omega,x0,epsil,nitmax);
    tTri(k) = toc;
end

figure
plot(log10(nvals),log10(tRel),'o-', ...
     log10(nvals),log10(tTri),'s-')
xlabel('log_{10}(n)')
ylabel('log_{10}(temps)')
legend('IterRel','IterReltridiag','Location','NorthWest')
grid on


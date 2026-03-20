function x = choltrd(A,F)
% résout le système linéaire A x = F par la méthode de choleski L D L^t pour une
% matrice A tridiagonale symmétrique définie positive.
n = size(A,1);
D = zeros(1,n);
L = zeros(1,n);
V = zeros(1,n);
x = zeros(1,n);

D(1) = A(1,1);
V(1) = F(1);
for i = 1:n-2
    L(i+1) = A(i+1,i+2)/D(i+1);

    V(i+1) = F(i+1) - L(i+1)*V(i);

    D(i) = A(i,i) - L(i)^2*D(i-1);

    x(i) = V(i)/D(i);
    x(i)
end
V = L\F;
x = D\V;
x = L'\x;
end
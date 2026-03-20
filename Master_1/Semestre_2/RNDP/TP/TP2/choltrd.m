function x = choltrd(A,F)
% résout le système linéaire A x = F par la méthode de choleski L D L^t pour une
% matrice A tridiagonale symmétrique définie positive.
n = size(A,1);
D = zeros(1,n);
L = zeros(1,n-1);
V = zeros(1,n);
x = zeros(1,n);

D(1) = A(1,1);
if (D(1) == 0)
    disp("A non inversible");
end

V(1) = F(1);
for i = 1:n-1
    L(i) = A(i,i+1)/D(i);
    D(i+1) = A(i+1,i+1) - L(i)^2*D(i);
    if D(i+1)==0
        disp("A non inversible");
    end

    V(i+1) = F(i+1) - L(i)*V(i);
end

x(n) = V(n)/D(n);
for i = 1:n-1    
    J = n-i;
    x(J) = V(J)/D(J);
    x(J) = x(J) - x(J+1)*L(J);
end
end
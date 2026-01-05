%[l,d,u]=DecompLUtridiag(A)
% Decomposition LU de la matrice tridiagonale A
% dans le cas ou tous les mineurs fondamentaux sont non nuls
% l : premiere sous-diagonale de L (1 sur la diagonale)
% d : diagonale de U
% u : premiere sur-diagonale de U
%
function [l,d,u]=DecompLUtridiag(A)
%
[n,m]=size(A);
if (n~=m) 
    disp(' La matrice n est pas carree !')
    return
end
d(1)=A(1,1); u(1)=A(1,2);
for i=2:n-1
    l(i-1)=A(i,i-1)/d(i-1);
    d(i)=A(i,i)-l(i-1)*u(i-1);
    u(i)=A(i,i+1);
end
l(n-1)=A(n,n-1)/d(n-1);
d(n)=A(n,n)-l(n-1)*u(n-1);

%
% Resolution du systeme lineaire Ax=b par factorisation LU
% pour une matrice A tridiagonale et factorisable
%
function [x]=resyslinLUtridiag(A,b)
%
[n,m]=size(A);nb=length(b);
if (n~=m) | (n~=nb)
    disp('resyslinLUtridiag : Erreur dans les dimensions du systeme !')
    return
end
% Decomposition LU : A=LU
[l,d,u]=DecompLUtridiag(A);
% Descente-Remontee : LUx=b
y(1)=b(1);
for i=2:n
    y(i)=b(i)-y(i-1)*l(i-1);
end
x=zeros(size(b));
x(n)=y(n)/d(n);
for i=n-1:-1:1
    x(i)=(y(i)-u(i)*x(i+1))/d(i);
end
 
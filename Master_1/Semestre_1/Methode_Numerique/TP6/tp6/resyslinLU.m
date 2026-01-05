function [x]=resyslinLU(A,b)
%
% Resolution du systeme lineaire Ax=b par factorisation LU
[n,m]=size(A);
if (n~=m) 
    disp('resyslinLU : La matrice n est pas carree !')
    return
end
% Decomposition LU : A=LU
[L,U]=DecompLU(A);
% Descente-Remontee : LUx=b
y=Descente(L,b);
x=Remontee(U,y);
 
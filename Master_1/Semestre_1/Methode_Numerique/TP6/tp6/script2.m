% TP6 - script 2
% Resolution de systemes lineaires tridiagonaux par decomposition LU
% en supposant que la matrice du systeme admet une telle factorisation
disp('TP6 - Script 2')
n=4;
% Factorisation LU
disp('2.1) Factorisation tridiagonale A = LU :')
A=[2 -1 0 0
     4 1 -2 0
     0 -9 10 1
     0 0 8 4]
[l,d,u]=DecompLUtridiag(A)
L=diag(l,-1)+diag(ones(n,1))
U=diag(d)+diag(u,1)
disp(['   Erreur = ',num2str(norm(A-L*U))]), disp(' ');
% Resolution du systeme lineaire Ax=b par faactorisation LU
disp('2.2) Resolution de A x = b par decomposition tridiagonale LU :')
b=[4 9 26.5 62]'
% xex=[4.5 5 7 1.5]';
x=resyslinLUtridiag(A,b)
disp(['   Residu = ',num2str(norm(b-A*x))])

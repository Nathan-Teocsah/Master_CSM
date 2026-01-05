% TP6 - script 1
% Resolution de systemes lineaires par decomposition LU
% en supposant que la matrice du systeme admet une telle factorisation
disp('TP6 - Script 1')
n=4;
% Factorisation LU
disp('1.1) Factorisation A = LU :')
A=[1 -1 2 -1
     2 1 2 0
     3 -9 14 -6
     4 5 10 6]
[L,U]=DecompLU(A)
disp(['   Erreur = ',num2str(norm(A-L*U))])
% Resolution du systeme lineaire Ax=b par faactorisation LU
disp('1.2) Resolution de A x = b par decomposition LU :')
b=[4 9 27 63]'
% xex=[2 -1 3 5]';
x=resyslinLU(A,b)
disp(['   Residu = ',num2str(norm(b-A*x))])

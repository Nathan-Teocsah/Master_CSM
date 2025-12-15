% Fonction mata.m
%
function A=mata(n);
% Construction de la matrice carree A (n * n) tridiagonale: 
% diagonale de 2, 1-ere sous et sur-diagonale de -1.
%
A=eye(n)+diag(-ones(1,n-1),1);
A=A+triu(A)';
% ou A=diag(-ones(1,n-1),-1)+2*eye(n)+diag(-ones(1,n-1),1);


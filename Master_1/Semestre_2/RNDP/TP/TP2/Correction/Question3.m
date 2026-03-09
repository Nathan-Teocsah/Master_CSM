5
% Résout par un schéma aux différences finies le problème aux limites
% -u’’(x) = f(x) sur ]0,1[
% u(0)=0 u’(1)=0
%
% Comparaison des temps de calcul entre la méthode de Gauss générique et
% la méthode de Choleski exploitant la forme tridiagonale de la matrice
%
% Auteur : Stéphane Balac - UFR de Mathématiques - Université de Rennes 1
% Décembre 2015
clear
close all
% données
f=@(x) sin(x).*exp(cos(x));
N=input('nombre de subdivisions de l’’intervalle [0,1] = ');
%
% Construction du système linéaire
h=1/N; % pas de la subdivision
x=h:h:1-h; % noeuds de la subdivision
A=diag(2*ones(1,N-1))-diag(ones(1,N-2),1)-diag(ones(1,N-2),-1);
A=A./h^2;
F=transpose(f(x));
%
% Comparaison des temps de calcul
t=cputime;
U1=A\F;
disp(['Temps CPU méthode de Matlab pour un stockage plein : ',num2str(cputime-t)]);
t=cputime;
U2=sparse(A)\F;
disp(['Temps CPU méthode de Matlab pour un stockage sparse : ',num2str(cputime-t)]);
t=cputime;
U3=choltrd(A,F);
disp(['Temps CPU méthode de Choleski pour matrice tridiagonale pleine : ',num2str(cputime-t)]);
t=cputime;
U4=choltrd(sparse(A),F);
disp(['Temps CPU méthode de Choleski pour matrice tridiagonale sparse : ',num2str(cputime-t)]);
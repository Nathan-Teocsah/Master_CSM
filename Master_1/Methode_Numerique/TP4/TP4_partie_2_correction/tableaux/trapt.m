function [Ir] = trapt(tx,n,tf)
% Calcul de l'integrale de tx(1) jusqu'a tx(n) de la fonction dont la
% valeur au point tx(i) est donnee par tf(i) en utilisant 
%la methode des trapezes avec une subdivision donnee par le tableau tx
% et pouvant etre irreguliere: x1=tx(1), ..., xn=tx(n).
%         somme(i=1,n-1) [f(x_i)+f(x_{i+1}] / [2*f(x_{i+1}-x_i)]
% n est le nombre de points et n-1 le nombre d'intervalles.
%
Ir = sum((tx(2:n)-tx(1:n-1)).*(tf(1:n-1)+tf(2:n)))/2;
%s=0;
%for i=1:n-1
%   s=s+(tx(i+1)-tx(i))*(tf(i)+tf(i+1));
%end
%Ir=s/2;

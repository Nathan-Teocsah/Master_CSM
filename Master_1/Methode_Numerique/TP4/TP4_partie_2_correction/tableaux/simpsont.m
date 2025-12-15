function [Ir] = simpsont(tx,n,tf)
% Calcul de l'integrale de tx(1) jusqu'a tx(n) de la fonction dont la
% valeur au point tx(i) est donnée par tf(i) en utilisant
% la methode de Simpson avec une subdivision 
% reguliere de pas h=[tx(n)-tx(1)]/(n-1) mais pour n-1 pair: x1, ..., xn.
% On pose nd=(n-1)/2
%   somme(i=1,nd) [f(x_{2i-1}) + 4f(x_{2i)} + f(x_{2i+1})] * h/3
%
% n est le nombre de points et n-1 le nombre d'intervalles qui doit êetre pair.
% Les sous-intervalles sont groupes par 2 consecutivement avec un meme pas
% dans chaque groupe pour pouvoir appliquer la methode (il n'est pas
% necessaire que tous les intervalles soient de meme taille)
%
if mod(n-1,2)==1
   'Le nombre d intervalles doit etre pair'
    return;
end
nd=(n-1)/2;
s=0;
for i=1:nd
   s=s+(tx(2*i+1)-tx(2*i-1))*(tf(2*i-1)+4*tf(2*i)+tf(2*i+1));
end
Ir=s/6;

% Version racourcie:
% pas = tx(2)-tx(1); % le pas est suppose regulier
% y = pas*(tf(1) + tf(n) + 4*(sum(tf(2:2:n-1))) + 2*(sum(tf(3:2:n-2))))/3;
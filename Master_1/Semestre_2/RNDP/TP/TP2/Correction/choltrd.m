function x = choltrd(A,F)
% résout le système linéaire A x = F par la méthode de choleski L D L^t pour une
% matrice A tridiagonale symmétrique définie positive.
% La matrice A est supposée stockée sous forme pleine ou sparse (on peut prévoir
% sinon d'adapter cette fonction pour un stockage creux spécifique)
%
% Auteur : Stéphane Balac - UFR de Mathématiques - Université de Rennes 1
% Décembre 2015

n=size(A,1);
% pré-allocation des tableaux pour gagner en rapidité d'exécution
d=zeros(1,n);
ell=zeros(1,n-1);
% Construction des matrices L et D 
d(1)=A(1,1);
if d(1)==0, error("La matrice du système linéaire n''est pas définie positive");end
for i=1:n-1
    ell(i)=A(i,i+1)/d(i);
    d(i+1)=A(i+1,i+1)-ell(i)^2*d(i);
    if d(i+1)==0, error("La matrice du système linéaire n''est pas définie positive");end
end
% Pour test : L=diag(ones(1,n))+diag(ell(1:n-1),-1); D=diag(d); norm(A-L*D*transpose(L))
% Résolution de L y = F
y(1)=F(1);
for i=2:n
    y(i)=F(i)-ell(i-1)*y(i-1);
end
% Résolution de D z = y
z=y./d;
% Résolution de L^t x = y
x(n)=z(n);
for i=n-1:-1:1
    x(i)=z(i)-ell(i)*x(i+1);
end
x=transpose(x); % pour avoir un vecteur colonne
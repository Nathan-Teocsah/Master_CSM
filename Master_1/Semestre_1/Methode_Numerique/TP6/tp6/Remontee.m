function [x]=Remontee(U,b)
%
% Resolution de Ux=b pour U triangulaire superieure
% Si b est une matrice avec plusieurs colonnes, 
% y sera une matrice de memes dimensions dont chaque colonne
% est la solution du systeme lineaire avec pour second membre la
% colonne correspondante de b.
%
[n,m]=size(U);
if (n~=m) 
    disp('Remontee : La matrice n est pas carree !')
    return
end
[nb,mb]=size(b);
if (nb~=n) 
    disp('Remontee : Les dimensions de la matrice et du second membre sont incompatibles !')
    return
end
%y=zeros(nb,mb);
for k=1:mb
    for i=n:-1:1
        x(i,k)=b(i,k);
        for j=n:-1:i+1
            x(i,k)=x(i,k)-U(i,j)*x(j,k);
        end
        x(i,k)=x(i,k)/U(i,i);
    end
end
 
function [y]=Descente(L,b)
%
% Resolution de Ly=b pour L triangulaire inferieure
% Si b est une matrice avec plusieurs colonnes, 
% y sera une matrice de memes dimensions dont chaque colonne
% est la solution du systeme lineaire avec pour second membre la
% colonne correspondante de b.
%
[n,m]=size(L);
if (n~=m) 
    disp('Descente : La matrice n est pas carree !')
    return
end
[nb,mb]=size(b);
if (nb~=n) 
    disp('Descente : Les dimensions de la matrice et du second membre sont incompatibles !')
    return
end
y=zeros(nb,mb);
for k=1:mb
    for i=1:n
        y(i,k)=b(i,k);
        for j=1:i-1
            y(i,k)=y(i,k)-L(i,j)*y(j,k);
        end
        y(i,k)=y(i,k)/L(i,i);
    end
end
 
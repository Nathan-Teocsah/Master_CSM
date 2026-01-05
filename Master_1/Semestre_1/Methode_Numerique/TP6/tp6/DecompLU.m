function [L,U]=DecompLU(A)
%
% decomposition LU de A
% dans le cas où tous les mineurs fondamentaux sont non nuls
%
[n,m]=size(A);
if (n~=m) 
    disp(' La matrice n est pas carree !')
    return
end
L=eye(n,n); U=zeros(n,n);
for i=1:n
    for j=1:i-1
        L(i,j)=A(i,j);
        for k=1:j-1
            L(i,j)=L(i,j)-L(i,k)*U(k,j);
        end
        L(i,j)=L(i,j)/U(j,j);
    end
    for j=i:n
        U(i,j)=A(i,j);
        for k=1:i-1
            U(i,j)=U(i,j)-L(i,k)*U(k,j);
            %disp([i,j,k,U(i,j)]);
        end
    end
end
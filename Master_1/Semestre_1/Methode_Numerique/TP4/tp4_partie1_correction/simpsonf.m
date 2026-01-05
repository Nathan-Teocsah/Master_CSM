function [Ir] = simpsonf(a,b,n,f)
% Calcul de l'integrale sur [a, b] de la fonction de pointeur f
% par la methode de Simpson avec une subdivision
% de pas (b-a)/n pour n pair: x0, x1, ..., xn. On pose nd=n/2
%     ((b-a)/(3*n)) * [(f(a)+f(b)) + 4*somme(i=0,nd-1) f(x_{2i+1})
%                                  + 2*somme(i=1,nd-1) f(x_{2i})]
%
if mod(n,2)==1
   disp('>>>>>> Attention : n doit etre pair')
    return;
end
pas=(b-a)/n; 
Ir = pas*sum([f(a),4*f(a+[1:2:n-1]*pas),2*f(a+[2:2:n-2]*pas),f(b)])/3;

% ou avec une boucle :
%
%dpas=pas+pas; xdi1=a+pas; xdi=a+dpas;
%nd=n/2;
%s1=f(xdi1);
%s2=0;
%xdi1=xdi1+dpas;
%for i=1:nd-1
%   s1=s1+f(xdi1);
%   s2=s2+f(xdi);
%   xdi1=xdi1+dpas;
%   xdi=xdi+dpas;
%end
%s=pas*(f(a)+f(b)+4*s1+2*s2)/3;
%Ir=s;
%
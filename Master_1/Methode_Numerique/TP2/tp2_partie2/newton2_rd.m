function [r,nbit]=newton2_rd(f,J,x0,eps,nmax)
% function [r,nbit]=newton(f,J,x0,eps,nmax)
%
% Methode de Newton dans R^d
% Parametres d'entree
%   f :    fonction dont on cherche une racine
%   J :    matrice jacobienne de f
%   x0 :   initialisation
%   eps :  precision demandee
%   nmax : nombre maximal d'iterations
% Parametres de sortie
%   r :    valeur calculee d'une racine
%   nbit : nombre d'iterations (-1 si J(xk) mal conditionn?e)

xk=x0;JJ=J(xk);
if (rcond(JJ)<1e-15), nbit=-1; r=x0; return, end
xkp1=xk-JJ\f(xk);
nbit=1;
while ((norm(xkp1-xk)>eps) && (nbit<nmax))
    xk=xkp1;JJ=J(xk);
    if (rcond(JJ)<1e-15), nbit=-1; break, end
    xkp1=xk-JJ\f(xk);
    nbit=nbit+1;
end
r=xkp1;
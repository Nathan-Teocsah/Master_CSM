function [r,nit]=dichotomie(f,a,b,eps)
% 
%  Methode de dichotomie
%  f: fonction
%  a,b: points initiaux tq f(a)f(b)<0
%  eps: precision
%  r: approximation d'une racine de f
%  nit : nombre d'iterations
% 
nit=0;
fa = f(a); fb = f(b);
while abs(b-a) > eps
    nit=nit+1;
    c = (a+b)/2;
    fc = f(c);
    prod=fa*fc;
    if (prod > 0) 
        a=c; fa = fc;
    elseif (prod < 0)
        b=c; fb = fc;
    else
        a=c;b=c;
    end
end
r = c;

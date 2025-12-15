% Methodes numeriques - TP 5 - meuler.m
function [tt,y]=meuler(t0,tf,n,y0,f)
%
% Resolution du systeme d'equations differentielles y'(t)=f(t,y(t)) sur ]t0,tf[
% par la methode d'Euler:    y_{i+1} = y_i + h f(t_i,y_i) pour i=0,n-1
% avec t_i=t0+i*h et y_i ~ y(t_i), la condition initiale etant y(t0)=y0.
%
h=abs(tf-t0)/n;
y(1,:)=y0+h*f(t0,y0)';
tt(1)=t0+h;
for i=1:n-1
   y(i+1,:)=y(i,:)+h*f(tt(i),y(i,:))';
   tt(i+1)=tt(i)+h;
end
tt=[t0,tt];y=[y0;y];

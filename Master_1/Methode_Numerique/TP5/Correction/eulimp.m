% Methodes numeriques - TP 5 - eulimp.m
function [tt,y]=eulimp(t0,tf,n,y0,f,tol,nitmax)
%
% Resolution du systeme d'equations differentielles y'(t)=f(t,y(t)) sur ]a,b[
% par la methode d'Euler implicite (elle est d'ordre 1):
%                      y_{i+1} = y_i + h f(t_{i+1},y_{i+1})    pour i=1,n
% avec t_i=t0+i*h et y_i ~ y(t_i), la condition initiale etant y(t0)=y0.
% Ici, la resolution consiste seulement a un point fixe a chaque etape, resolu
% par recurence simple.
% Entrees
% t0,tf  : temps initial et final.
% n      : il y a n+1 points de discretisation.
% y0     : vecteur initial.
%    f   : pointeur de la fonction  definissant le systeme.
% tol    : precision pour le point fixe.
% nitmax : Nombre maximal d'iterations pour le point fixe.
% Sorties
%  tt   : tableau des abscisses de la solution y, de longueur n+1.
%  y    : solution calculee, tableau de longueur n+1.
%
h=abs(tf-t0)/n;
tt(1)=t0+h;zn=y0;znp1=y0+h*f(tt(1),zn)';nit=1;
while norm(znp1-zn,inf)>tol
   zn=znp1;znp1=y0+h*f(tt(1),zn)';nit=nit+1;
   if (nit > nitmax) 
       disp('Nombre maximal d iterations atteint');return;
   end
end
y(1,:)=znp1;
for i=1:n-1
   tt(i+1)=tt(i)+h;
   zn=y(i,:);znp1=y(i,:)+h*f(tt(i+1),zn)';nit=1;
   while (norm(znp1-zn,inf)>tol) & (nit <= nitmax)
      zn=znp1;znp1=y(i,:)+h*f(tt(i+1),zn)';nit=nit+1;
      if (nit > nitmax) 
          disp('Nombre maximal d iterations atteint');return;
      end
   end
   y(i+1,:)=znp1;
end
tt=[t0,tt];y=[y0;y];

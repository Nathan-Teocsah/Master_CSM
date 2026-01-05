function [tt,y]=meuler(t0,tf,n,y0,f)
  % Commentaires
  h=abs(tf-t0)/n ;
  y(1, :)=y0+h*f(t0,y0)' ;
  tt(1)=t0+h ;
  for k=1 :n-1
    y(k+1, :)=y(k, :)+h*f(tt(k),y(k, :))' ;
    tt(k+1)=tt(k)+h ;
  end
  tt=[t0,tt] ;y=[y0 ;y] ;

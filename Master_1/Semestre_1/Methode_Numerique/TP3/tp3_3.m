nbpi=100 ;
x=-5+10*[0 :n]/n ; k=1 ;
p=lagrangem(@f,x,k) ; [yp,xe]=pmval(p,x,nbpi) ;
plot(xe,yp,c(j)) ;
yf=f(xe) ;err(k,j)=norm(yf-yp,inf) ;

Nmax=7, eps=1e-6, pas=0.1;

x01=-1:pas:2.5;
x02=-1.5 :pas :2.5;
x0=[x01(i) ; x02(j)];

n=length(x01) ;m=length(x02) ;c=zeros(m,n) ;
for i=1:n
  for j=1:m
    [r,nbit]=newton(@f,@fp,x0,eps,Nmax)
    c(i,j)=
  end
end





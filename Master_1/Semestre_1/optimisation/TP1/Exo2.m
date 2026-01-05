clear
a=0
b=3
K=[5:0.5:10];
N=length(K);
Neval=zeros(5,N);
X=zeros(5,N);

for num=1:1:5
  figure(num)
  hold on
  for i=1:1:N
    [X(num,i),Neval(num,i)]=dichoto(@func,num,a,b,10^(-K(i)))
  end
  plot(K,Neval(num,:))
end

figure
plot(K,Neval)
legend('1','2','3','4','5')



clear
a=0
b=3
K=[5:0.5:10];
gamma = (3-sqrt(5))/2;

N=length(K);
Nd=zeros(5,N);
Ns=zeros(5,N);
Diff=zeros(5,N);
D=zeros(5,N);
S=zeros(5,N);


for num=1:1:5
  figure(num)
  for i=1:1:N
    [D(num,i),Nd(num,i)]=dichoto(@func,num,a,b,10^(-K(i)));
    [S(num,i),Ns(num,i)]=secdor(@func,num,a,b,10^(-K(i)),gamma);
    Diff(num,i)=Nd(num,i)-Ns(num,i);
  end
  plot(-K,Diff(num,:))
  legend(["num = ",num2str(num)]);
end

figure
plot(-K,Diff) %on construit le graphique avec l'axe des abscisses en log en base 10
legend('num = 1','num = 2','num = 3','num = 4','num = 5')

x = 0:0.01:3;
num = 2:1:3;

figure
hold on
plot(x,@func(num,x));

epsilon=0.1

Num = 2;
[xs,neval]=secdor(@func,Num,0,3,10^(-10),(3-sqrt(5))/2);
plot(xs,func(Num,xs),'b*');
text(xs+epsilon*(-1)^(Num),func(Num,xs)-epsilon,[num2str(Num)]);


Num = 3;
[xs,neval]=secdor(@func,Num,0,3,10^(-10),(3-sqrt(5))/2);
plot(xs,func(Num,xs),'r*');
text(xs+epsilon*(-1)^(Num),func(Num,xs)-epsilon,[num2str(Num)]);

legend("num = 2", "num = 3","min de f2","min de f3");









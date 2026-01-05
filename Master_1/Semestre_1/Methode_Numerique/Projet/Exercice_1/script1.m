clear;close all;clc;
%%  Question 1
N = 4;
x0 = 2;
limite = sqrt(3);

xk = iter(@g5,x0,N);

ordre = log(abs(xk(2 : N+1)-limite)) ./ log(abs(xk(1 : N)-limite));

disp('Ordre de xk+1 = g5(xk)');
ordre



%%  Question 2

Nmax = 50;
eps = 1e-5;

pas=0.01;
x01=0 :pas :1.2;
x02=-0.6 :pas :1.2;

n = length(x01);
m = length(x02);

r = zeros(n,m,2);
nbit = zeros(m,n);

racine = [];

for i=1:n %% CALCUL DES RACINES
  for j=1:m
    x0=[x01(i) ; x02(j)];
    [r(i,j,:),nbit(j,i)] = newton(@f,@fp,x0,eps,Nmax);
    if nbit(j,i)>=0
      [x,y] = plus_proche(r(i,j,:),x01,x02);
      xr = [x;y];
      if !isequal(ismember(xr,racine),[1;1])
        racine = [racine xr];
      end
    end

  end
  disp(["progression : ",num2str(100*((i-1)*m+j)/(n*m))," pour i = ",num2str(i)," et j = ",num2str(j)]);
end



hold on;
%pcolor(x01,x02,nbit);
contourf(x01,x02,nbit);
for k=1:length(racine)
  plot(racine(1,k),racine(2,k),'ko');
end
shading flat
colorbar






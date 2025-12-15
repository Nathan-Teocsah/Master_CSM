clear, close all;
%%  QUESTION 1
a = -1;
b = 1;

vrai_integ = 2*sin(1);

n = 10;
N = [2,4,8,16,32,64,128,256,512,1024,2048];
nbP = 1; %% nbP = 1 (trapèze), nbP = 2 (Simpson)

logErr_Trap=[];
logErr_Simp=[];

for n=N
  x = linspace(a,b,n);

  logErr_Trap = [logErr_Trap log10(abs(vrai_integ - Integ(@f,x,1)))];
  logErr_Simp = [logErr_Simp log10(abs(vrai_integ - Integ(@f,x,2)))];
end

%% Calcul des ordres et constantes de convergences
logth=log10((b-a)./N);

p=polyfit(logth,logErr_Trap,1);
disp('1- Ordre et constante de convergence de la methode des Trapèzes composé:');disp([p(1), 10^p(2)]);

p=polyfit(logth,logErr_Simp,1);
disp('2- Ordre et constante de convergence de la methode de Simpson composé:');disp([p(1), 10^p(2)]);





%%  QUESTION 2

x = linspace(0,1,5);
I = IntegNC(@exp,x,4);

disp(' ');
disp(["3- Intégration avec la méthode de Newton-Cotes pour l=4 sur l'exponentielle entre 0 et 1 : ",num2str(I)]);







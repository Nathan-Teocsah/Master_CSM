% Methodes numeriques - TP 5 - lotvol.m
% Modele predateur-proie de Lotka-Volterra
%                        N'(t)= (a-b P(t)) N(t)          t dans [t0,tf]
%                        P'(t)= (-p+q N(t)) P(t)
% ou N(t) est le nombre de proies et P(t) le nombre de predateurs.
% On prendra a=3, b=2, p=2.5, q=2 (variables globales pour la fonction flv.m qui
% definit le systeme). 
% On va resoudre cette equation (par differentes methodes) et representer 
% P(t) en fonction de N(t) pour certaines valeurs de N0 et N0. On doit
% avoir des courbes fermees correspondant a un processus periodique.
%
close all;
global a b p q;
a=3;b=2;p=2.5;q=2;
%
% TP5 - 1
% Resolution par la methode d'Euler.
t0=0;tf=16;N0=1.5;
figure(1)
P0=3.5;tn=[20000, 10000, 2000, 500, 350, 300];nbtn=length(tn);
for i=1:nbtn
   subplot(2,3,i);n=tn(i);x0=[N0,P0];[t,x]=meuler(t0,tf,n,x0,@flv);
   hold on;plot(x(:,1),x(:,2));[np,m]=size(x);plot(N0,P0,'or',x(np,1),x(np,2),'og');hold off;
   title(['n = ',num2str(n)])
   xlabel('nombre de proies N');ylabel('nombre de predateurs P')
end
%  print -deps2 reseul1.ps
figure(2);n=2000;
hold on;res=0;j=1;
for P0=1.5:1:3.5
      x0=[N0,P0];
      [t,x]=meuler(t0,tf,n,x0,@flv);
      plot(x(:,1),x(:,2));
      [np,m]=size(x);
      plot(N0,P0,'or',x(np,1),x(np,2),'og')
      text(N0+.1,P0,['P0=',num2str(P0)]);
end
hold off;
title('Portrait de phase P(N) - Lotka-Volterra - Euler')
xlabel('nombre de proies N')
ylabel('nombre de predateurs P')
%  print -deps2 reseul2.ps
%
% TP5 - 2
% Resolution par une Euler implicite (symplectique d'ordre 1).
% 
figure(3);t0=0;tf=16;n=2000;nitmax=100;tol=1e-10;
hold on;res=0;j=1;N0=1.5;
for P0=1.5:1:3.5
      x0=[N0,P0];
      [t,x]=eulimp(t0,tf,n,x0,@flv,tol,nitmax);
      plot(x(:,1),x(:,2));
      [np,m]=size(x);
      plot(N0,P0,'or',x(np,1),x(np,2),'og')
      text(N0+.1,P0,['P0=',num2str(P0)]);
end
hold off;
title('Portrait de phase P(N) - Lotka-Volterra - Euler implicite')
xlabel('nombre de proies N')
ylabel('nombre de predateurs P')
%  print -deps2 reseulimp.ps
%
% TP5 - 3
% Resolution par une methode de Runge-Kutta explicite: ode23.
% tf=16
figure(4);t0=0;tf=16;n=2000;
hold on;res=0;j=1;N0=1.5;
for P0=1.5:1:3.5
      x0=[N0,P0];
      [t,x]=ode23(@flv,linspace(t0,tf,n+1),x0);
      plot(x(:,1),x(:,2));
      [np,m]=size(x);
      plot(N0,P0,'or',x(np,1),x(np,2),'og')
      text(N0+.1,P0,['P0=',num2str(P0)]);
end
hold off;
title('Portrait de phase P(N) - Lotka-Volterra - ode23 - tf = 16')
xlabel('nombre de proies N')
ylabel('nombre de predateurs P')
%  print -deps2 resrk1.ps
% 
% Evolution des populations en fonction du temps.
figure(6)
hold on;
plot(t,x(:,1),'b');
plot(t,x(:,2),'g--');
title('N et P en fonction du temps - Lotka-Volterra - ode23 - tf=16')
xlabel('Temps');ylabel('Effectifs');legend('Proies', 'Predateurs');
hold off;
% print -deps2 nptemps.ps
%
% tf=100
figure(5)
tf=100;n=20000;
hold on;res=0;j=1;N0=1.5;
for P0=1.5:1:3.5
      x0=[N0,P0];
      [t,x]=ode23(@flv,linspace(t0,tf,n+1),x0);
      plot(x(:,1),x(:,2));
      [np,m]=size(x);
      plot(N0,P0,'or',x(np,1),x(np,2),'og')
      text(N0+.1,P0,['P0=',num2str(P0)]);
end
hold off;
title('Portrait de phase P(N) - Lotka-Volterra - ode23 - tf = 100')
xlabel('nombre de proies N')
ylabel('nombre de predateurs P')
%  print -deps2 resrk2.ps
% scriptinteg.m
% Etude de la convergence des methodes d'integration numeriques:
%           Rectangles, Trapezes, Point-Milieu, Simpson
% 
%
clear
a=0;b=1;tn=[2,4,8,16,32,64,128,256,512,1024,2048];N=length(tn);
logErrTrap=zeros(N,1);logErrPtmil=logErrTrap;logErrSimp=logErrTrap;
logErrRect=logErrTrap;logth=logErrTrap;
%
% calcul pour la fonction reguliere f2(x)=exp(x) sur [0,1]
disp('A- Pour la fonction reguliere y=exp(x) sur [0,1]');
%   Valeur exacte de l'integrale :    
    intex=exp(b)-exp(a);
%   car la primitive de la fonction f2(x)=exp(x) est elle-meme
for i=1:N
    n=tn(i);logth(i)=log10((b-a)/n);
    logErrRect(i)=log10(abs(intex-rectf(a,b,n,@exp)));
    logErrTrap(i)=log10(abs(intex-trapf(a,b,n,@exp)));
    logErrPtmil(i)=log10(abs(intex-ptmilf(a,b,n,@exp)));
    logErrSimp(i)=log10(abs(intex-simpsonf(a,b,n,@exp)));
end
% Representation des courbes.
figure(1);
hold on;
plot(logth,logErrRect,'-db');
plot(logth,logErrTrap,'-or');
plot(logth,logErrPtmil,'-xg');
plot(logth,logErrSimp,'-sm');
xlabel('log_{10}(h)'); ylabel('log_{10}(Erreur)');
title('Integration numerique : convergence pour exp(x) sur [0,1]');
legend('Rectangles','Trapezes','Pt milieu','Simpson','Location','SouthEast');
hold off;
% Calcul des ordres de convergence
p=polyfit(logth,logErrRect,1);
disp('1- Ordre et constante de convergence de la methode des Rectangles:');disp([p(1), 10^p(2)]);
p=polyfit(logth,logErrTrap,1);
disp('2- Ordre et constante de convergence de la methode des Trapezes:');disp([p(1), 10^p(2)]);
p=polyfit(logth,logErrPtmil,1);
disp('3- Ordre et constante de convergence de la methode du Point Milieu:');disp([p(1), 10^p(2)]);
p=polyfit(logth,logErrSimp,1);
disp('4- Ordre et constante de convergence de la methode de Simpson:');disp([p(1), 10^p(2)]);
%
% calcul pour la fonction reguliere periodique f5(x)=sin(2 Pi x) sur une periode [0,1]
disp('B- Pour la fonction periodique y=sin(2 PI x) sur une periode [0,1]');
intex=0;
for i=1:N
    n=tn(i);th(i)=(b-a)/n;
    logErrRect(i)=log10(abs(intex-rectf(a,b,n,@f5)));
    logErrTrap(i)=log10(abs(intex-trapf(a,b,n,@f5)));
    logErrPtmil(i)=log10(abs(intex-ptmilf(a,b,n,@f5)));
    logErrSimp(i)=log10(abs(intex-simpsonf(a,b,n,@f5)));
end
% Representation des courbes.
logth=log10(th(:));
figure(2);
hold on;
plot(logth,logErrRect,'-db');
plot(logth,logErrTrap,'-or');
plot(logth,logErrPtmil,'-xg');
plot(logth,logErrSimp,'-sm');
xlabel('log_{10}(h)'); ylabel('log_{10}(Erreur)');
title('Integration numerique : convergence pour sin(2 PI x) sur [0,1]');
legend('Rectangles','Trapezes','Pt milieu','Simpson','Location','SouthEast');
hold off;
disp('Voir les courbes de la Figure 2 : erreur proche de la precision machine'); disp(' ');
%
% calcul pour la fonction continue mais non derivable f3(x)=|sin(2 Pi x)| sur [0,1]
disp('C- Pour la fonction non derivable y=|sin(2 PI x)| sur [0,1]');
intex=2/pi;
for i=1:N
    n=tn(i);th(i)=(b-a)/n;
    logErrRect(i)=log10(abs(intex-rectf(a,b,n,@f3)));
    logErrTrap(i)=log10(abs(intex-trapf(a,b,n,@f3)));
    logErrPtmil(i)=log10(abs(intex-ptmilf(a,b,n,@f3)));
    logErrSimp(i)=log10(abs(intex-simpsonf(a,b,n,@f3)));
end
% Representation des courbes.
logth=log10(th(:));
figure(3);
hold on;
plot(logth,logErrRect,'-db');
plot(logth,logErrTrap,'-or');
plot(logth,logErrPtmil,'-xg');
plot(logth,logErrSimp,'-sm');
xlabel('log_{10}(h)'); ylabel('log_{10}(Erreur)');
title('Integration numerique : convergence pour |sin(2 PI x)| sur [0,1]');
legend('Rectangles','Trapezes','Pt milieu','Simpson','Location','SouthEast');
hold off;
% Calcul des ordres de convergence
p=polyfit(logth,logErrRect(:),1);
disp('1- Ordre et constante de convergence de la methode des Rectangles:');disp([p(1), 10^p(2)]);
p=polyfit(logth,logErrTrap(:),1);
disp('2- Ordre et constante de convergence de la methode des Trapezes:');disp([p(1), 10^p(2)]);
p=polyfit(logth,logErrPtmil(:),1);
disp('3- Ordre et constante de convergence de la methode du Point Milieu:');disp([p(1), 10^p(2)]);
p=polyfit(logth,logErrSimp(:),1);
disp('4- Ordre et constante de convergence de la methode de Simpson:');disp([p(1), 10^p(2)]);
%
% calcul pour la fonction reguliere y=exp(x) sur [0,1] par quad et quadl
disp('D- Pour la fonction reguliere y=exp(x) sur [0,1] avec quad et quadl');
intex=exp(1)-1;
disp('1- Erreur et log10(Erreur) avec quad:');
Err=abs(intex-quad(@exp,0,1));
disp(Err);disp(log10(Err));
disp('2- Erreur et log10(Erreur) avec quadl:');
Err=abs(intex-quadl(@exp,0,1));
disp(Err);disp(log10(Err));
%
% calcul pour la fonction non derivable y=|sin(2 Pi x)| sur [0,1] par quad et quadl
disp('E- Pour la fonction non derivable y=|sin(2 PI x)| sur [0,1] avec quad et quadl');
intex=2/pi;
disp('1- Erreur et log10(Erreur) avec quad:');
Err=abs(intex-quad(@f3,0,1));
disp(Err);disp(log10(Err));
disp('2- Erreur et log10(Erreur) avec quadl:');
Err=abs(intex-quadl(@f3,0,1));
disp(Err);disp(log10(Err));

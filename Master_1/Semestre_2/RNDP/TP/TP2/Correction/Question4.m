% Étude de la convergence du schéma de discrétisation par différences finis
% du problème aux limites
% -u’’(x) = f(x) sur ]0,1[
% u(0)=0 u(1)=0
clear
close all
% données
alpha=pi;
f=@(x) sin(alpha*x); % second membre
uex=@(x) (sin(alpha*x)-x*sin(alpha))/alpha^2;
TN=round(10.^[1:0.5:5.5]); % nombre de subdivisions de l’intervalle [0,1]
%
err=[];
for N=TN
    % Construction du système linéaire
    h=1/N; % pas de la subdivision
    x=h:h:1-h; % noeuds de la subdivision
    B=[-ones(1,N-1);2*ones(1,N-1);-ones(1,N-1)]';
    A=(1./h^2)*spdiags(B,[-1,0,1],N-1,N-1);
    F=transpose(f(x));
    % Resolution du système
    U=choltrd(A,F);
    Uex=transpose(uex(x));
    err=[err,norm(U-Uex)/norm(Uex)];
end
% Courbe de l’erreur en fonction de N
loglog(TN,err,'o')
grid
hold on
loglog(TN,1./TN.^2,'-r','Linewidth',2);
xlabel('N')
ylabel('erreur relative');
legend('valeurs expérimentales','courbe théorique 1/N^2');

figure()
% Courbe de l’erreur en fonction de h
h=1./TN;
loglog(h,err,'o')
grid
hold on
loglog(h,h.^2,'-r','Linewidth',2);
xlabel('h')
ylabel('erreur relative');
legend('valeurs expérimentales','courbe théorique O(h^2)');
c=polyfit(log(h),log(err),1);
disp(['Taux de convergence observé : ',num2str(c(1))]);
pause
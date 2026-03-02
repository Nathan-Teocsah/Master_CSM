    % Résout par un schéma aux différences finies le problème aux limites
% -u’’(x) = f(x) sur ]0,1[
% u(0)=0 u(1)=0
clear, close all
% données
alpha=pi;
f=@(x) sin(alpha*x); % second membre
uex=@(x) (sin(alpha*x)-x*sin(alpha))/alpha^2;
N=input('Valeur de N = '); % nombre de subdivisions de l’intervalle [0,1]
% Construction du système linéaire
h=1/N; % pas de la subdivision
x=h:h:1-h; % noeuds de la subdivision
% Construction du système linéaire
A=diag(2*ones(1,N-1))-diag(ones(1,N-2),1)-diag(ones(1,N-2),-1);
A=A./h^2;
F=transpose(f(x));
% Résolution du système linéaire
U=A\F;
% On complète le vecteur solution en ajoutant la donnée de Dirichlet en 0 et 1
U=[0;U;0];
% Calcul de la solution exacte aux noeuds
Uex=[0;transpose(uex(x));0];
x=[0,x,1];
% Affichage des résultats
plot(x,U,'.-b','LineWidth',2,x,Uex,'-r','LineWidth',2)
legend(['solution calculée pour N=',num2str(N)], 'solution exacte', 'location','northwest');
grid
% calcul de l’erreur
disp(['erreur quadratique relative en % : ',num2str(100*norm(U-Uex)/norm(Uex))]);
pause
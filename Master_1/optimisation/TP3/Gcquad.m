% Ce script met en oeuvre la methode du gradient conjugué.
%
% Cas quadratique elliptique et cas general.
%
%
clear all; close all;
global numex
global a b c p        % paramètres pour les fonctionnelle 4 et 6
a=4; b=4; c=10; p=10;

%
........................ Choix de la fonction test ....................
%
numex = input('Choisir l''exemple (entre 1 et 6) : ');    % (1 2 3 4 5 ou 6) = choix de la fonction test sur laquelle on veut appliquer l'algorithme
if (numex <=3)
  quadratique = input('faut-il la traiter comme une fonction quadratique (o/n) ? ','s'); %('OUI' ou 'NON') dépendant de la fonction test que l'on choisie
else % si numex >= 4 on ne peut pas considérer la fonction comme une fonction quadratique
  quadratique = 'n';
end

%
........................ Initialisation des paramètres ....................
%

disp('Donner le vecteur u0 = (x,y) :');
x = input('x = ');
y = input('y = ');
disp(blanks(2)');
u0 = [x;y];      % on initialise u0

epsil = 1e-6;             % précision que l'on souhaite entre 2 itérés
tslesuk = u0;             % stockera l''ensemble des iteres successifs
tslesgk = GJ(u0);          % stockera l''ensemble des gradients des itérés
niter = 0;                % nombre d'itération par boucles
nitermax = 1000;          % nombre d'itération maximum
tau = 1e-6;               % critère d'arrêt



%
........................ Algorithme du gradient conjugué ....................
%

disp('---------------------');
disp('Execution de l''algorithme du gradient optimal');
disp(blanks(2)');

uk=u0;
rk = GJ(uk);     % Servira pour le test d'arret.
vk = rk;         % Première direction de descente.
lambdak = 0;
nbevalinfmin = 0;
if (quadratique=='o')
  %
  disp('----------------------');
  printf('||u_%d|| = %e    |      ||r_%d||=%e\n',niter,norm(uk),niter,norm(rk)); %Affichage de la norme de u_0
  disp('-----------------------');

  while (norm(rk)>tau)
    niter++;
    vk = lambdak*vk+rk;
    muk = rk'*rk/(vk'*AJ(vk));
    uk = uk-muk*vk;           % calcul de u_{k+1}
    lambdak = rk'*rk;         % calcul de (rk,rk) pour le calcul de lambdak
    rk = GJ(uk);              % résidu
    lambdak = rk'*rk/lambdak;

    tslesuk = [tslesuk uk];
    tslesgk = [tslesgk GJ(uk)];

    printf('||u_%d|| = %e    |      ||r_%d||=%e\n',niter,norm(uk),niter,norm(rk)); %Affichage de la norme de u_k et de r_k
    disp('-----------------------');
  end
else
  error('Mauvaise réponse');
end

disp(blanks(2)')


%
........................ Affichage des itérés et du nombre d'itérations ....................
%
mx=min(tslesuk(1,:));
Mx=max(tslesuk(1,:));
xmin = max(min(mx,mx-3.3),-50);
xmax = min(max(Mx,Mx+3.3),50);
xdiff = xmax-xmin;

my=min(tslesuk(2,:));
My=max(tslesuk(2,:));
ymin = max(min(my,my+3.3),-50);
ymax = min(max(My,My+3.3),50);
ydiff = ymax-ymin;
xmin = xmin - 0.5*xdiff; xmax = xmax + 0.5*xdiff;
ymin = ymin - 0.5*ydiff; ymax = ymax + 0.5*ydiff;

disp("--------------------");
disp("Affichage des résultats");
disp("--------------------");

afficher_resultat(uk, niter, nitermax, nbevalinfmin);
figure(1)
visiso(xmin, xmax, ymin, ymax); %contient les fonctions permettant l’affichage graphique des lignes de niveau
vitergc(uk,tslesuk,tslesgk,niter,nitermax)

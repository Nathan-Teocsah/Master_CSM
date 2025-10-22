% Ce script met en oeuvre la methode du gradient a pas optimal.
%
% Cas quadratique elliptique et cas general.
%
%
clear all; close all;
global numex
global a b c p
a=4; b=4; c=10; p=10;

%
........................ Choix de la fonction test ....................
%
numex= 1;    % (1 2 3 4 5 ou 6) = choix e la fonction test sur laquelle on veut appliquer l'algorithme
quadratique = 'OUI'; %('OUI' ou 'NON') dépendant de la fonction test que l'on choisie

%
........................ Initialisation des paramètres ....................
%
difference = 1;     % Servira pour le test d'arret.
u0 = [0 ; 0];       %On initialise à 0/
uk=u0;              % uk contiendra les iteres successifs
tslesuk = u0;       % stockera l''ensemble des iteres successifs
niter = 0;          % Nombre d'itération par boucles
nitermax = 100000;  % Nombre d'itération maximum
epsil = 1e-6;       % précision que l'on souhaite entre 2 itérés


%
........................ Algorithme du gradient à pas optimal ....................
%
if (quadratique=='OUI')
  %
   while((difference > epsil) && (niter < nitermax))
     niter += 1;
     wk = GJ(uk);
     alphak = wk'*wk/AJ(uk)'*wk;
     difference = norm(alphak*wk); % || u_{k+1}-u_{k} || = difference
     uk = uk-alphak*wk;
     tslesuk = [tslesuk uk];
   end
   niter;
   tslesuk;
  %
elseif (quadratique=='NON')
  %
  nbevalinfmin = 0;
  while((difference > epsil) && (niter < nitermax))
   niter += 1;
   wk = GJ(uk) ;
   myfunction = @(x)J(uk - x * wk);
   [alphak, fval, exitflag, output] = fminbnd(myfunction,0, 100000); % il faut tester pour trouver les bonnes valeurs
   nbevalinfmin = nbevalinfmin + output.iterations; % on récupère le nombre d'itération effectuée par la fonction précédente
   difference = norm(alphak*wk); % || u_{k+1}-u_{k} || = difference
   uk = uk-alphak*wk; % calcul de u_{k+1}
   tslesuk = [tslesuk uk]; % Rajout de u_{k+1} au tableau stockant les différents uk
  end
  nbevalinfmin,niter
  tslesuk
  %
else
 error('Specifiez par OUI ou NON le caractere quadratique de la fonctionnelle.')
end

%
........................ Affichage des itérés et du nombre d'itérations ....................
%
xmin = min(min(tslesuk(1,:)),-3.3);
xmax = max(tslesuk(1,:));
xdiff = xmax-xmin;
ymin = min(tslesuk(2,:));
ymax = max(tslesuk(2,:));
ydiff = ymax-ymin;
%xdiff = max(xdiff,ydiff); ydiff = xdiff;
xmin = xmin - 0.5*xdiff; xmax = xmax + 0.5*xdiff;
ymin = ymin - 0.5*ydiff; ymax = ymax + 0.5*ydiff;

figure(1)

visiso(xmin, xmax, ymin, ymax); %contient les fonctions permettant l’affichage graphique des lignes de niveau
visiter(uk, tslesuk, niter, nitermax); %caractéristiques de la méthode du gradient à pas optimal : suite des points (uk ) et directions dedescente

axis equal

%
........................ Vérification de l'inégalité question 3 ....................
%

if (quadratique=='OUI')
  I = [];
  L = [];
  M = [];
  r = cond(A)
  n0 = norm(u0-uk);
  for i=1:1:niter
    I = [I i];
    L = [L log(norm(tslsuk(:,i)-uk))];
    M = [M k*log((r-1)/(r+1)*n0)];
    plot(I,L,I,M);
    hold off;
    pause(0.5);
  end
end

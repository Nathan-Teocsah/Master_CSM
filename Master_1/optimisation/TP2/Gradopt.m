% Ce script met en oeuvre la methode du gradient a pas optimal.
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
u0 = [x;y];      %On initialise u0

epsil = 1e-6;             % précision que l'on souhaite entre 2 itérés
tslesuk = u0;             % stockera l''ensemble des iteres successifs
niter = 0;                % Nombre d'itération par boucles
nitermax = 2000;        % Nombre d'itération maximum



%
........................ Algorithme du gradient à pas optimal ....................
%

disp('---------------------');
disp('Execution de l''algorithme du gradient à pas optimal');
disp(blanks(2)');

uk=u0;
difference = epsil+1;     % Servira pour le test d'arret.
nbevalinfmin = 0;
if (quadratique=='o')
  %
  disp('----------------------');
  printf('||u_%d|| = %f\n     |',niter,norm(uk)); %Affichage de la norme de u_0
  disp('-----------------------');
   while((difference > epsil) && (niter < nitermax) && (norm(uk)!= Inf) && (norm(uk)!= NaN))
     niter += 1;
     wk = GJ(uk);
     alphak = wk'*wk/(AJ(wk)'*wk);
     difference = norm(alphak*wk); % || u_{k+1}-u_{k} || = difference
     uk = uk-alphak*wk;
     tslesuk = [tslesuk uk];
     printf('||u_%d|| = %e    et    ||u_%d-u_%d||=%e\n',niter,norm(uk),niter,niter-1,difference); %Affichage de la norme de u_k et du critère d'arrêt différence7
     disp('-----------------------');
   end
  %
elseif (quadratique=='n')
  %
  prec_borne = 1e-4; % précision choisie pour savoir si on est trop proche de la borne choisie pour trouver le minimum de myfunction
  borne_max = 1; % Le pas par lequel on incrémente la borne maximale
  %pas = input('Pas par lequel on incrémente la borne maximale pour trouver le minimum de myfunction : ');
  if (borne_max < prec_borne)
    error('la borne maximale de recherche du minimum est plus petit la précision au bord (ligne 58 et 59)');
  else
    disp('-----------------------');
    printf('||u_%d|| = %f\n',niter,norm(uk)); %Affichage de la norme de u_0
    disp('--------------------------');
    while((difference > epsil) && (niter < nitermax) && (norm(uk)!= Inf) && (norm(uk)!= NaN))
     niter += 1;
     wk = GJ(uk) ;
     myfunction = @(x)J(uk - x * wk);
     [alphak, fval, exitflag, output] = fminbnd(myfunction,0, borne_max);
     nbevalinfmin = nbevalinfmin + output.iterations; % on récupère le nombre d'itération effectuée par la fonction précédente
     i=0;
     while ((borne_max-alphak)< prec_borne) % Tant qu'on est trop proche de la borne supérieur on continue à chercher le minimum
       borne_max += borne_max*10^i++;
       [alphak, fval, exitflag, output] = fminbnd(myfunction,0, borne_max);
       nbevalinfmin = nbevalinfmin + output.iterations;
     end
     borne_max = alphak+prec_borne; %on actualise le pas par rapport à avant
     difference = norm(alphak*wk); % || u_{k+1}-u_{k} || = difference
     uk = uk-alphak*wk; % calcul de u_{k+1}
     tslesuk = [tslesuk uk]; % Rajout de u_{k+1} au tableau stockant les différents uk
     printf('||u_%d|| = %e    et    ||u_%d-u_%d||=%e\n',niter,norm(uk),niter,niter-1,difference); %Affichage de la norme de u_k et du critère d'arrêt différence
     disp('-----------------------');
    end
    %
  end
else
 error('Specifiez par o (OUI) ou n (NON) le caractere quadratique de la fonctionnelle.')
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
visiter(uk, tslesuk, niter);    %caractéristiques de la méthode du gradient à pas optimal : suite des points (uk ) et directions dedescente

axis equal


%
........................ Vérification de l'inégalité question 3 ....................
%

if (numex<=3)
  disp(blanks(2)');
  disp('---------------------');
  disp('Question 3 : Vérification de l''inégalité ||uk-u*||<(r-1)/(r+1))^k*||u0-u*||');
  disp(blanks(2)');
  etude_inegalite = input ('Voulez-vous étudier cette inégalitée (o/n) ? ','s');
  if (etude_inegalite == 'o')
    disp(blanks(2)');
    I = [];
    L = [];
    M = [];
    r = cond(A);
    q = (r-1)/(r+1);
    n0 = norm(u0-uk);
    rep = input (['Voulez vous afficher les log(||uk-u*||) et log((r-1)/(r+1))^k*||u0-u*||), il y en a ',num2str(niter),', (o/n) ? '],'s');
    figure (2)
    for i=1:1:niter
      I = [I i-1];
      L = [L log(norm(tslesuk(:,i)-uk))];
      M = [M log(q^(i-1)*n0)];
      if (rep == 'o')
        disp("")
        disp("-----------------------------------------------------")
        disp("k | log(||uk-u*||)  |   log((r-1)/(r+1))^k*||u0-u*||)")
        disp("-----------------------------------------------------")
        printf("%d | %f       |     %f\n",i-1,log(norm(tslesuk(:,i)-uk)),log(q^(i-1)*n0));
      end
      plot(I,L,I,M);
      legend("log(||uk-u*||)","log((r-1)/(r+1))^k*||u0-u*||)");
      title('Vérification de l''inégalité de la question 3');
      hold off;
      pause(0.1);
    end
  end
  disp(blanks(2)');
end

%
........................ Etude de la convergence (question 6) ....................
%

disp('---------------------')
disp('Question 6 : Etude de la convergence');
disp(blanks(2)');
etude_conv = input ('Voulez-vous étudier la convergence (o/n) ? ','s');
if (etude_conv == 'o')
  I = [];
  L = [];
  rep = input (['Voulez vous afficher les log(||uk-u*||), il y en a ',num2str(niter),', (o/n) ? '],'s');
  figure (3)
  for i=1:1:niter
    I = [I i-1];
    L = [L log(norm(tslesuk(:,i)-uk))];
    if (rep=='o')
      disp("")
      disp("-----------------------------------------------------")
      disp("k | log(||uk-u*||)")
      disp("-----------------------------------------------------")
      printf("%d | %f\n",i-1,log(norm(tslesuk(:,i)-uk)));
    end
    plot(I,L);
    legend("log(||uk-u*||)");
    title('Etude de la convergence (question 6)');
    hold off;
    pause(0.1);
  end
end

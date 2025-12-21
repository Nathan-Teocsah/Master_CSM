%% ============================================================================
%% INITIALISATION =========================================================
clear;close all;clc;

addpath('./Fct');
addpath('./Initialisation');
addpath('./Mode');
addpath('./Supplement');
addpath('./Violon');


%% Choix des conditions aux limites
validBC = {'DD','NN','DN','ND'};

while true
    typeBC = upper(strtrim(input("Choisissez le type de C.L. ('DD','NN','DN','ND') : ",'s')));
    if ismember(typeBC, validBC)
        break
    end
    disp("Réponse invalide. Les choix possibles sont : DD, NN, DN, ND.");
end

%% ========================================================================
% Chargement des parametres
nmax=50;        % Nombre maximal de mode considere
Note=440;       % Frequence fondamentale [Hz]
NP=1;           % Nombre de période (pour la plus grande des périodes, ie. le mode avec la plus petite fréquence) que l'on veut représenter
P_micro = [1 1]; %Position du micro
ps = 10; %Echantillonage de s pour permettre de calculer rapidement une intégrale sur [0,L]
pt = 10; %Echantillonage de t

[L,R,E,ro,H,el,Nw,Aff,rho_air,c_son,omega]=ParamInit(nmax);


% Parametres intermediaires
[A, C, N0, Def] = ParamInter(R, L, ro, E, Note);

% Domaine modal
[n, kn, wn, Lamb, Per, Freq] = DomaineModal(L, C, nmax, typeBC);


% Domaine spatial
[s,Ns,ds] = DomaineSpatial(L,Lamb);

% Domaine temporel
[dt,t,Nt,tmax]=DomaineTemporel(Per,L,NP);
% Rq : dans une phase de debugage, il faut que [Nt,Ns,Nw] aient des valeurs
% raisonnables (<=1000) et si possible distinctes.
disp(['[Nt,Ns,Nw]=[' num2str([Nt,Ns,Nw]) ']']);


%% ========================================================================
%% ANALYSE MODALE =========================================================

while (1)
  rI = input('Voulez vous simuler un violon (v) ou une corde pincée (p) ? ','s' );
  if ((rI=='v')||(rI=='p'))
    break
  end
  disp('Les réponses acceptables sont : v ou p');
end

disp(' ');
disp('Touche ENTRER = Non');
disp(' ');

if (rI=='p')
  % Modes propres
  Aff = input('Voulez vous afficher quelques modes propres ? (o/n) ','s');
  Y = ModePropre(kn, s, Nw, Aff, typeBC);

  % Amplitude modale
  Aff = input('Voulez vous visualiser des amplitudes modales an ? (o/n) ','s');
  [an, bn] = AmplitudeModale(Y, s, wn, L, el, H, Aff);

  % Fonction en temps
  Aff = input('Voulez vous visualiser T(t) pour quelque modes ? (o/n) ','s');
  T = FctTemporelle(wn, an, bn, t, Aff);

  % Deplacement
  u=FctDeplacement(Y, T);
else
  % Modes propres
  Aff = input('Voulez vous visualiser quelques modes propres ? (o/n) ','s');
  Y=ModesPropresViolon(kn, s, Nw, Aff, nmax);

  % Fonction en temps
  Aff = input('Voulez vous visualiser q(t) pour quelques modes ? (o/n) ','s');
  q = FonctionTemporelleViolon(s, t, kn, wn, L, A, el, ro, omega, Aff);

  % Deplacement
  u=FctDeplacementViolon(Y,q);

end

%% ========================================================================
%% VALORISATION ==========================================================

Type = [];

r=input('Voulez vous visualiser u(s,t) a divers instant ? (o/n) ','s');
if (r=='o')
  Type = 1;
end

r=input('Voulez vous visualiser u(s,t) en divers points de la corde ? (o/n) ','s');
if (r=='o')
  Type = [Type 2];
end

disp(' ');
r=input('Voulez vous afficher la corde en mouvement ? (o/n) ','s');
if (r=='o')
  Type = [Type 3];
end

Illustration(Type,u,s,t,Nt,L,H,dt,tmax);



disp(' ');
r=input('Voulez vous produire le son associé ? (o/n) ','s');
if (r=='o')
  Son
end


disp(' ');
diagramme_directivite;


disp(' ');
instrument;

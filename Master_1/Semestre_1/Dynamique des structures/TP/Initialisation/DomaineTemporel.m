function [dt,t,Nt,tmax]=DomaineTemporel(Per,L,NP)

% Domaine temporel
dt=min(Per)/20; % Pas en temps [s]
tmax=max(Per)*NP;% Temps maximum de la simulation [s]
t=0:dt:tmax;    % Echantillonage temporel [s]
Nt=length(t);   % Nombre de points d'echantillonages en temps

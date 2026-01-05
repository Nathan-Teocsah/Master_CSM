function [s, Ns, ds] = DomaineSpatial(L, Lamb)
  ds=min(Lamb)/20;% Pas en espace [m]
  s=(0:ds:L);     % Echantillonage spatial [m]
  Ns=length(s);   % Nombre de points d'echantillonages en espace
end

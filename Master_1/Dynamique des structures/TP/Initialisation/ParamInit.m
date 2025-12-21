function [L,R,E,ro,H,el,Nw,Aff,omega,rho_air,c_son]=ParamInit(nmax)

  % Geometrie : section cicrculaire
  L=0.3;            % Longueur [m]
  R=0.001;        % Rayon [m]

  % Materiau : acier
  E=210e9;        % Module de Young [Pa]
  ro=7800;        % Masse volumique [kg/m^3]

  % Excitation: corde pincee d'une hauteur H en s=el
  H=L/5;          % Hauteur [m]
  el=L/4;         % poistion [m]

  % Domaine modal
  Nw=nmax;

  Aff = 'n';

  % pour produire du son
  rho_air = 1.204; %A 20 degré celsius
  c_son = 344;

  %Cas violon
  omega = 1e+5;

end

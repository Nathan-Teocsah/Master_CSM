function [A,C,N0,Def]=ParamInter(R,L,ro,E,Note)

  A=pi*R^2;       % Aire [m^2]
  % Tension : corde accordee sur le la-440
  C=2*L*Note;     % Celerite [m/s]
  N0=ro*A*C^2;    % Tension [N]
  Def=N0/(E*A);   % Deformation [~]

end


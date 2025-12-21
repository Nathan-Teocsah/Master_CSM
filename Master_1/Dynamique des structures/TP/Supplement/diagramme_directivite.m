rep = input('Voulez vous afficher le diagramme de directivité ? (o/n) ','s');

if (rep=='o')

  milieu = L/2;
  Rayon = milieu + 10000*L;
  Rayon_proche = milieu + L;
  n_point = 200;

  %% CHAMP LOINTAIN
  Micro =  [];
  phi = [];

  for k=0:1:(n_point-1)
    Point = [Rayon*cos(2*pi*k/n_point)+milieu, Rayon*sin(2*pi*k/n_point)];

    [Angle,~,~] = cart2sph(Point(1) - milieu, Point(2), 0);
    Micro = [Micro; Point];
    phi = [phi Angle];
  end

  %% CHAMP PROCHE
  Micro_proche =  [];
  phi_proche = [];
  for k=0:1:(n_point-1)
    Point = [Rayon_proche*cos(2*pi*k/n_point)+milieu, Rayon_proche*sin(2*pi*k/n_point)];
    [Angle,~,~] = cart2sph(Point(1) - milieu, Point(2), 0);
    Micro_proche = [Micro_proche; Point];
    phi_proche = [phi_proche Angle];
  end



%------------------------------------------------------------------------------------------------------------
%----------------------------CALCUL Champ "lointain"------------------------------------------------------
  decibel = [];
  ps = 20;
  pt = 200;
  progression = 'n'; %%N'affiche pas la profression des calculs de la pression sonore

  if (rI=='p')
    for k=1:1:n_point
      disp('-----------------------------------------------------------------------------------------------');
      disp(['(Champ lointain) POINTS ANALYSES = ', num2str(100*(k-1)/n_point), ' %']);
      [p,tp] = pression(Micro(k,:),rho_air,c_son,A,wn,an,bn,Y,s,t,ps,pt,progression);
      p_rms = rms(p);
      deci = 20*log(p_rms/(2*10^(-5)));
      decibel = [decibel deci];
    end
  else
    for k=1:1:n_point
      disp('-----------------------------------------------------------------------------------------------');
      disp(['(Champ lointain) POINTS ANALYSES = ',num2str(100*(k-1)/n_point),' %']);
      [p,tp] = pression_violon(Micro(k,:),rho_air,c_son,A,wn,Y,u,s,t,ps,pt,progression);
      p_rms = rms(p);
      deci = 20*log(p_rms/(2*10^(-5)));
      decibel = [decibel deci];
    end
  end
  disp(' ');
  disp(' ');
  disp(' ');


%------------------------------------------------------------------------------------------------------------
%----------------------------CALCUL Champ "proche"------------------------------------------------------

  decibel_proche = [];
  ps = 20;
  pt = 200;
  if (rI=='p')
    for k=1:1:n_point
      disp('-----------------------------------------------------------------------------------------------');
      disp(['(Champ proche) POINTS ANALYSES = ', num2str(100*(k-1)/n_point), ' %']);
      [p,tp] = pression(Micro_proche(k,:),rho_air,c_son,A,wn,an,bn,Y,s,t,ps,pt,progression);
      p_rms = rms(p);
      deci = 20*log(p_rms/(2*10^(-5)));
      decibel_proche = [decibel_proche deci];
    end
  else
    for k=1:1:n_point
      disp('-----------------------------------------------------------------------------------------------');
      disp(['(Champ proche) POINTS ANALYSES = ',num2str(100*(k-1)/n_point),' %']);
      [p,tp] = pression_violon(Micro_proche(k,:),rho_air,c_son,A,wn,Y,u,s,t,ps,pt,progression);
      p_rms = rms(p);
      deci = 20*log(p_rms/(2*10^(-5)));
      decibel_proche = [decibel_proche deci];
    end
  end

  figure(7);
  polar(phi,decibel);
  title('Diagramme de rayonnement en champ lointain');

  figure(8);
  polar(phi_proche,decibel_proche);
  title('Diagramme de rayonnement en champ proche');
end

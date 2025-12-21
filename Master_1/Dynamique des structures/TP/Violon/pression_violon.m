function [p,tp] = pression_violon(P_micro,rho_air,c_son,A,wn,Y,u,s,t,ps,pt,progression) %si ps = 1 on prend tous les s et t, si pas = 2, on prend un pas sur 2
% Calcul de la pression acoustique pour le modele violon

  %% Sous-echantillonnage spatial
  sp = zeros(1,floor(length(s)/ps));
  for jp = 1:length(sp)
      j = jp*ps;
      sp(jp) = s(j);
  end

  %% Sous-echantillonnage temporel
  tp = zeros(1,floor(length(t)/pt));
  for jp = 1:length(tp)
      j = jp*pt;
      tp(jp) = t(j);
  end

  %% Coordonnees spheriques
  theta = zeros(1,length(sp));
  r = zeros(1,length(sp));
  for j = 1:length(sp)
      [theta(j),~,r(j)] = cart2sph(P_micro(1)-sp(j), P_micro(2), 0);
  end

  Yp = zeros(length(wn),length(sp));
  for kp = 1:length(sp)
      k = kp*ps;
      Yp(:,kp) = Y(:,k);
  end

  up = zeros(length(sp),length(tp));
  for kp=1:1:length(sp)
    k = kp*ps;
    for jp=1:1:length(tp)
      j = jp*pt;
      up(kp,jp) = u(k,j);
    end
  end

  %calcul de la pression sonore effectuée par un élément dx de la corde

  pn = zeros(length(wn),length(tp),length(sp));
  coeff_1 = rho_air * sqrt(A/pi) / (4*pi*c_son);

  if (progression=='o')
    disp('Calcul de la pression sonore linéique');
  end
  denominateur = length(wn)*length(tp)*length(r);
  etape = 0;

  for m=1:1:length(r)
    du = gradient(up(m,:),tp);
    for l=1:1:length(tp)
      for k=1:1:length(wn)
        etape = etape + 1;

        km = wn(k)/c_son;
        expo = exp(-i*km*r(m));
        dephasage = 1 - i/(km*r(m));
        amplitude = abs(Yp(k,m));

        pn(k,l,m) = coeff_1 * amplitude * (wn(k))^2 * du(l) * real(expo * dephasage * cos(theta(m)) / r(m));
      end
    end
    if (progression=='o')
      disp(['Calcul en cours... ',num2str(100*etape/denominateur),' pourcent']);
    end
  end

  %Intégration
  if (progression=='o')
    disp('Intégration');
  end

  I = zeros(1,length(tp));
  denominateur = length(wn)*length(tp)*(length(sp)-1);
  etape = 0;

  for l=1:1:length(tp)
    for k=1:1:length(wn)
      In = 0;
      for m=1:1:(length(sp)-1)
        etape = etape + 1;
        In = In + (pn(k,l,m+1)-pn(k,l,m)).*sp(m);
      end
      I(l) = I(l) + In;
    end

    if (progression=='o')
      disp(['Intégration en cours... ',num2str(100*etape/denominateur),' pourcent']);
    end
  end

  p = I;

end

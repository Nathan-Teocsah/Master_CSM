%%------------------------------------------------------------------------------------------------
%% Questions

 disp(' ');
  disp('Donner la position du micro');
  disp(['La corde est situé entre x = 0 et x =',num2str(L),' en y = 0']);
  disp(' ');
  P_micro(1) = input('x = ');
  while (1)
    P_micro(2) = input('y = ');
    if (P_micro(2)!=0)
      break
    end
    disp('y doit être différent de 0.');
  end

  duree_son = 1.2;
  disp(' ');
  rep = input('Durée pour le son (en s.) : ');
  if (~isempty(rep))
    duree_son = rep;
  end

  rep = input('Voulez vous afficher le graphique de la pression acoustique p(t) ? (o/n) ','s');

%%------------------------------------------------------------------------------------------------
  progression = 'o'; %% Affiche la progression des calculs de la pression sonore
  if (rI=='p')
    [p,tp] = pression(P_micro,rho_air,c_son,A,wn,an,bn,Y,s,t,ps,pt,progression);
  else
    [p,tp] = pression_violon(P_micro,rho_air,c_son,A,wn,Y,u,s,t,ps,pt,progression);
  end

  if (rep=='o')
    figure(6);
    plot(tp,p);
    xlabel('t [s]'); ylabel('p(t) [N/m²]');
  end

  N = floor(duree_son/max(tp));
  tpp = zeros(1,length(tp)*N);
  for k=1:1:length(tp)
    tpp(k) = tp(k);
  end

  for j=2:1:N
    for k=1:1:length(tp)
      tpp((j-1)*length(tp)+k)=tp(k)+tpp((j-1)*length(tp));
    end
  end

  b = repmat(p,1,N);
  T = duree_son/(length(tpp)-1);
  Fs = 1/T;
  l = tpp(length(tpp));
  t0 = l/2;
  tau = 0.1*l;
  gaussian = exp(-((tpp-t0)/tau).^2);

  Niveau_sonore = 0.15/max(b);
  sound(gaussian.*(Niveau_sonore*b),Fs);


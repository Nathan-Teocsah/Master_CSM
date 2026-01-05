%% ============================================================================
%% INITIALISATION =========================================================
addpath('./Fct');
addpath('./Initialisation');
addpath('./Mode');
addpath('./Supplement');
addpath('./Violon');

%% ============================================================================
%% Choix de l'instrument =========================================================

disp(' ');
rep = input('Voulez vous composer un morceau ? (o/n) ','s');
disp(' ');

if (rep=='o')

  disp('Violon = v et Guitare = g');
  while (1)
    rI = input('De quelle instrument voulez vous jouer ? ','s');
    if ((rI=='v')||(rI=='g'))
      break
    end
    disp('Les réponses acceptables sont v ou g');
  end


  %% Choix des conditions aux limites
  validBC = {'DD','NN','DN','ND'};

  disp(' ');
  while true
      typeBC = upper(strtrim(input("Choisissez le type de C.L. ('DD' = instrument 'normal','NN','DN','ND') : ",'s')));
      if ismember(typeBC, validBC)
          break
      end
      disp("Réponse invalide. Les choix possibles sont : DD, NN, DN, ND.");
  end


  %% ========================================================================
  % Chargement des parametres

  nmax=50;        % Nombre maximal de mode considere
  Note_I =   [261.626  293.665   329.628    349.228   391.995   440    493.883];       % Note à partir du do de l'octave "3" : https://fr.wikipedia.org/wiki/Fr%C3%A9quences_des_touches_du_piano
  Nom_note = ['do';   're';        'mi';      'fa';    'sol';   'la';     'si';  'S'];
  NP=1;           % Nombre de période (pour la plus grande des périodes, ie. le mode avec la plus petite fréquence) que l'on veut représenter
  P_micro = [1 1]; %Position du micro
  ps = 10; %Echantillonage de s pour permettre de calculer rapidement une intégrale sur [0,L]
  pt = 20; %Echantillonage de t
  %length(t) est toujours égal à  NP*20*nmax+1 quelque soit la note choisie

  Pt = zeros(length(Note_I), floor((NP*20*nmax+1)/pt)); %length(tp)=floor(length(t)/pt)
  Pp = zeros(length(Note_I), floor((NP*20*nmax+1)/pt));

  [L,R,E,ro,H,el,Nw,Aff,rho_air,c_son,omega]=ParamInit(nmax);
  for k=1:1:length(Note_I)
    Note = Note_I(k);
    disp(' ');
    disp(['Calcul du son de la note : ',Nom_note(k,:)]);
    disp('---------------------------------------------');

    % Parametres intermediaires
    [A,C,N0,Def]=ParamInter(R,L,ro,E,Note);

    % Domaine modal
    [n,kn,wn,Lamb,Per,Freq] = DomaineModal(L, C, nmax, typeBC);

    % Domaine spatial
    [s,Ns,ds]=DomaineSpatial(L,Lamb);

    % Domaine temporel
    [dt,t,Nt,tmax]=DomaineTemporel(Per,L,NP);

    %% ========================================================================
    %% ANALYSE MODALE =========================================================

    if (rI=='g')
      % Modes propres
      Y = ModePropre(kn, s, Nw, Aff, typeBC);

      % Amplitude modale
      [an, bn] = AmplitudeModale(Y, s, wn, L, el, H, Aff);

      % Fonction en temps
      T = FctTemporelle(wn, an, bn, t, Aff);

      % Deplacement
      u=FctDeplacement(Y, T);
    else
      % Modes propres
      Y=ModesPropresViolon(kn, s, Nw, Aff, nmax);

      % Fonction en temps
      q = FonctionTemporelleViolon(s, t, kn, wn, L, A, el, ro, omega, Aff);

      % Deplacement
      u=FctDeplacementViolon(Y,q);

    end
    progression = 'o'; %% Affiche la progression des calculs de la pression sonore
    if (rI=='g')
      [p,tp] = pression(P_micro, rho_air, c_son, A, wn, an, bn, Y, s, t, ps, pt, progression);
    else
      [p,tp] = pression_violon(P_micro, rho_air, c_son, A, wn, Y, u, s, t, ps, pt, progression);
    end
    Pt(k,:) = tp;
    Pp(k,:) = p;
  end













  %% ================= Composer la partition ===================

  rejouer='n';
  while (1)
    disp(' ');
    tempo = input('Saisisez le tempo (nb de notes/min): ');

    duree_noir = 60/tempo;
    Duree = [duree_noir/4; duree_noir/2; duree_noir; 2*duree_noir; 4*duree_noir];
    Nom_duree = ['d'; 'c'; 'n'; 'b'; 'r'];

    if (rejouer=='n');
      rep = input('Voulez vous jouer autre choses que des noirs ? (o/n) ','s');
    end

    %%====================== PAS SEULEMENT DES NOIRES =============================
    if (rep=='o')
      if (rejouer=='n')

        Partition = [];
        rythme = [];
        k = 1;

        disp("Et indiquer les notes que vous voulez jouer en indiquant la note (do re mi fa sol la si) et les silences par (S).");
        disp("Indiquer les notes que vous voulez jouer en indiquant la note puis si c'est : une double croche (d), croche (c), noire (n), blanche (b) ou une ronde (r).");
        disp(' ');
        disp('Fin de partition = appuyer sur ENTRER');

        while (1)
          Note_tapee = input(['Note ',num2str(k),' : '],'s');

          if any(strcmp(Note_tapee, cellstr(Nom_note)))
            break
          end

          disp('Mauvaise saisie.');
        end
        Partition = [Note_tapee];
        while (1)

          rythme_tapee = input(['rythme ',num2str(k),' : '],'s');

          if any(strcmp(rythme_tapee, cellstr(Nom_duree)))
            break
          end

          disp('Mauvaise saisie');
        end

        rythme = [rythme_tapee];
        disp(' ');
        partition(Partition,rythme,Nom_note,rep);
        k = k + 1;

        disp(' ');

        while (1)
          while (1)
            Note_tapee = input(['Note ',num2str(k),' : '],'s');

            if (any(strcmp(Note_tapee, cellstr(Nom_note)))||(length(Note_tapee)==0))
              break
            end

            disp('Mauvaise saisie.');
          end
          if (length(Note_tapee)==0)
            break
          end

          while (1)
            rythme_tapee = input(['rythme ',num2str(k),' : '],'s');

            if (any(strcmp(rythme_tapee, cellstr(Nom_duree)))||(length(rythme_tapee)==0))
              break
            end

            disp('Mauvaise saisie');
          end

          if (length(rythme_tapee)==0)
            break
          end

          Partition = [Partition; Note_tapee];
          rythme = [rythme; rythme_tapee];

          disp(' ');

          partition(Partition,rythme,Nom_note,rep);
          k = k+1;
          disp(' ');
        end
      end

      %%=================== ON JOUE LE MORCEAU ===================
      disp(' ');
      disp('Début du morceau');

      for k=1:1:length(Partition(:,1))
        note_jouee = strtrim(Partition(k,:));
        rythme_joue = rythme(k,:);

        numero_note=1;
        while (1)
          if strcmp(note_jouee,strtrim(Nom_note(numero_note,:)))
            break
          end
          numero_note = numero_note + 1;
        end

        numero_rythme=1;
        while (1)
          if strcmp(rythme_joue,strtrim(Nom_duree(numero_rythme,:)))
            break
          end
          numero_rythme = numero_rythme + 1;
        end

        duree_note = Duree(numero_rythme);

        if ~strcmp(note_jouee,'S') %Si ce n'est pas un silence que l'on va jouer
          p = Pp(numero_note,:);
          tp = Pt(numero_note,:);

          N = floor(duree_note/max(tp));
          tpp = zeros(1,length(tp)*N);
          for k1=1:1:length(tp)
            tpp(k1) = tp(k1);
          end

          for j=2:1:N
            for k1=1:1:length(tp)
              tpp((j-1)*length(tp)+k1)=tp(k1)+tpp((j-1)*length(tp));
            end
          end

          son_note = repmat(p,1,N);

          T = duree_note/(length(tp)*N-1);
          Fs = 1/T;
          l = tpp(length(tpp));
          t0 = l/3;
          tau = 0.6*l;
          gaussian = exp(-((tpp-t0)/tau).^2);

          disp(note_jouee);

          Niveau_sonore = 0.15/max(son_note);
          sound(gaussian.*(Niveau_sonore*son_note),Fs);

        else %Si c'est un silece que l'on doit jouer
          disp('S');
          pause(duree_note);
        end
      end



    %%====================== QUE DES NOIRS =============================
    else
      if (rejouer=='n')
        k = 1;
        disp("Et indiquer les notes que vous voulez jouer en indiquant la note (do re mi fa sol la si) et les silences par (S).");
        disp(' ');
        disp('Fin de partition = appuyer sur ENTRER');

        while (1)
          Note_tapee = input(['Note ',num2str(k),' : '],'s');
          if any(strcmp(Note_tapee, cellstr(Nom_note)))
            break
          end
          disp('Mauvaise saisie.');
        end

        Partition = [Note_tapee];
        partition(Partition,[' '],Nom_note,rep);
        k = k + 1;

        while (1)
          while (1)
            Note_tapee = input(['Note ',num2str(k),' : '],'s');
            if (any(strcmp(Note_tapee, cellstr(Nom_note)))||(length(Note_tapee)==0))
              break
            end
            disp('Mauvaise saisie.');
          end
          if (length(Note_tapee)==0)
            break
          end
          Partition = [Partition; Note_tapee];
          partition(Partition,['n'],Nom_note,rep); %% ON affiche la partition que pour des noirs
        end
      end


      %%=================== ON JOUE LE MORCEAU (que des noirs) ===================

      disp(' ');
      disp('Début du morceau');
      for k=1:1:length(Partition(:,1))
        note_jouee = strtrim(Partition(k,:));

        numero_note=1;
        while (1)
          if strcmp(note_jouee,strtrim(Nom_note(numero_note,:)))
            break
          end
          numero_note = numero_note + 1;
        end

        if ~strcmp(note_jouee,'S') %Si ce n'est pas un silence que l'on va jouer
          p = Pp(numero_note,:);
          tp = Pt(numero_note,:);


          T = 1/Fs; %pas entre 2 temps
          N = floor(duree_noir/max(tp));

          tpp = zeros(1,length(tp)*N);
          for k1=1:1:length(tp)
            tpp(k1) = tp(k1);
          end

          for j=2:1:N
            for k1=1:1:length(tp)
              tpp((j-1)*length(tp)+k1)=tp(k1)+tpp((j-1)*length(tp));
            end
          end

          son_note = repmat(p,1,N);

          T = duree_noir/(length(tp)*N-1);
          Fs = 1/T ;
          l = tpp(length(tpp));
          t0 = l/3;
          tau = 0.6*l;
          gaussian = exp(-((tpp-t0)/tau).^2);

          disp(note_jouee);

          Niveau_sonore = 0.15/max(son_note);
          sound(gaussian.*(Niveau_sonore*son_note),Fs);
        else % Si c'est un silence
          disp('S');
          pause(duree_noir);
        end
      end
    end


    continuer = input('Voulez vous continuer à jouer de la musique ? (o/n) ','s');
    if (continuer=='n')
      break
    end
    rejouer = input('Voulez vous rejouer la même partition ? (o/n) ','s');
  end
end

function partition(Partition,Rythme,Nom_note,rep)
  C0 = [' '; '-'];
  for k=1:1:4
    C0 = [C0; ' '];
    C0 = [C0; '-'];
  end
  C0 = [C0; ' '; ' '];
  tab = [C0];

  D0 = [' '; '-'];
  for k=1:1:4
    D0 = [D0; ' '];
    D0 = [D0; '-'];
  end
  D0 = [D0; ' '; '-'];

  %% RECUPERATION DE LA NOTE
  note_jouee_avant = ' ';
  numero_note_avant = 0;
  for k=1:1:length(Partition(:,1))
    if (rep=='o')
      rythme_jouee = strtrim(Rythme(k,:));
    else
      rythme_jouee = ' ';
    end
    note_jouee = strtrim(Partition(k,:));
    numero_note = 1;
    while (1)
      if strcmp(note_jouee,strtrim(Nom_note(numero_note,:)))
        break
      end
      numero_note = numero_note + 1;
    end

    %% ECRITURE DE LA NOTE
    numero_note = 13-numero_note;
    C = [rythme_jouee; '-'];
    for m=3:1:length(C0)
      if ((m==numero_note)||((m==numero_note_avant)&&strcmp(note_jouee_avant,'do')));
        if (strcmp(note_jouee,'S')&&(~(m==numero_note_avant)))
          C = [C; 'S'];
        else
          if (strcmp(note_jouee_avant,'do')&&(m==numero_note_avant))
            C = [C; ' '];
          else
            if strcmp(note_jouee,'do')
              tab(12,length(tab)) = '-';
              C = [C; 'O'];
            else
              C = [C; 'O'];
            end
          end
        end
      else
        C = [C; C0(m,:)];
      end
    end
    if strcmp(note_jouee,'do')
      tab = [tab C D0 C0];
    else
      tab = [tab C C0 C0];
    end


    note_jouee_avant = note_jouee;
    numero_note_avant = numero_note;
  end

  tab = [tab C0 C0 C0];

  %% AFFICHAGE
  for m=1:1:length(C0)
    disp(tab(m,:));
  end
end






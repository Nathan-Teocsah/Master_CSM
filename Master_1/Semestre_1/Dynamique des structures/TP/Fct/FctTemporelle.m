function T = FctTemporelle(wn, an, bn, t, Aff)
  nmax = length(wn);
  Nt = length(t);
  T = zeros(nmax, Nt);

  for n = 1:nmax
      w = wn(n);
      if w > 1e-10
          % Cas oscillant classique
          T(n,:) = an(n)*cos(w*t) + (bn(n)/w)*sin(w*t);
      else
          % Cas mode rigide (w=0) : mouvement rectiligne uniforme
          % Limite de sin(wt)/w -> t
          T(n,:) = an(n) + bn(n)*t;
      end
  end

  if (Aff=='o')
    figure('Name','Reponses Temporelles');
    indices = unique([1, 2, 3, nmax]);
    plot(t, T(indices, :), 'LineWidth', 2)
    xlabel('t [s]')
    legend(arrayfun(@(x) sprintf('n=%d',x), indices, 'UniformOutput', false));
    set(gca,'FontSize',14);
    grid on;
  end
end

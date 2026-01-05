function T = FctTemporelle(w, wn, an, bn, t, Aff, c)
  nmax = length(wn);
  T    = zeros(nmax, length(t));

  %on prend c = 0 si c n'est pas donnée
  if nargin < 7
      c = 0;
  end

  % facteur d'amortissement e^{-c t}
  damp = exp(-c * t);   % 1 x Nt

  for in = 1:nmax
      % solution "oscillante" sans amortissement
      T_free = an(in)*cos(wn(in)*t) + (bn(in)/wn(in))*sin(wn(in)*t);

      % ajout de l'amortissement : e^{-c t} * oscillation
      T(in,:) = damp .* T_free;
  end

  if (Aff == 1)
    figure(3);
    plot(t, T([1:3 nmax],:), 'LineWidth', 2)
    xlabel('t [s]')
    legend('n=1','n=2','n=3','n=nmax')
    set(gca, 'FontSize', 24)
  end
end

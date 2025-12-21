function [an, bn] = AmplitudeModale(Y, s, wn, L, el, H, Aff)
% Calcul des amplitudes par projection numerique
% Cela marche pour TOUTES les conditions aux limites

    % 1. Construction de la deformee initiale u0(s) (Triangle)
    u0 = zeros(size(s));
    % Partie gauche (0 a el)
    idx_g = s <= el;
    u0(idx_g) = H * s(idx_g) / el;
    % Partie droite (el a L)
    idx_d = s > el;
    u0(idx_d) = H * (L - s(idx_d)) / (L - el);

    % 2. Projection modale numerique
    Nw = size(Y, 1);
    an = zeros(Nw, 1);
    bn = zeros(Nw, 1); % Vitesse nulle

    for n = 1:Nw
        Mode = Y(n, :);

        % Produit scalaire <u0, Yn>
        Projection = trapz(s, u0 .* Mode);

        % Norme au carre ||Yn||^2
        NormeCarre = trapz(s, Mode.^2);

        an(n) = Projection / NormeCarre;
    end

    if (Aff=='o')
      figure('Name','Spectre Amplitudes');
      stem(wn, abs(an), 'LineWidth', 2);
      xlabel('\omega_n [rad/s]'); ylabel('|a_n| [m]');
      title('Amplitudes modales');
      set(gca,'FontSize',14);
      grid on;
    end
end

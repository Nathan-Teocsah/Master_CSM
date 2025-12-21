function Y = ModePropre(kn, s, Nw, Aff, typeBC)
% MODEPROPRE Generes les formes modales Y(s) selon les C.L.

    Ns = length(s);
    Y = zeros(Nw, Ns);

    switch typeBC
        case 'DD'
            % Sinus (0 en 0)
            Y = sin(kn .* s);

        case 'NN'
            % Cosinus (Pente nulle en 0).
            % Note: cos(0*s) = 1 gÃ¨re automatiquement le mode rigide.
            Y = cos(kn .* s);

        case 'DN'
            % Fixe en 0 -> Sinus
            Y = sin(kn .* s);

        case 'ND'
            % Libre en 0 -> Cosinus
            Y = cos(kn .* s);
    end

    if (Aff=='o')
        figure('Name','Modes Propres');
        % Affiche les 3 premiers et le dernier
        indices = unique([1, 2, 3, Nw]);
        plot(s, Y(indices, :), 'LineWidth', 2);
        xlabel('s [m]'); ylabel('Y_n(s)');
        legend(arrayfun(@(x) sprintf('n=%d',x), indices, 'UniformOutput', false));
        title(['Modes propres - Type ' typeBC]);
        set(gca,'FontSize',14);
        grid on;
    end
end

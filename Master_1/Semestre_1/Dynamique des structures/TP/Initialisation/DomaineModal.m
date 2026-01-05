function [n, kn, wn, Lamb, Per, Freq] = DomaineModal(L, C, nmax, typeBC)

    n = (1:nmax)';
    switch typeBC
        case 'DD' % Fixe-Fixe
            % kn = n*pi/L, n=1,2...
            kn = n * pi / L;

        case 'NN' % Libre-Libre (Mode rigide Ã  n=0)
            % kn = n*pi/L, n=0,1...
            kn = n * pi / L;

        case {'DN', 'ND'} % Mixte
            % kn = (2n-1)*pi/(2L), n=1,2...
            kn = (2*n - 1) * pi / (2 * L);

        otherwise
            error('Type de C.L. inconnu');
    end

    wn = C * kn;

    % Gestion des divisions par zero pour le mode rigide (wn=0)
    Lamb = zeros(size(kn));
    Per = zeros(size(kn));
    Freq = zeros(size(kn));

    idx = (kn > 1e-10); % Indices non nuls
    Lamb(idx) = 2 * pi ./ kn(idx);
    Per(idx) = 2 * pi ./ wn(idx);
    Freq(idx) = 1 ./ Per(idx);
end

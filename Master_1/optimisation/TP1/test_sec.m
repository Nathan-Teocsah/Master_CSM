function [xs, neval] = test_sec(fonction, num, a, b, tol, gamma)
%---------------------------------------------------------------
%  [xs, neval] = secdor(fonction, num, a, b, tol, gamma)
%
%  Recherche du minimum d'une fonction unimodale sur [a,b]
%  par la méthode de la section dorée.
%
%  Entrées :
%     - fonction : handle vers la fonction à minimiser (ex: @fonc)
%     - num      : numéro de la fonction test (passé à fonction)
%     - a, b     : bornes de l'intervalle de recherche
%     - tol      : tolérance sur la largeur de l'intervalle
%     - gamma    : paramètre dans (0, 1/2)
%
%  Sorties :
%     - xs       : approximation du minimum
%     - neval    : nombre d'évaluations de la fonction f
%
%  Exemple d'appel :
%     [xs, neval] = secdor(@fonc, 3, 0, 3, 1e-5, (3 - sqrt(5)) / 2);
%
%---------------------------------------------------------------

    % Vérification basique des paramètres
    if gamma <= 0 || gamma >= 0.5
        error('Le paramètre gamma doit être dans l''intervalle ]0, 0.5[.');
    end

    % Calcul du rapport delta = gamma / (1 - gamma)
    delta = gamma / (1 - gamma);

    % Calcul initial des deux points intérieurs
    alpha = a + gamma * (b - a);
    beta  = a + (1 - gamma) * (b - a);

    % Évaluation initiale des deux points
    f1 = fonction(num, alpha);
    f2 = fonction(num, beta);
    neval = 0;  % compteur du nombre d'évaluations de f

    % Boucle principale
    while max(abs(beta - a), abs(b - alpha)) > tol

        if f1 <= f2
            % Le minimum est dans [a, beta]
            b = beta;
            beta = alpha;
            f2 = f1;
            alpha = a + delta * (beta - a);
            f1 = fonction(num, alpha);
        else
            % Le minimum est dans [alpha, b]
            a = alpha;
            alpha = beta;
            f1 = f2;
            beta = b + delta * (alpha - b);
            f2 = fonction(num, beta);
        end

        neval = neval + 1;
    end

    % Approximation finale du minimum
    if f1 < f2
        xs = alpha;
    else
        xs = beta;
    end
end


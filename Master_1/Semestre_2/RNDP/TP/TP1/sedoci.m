function u=sedoci(x,alpha,dalpha,beta,gamma,f,ci)
    %Calcule une approximation de la solution de l'équation différentielle
    % -(alpha u'(x))' + beta(x) u'(x) + gamma(x)u(x) = f(x) sur [a;b]
    % avec les conditions aux limites ci = [u(a); u'(a)] (vecteur colonne)
    %par la méthode d'Euler
    %Paramètre d'entrée :
    % x : vecteur ligne contenant les noeuds de discrétisation de l'intervalle [a, b]
    % alpha, beta, gamma : fonctions coefficients de l'edo
    %f : scond membre de l'edo
    %dalpha : dérivée de la fonction alpha
    %u : solution calculée aux noeuds de discrétisation

    %On transforme le problème en une EDO d'ordre 1
    A = @(x) [0, 1; gamma(x)/alpha(x), (beta(x)-dalpha(x))/alpha(x)];
    b = @(x) [0; -f(x)/alpha(x)];

    if length(ci(:,1)) ~= 2 %Vérification que ci est un vecteur colonne
        ci = ci.transpose();
    end
    U = ci; %Initialisation de la solution

    
    % U' = A(x)U + b(x) : U(x_i+1) = U(x_i) + U'(x_i)*(x_i+1-x_i)
    for i=1:length(x)-1
        U(:,end+1) = U(:,end) + (A(x(i))*U(:,end) + b(x(i)))*(x(i+1)-x(i));
    end
    u = U(1,:); %On ne garde que la première composante de 
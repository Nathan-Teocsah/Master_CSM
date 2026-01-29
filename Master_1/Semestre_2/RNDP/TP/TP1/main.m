a = 0;
b = 2*pi;
alpha = @(x) 1;
beta = @(x) -2.*x;
gamma = @(x) 1;
f = @(x) (x.^2 + 1).*sin(x)/pi;
dalpha = @(x) 0;
ua = 0; ub = 1;

x = linspace(a,b,100);

ci = @(lambda) [ua; lambda]; %Conditions aux limites paramétrées par lambda
function y = phi(lambda)
    y = sedoci(x,alpha,dalpha,beta,gamma,f,ci(lambda)); % phi = u_lambda(b) - u_b ==== on va chercher un zéro de cette fonction pour trouver une solution
    y = y(end) - ub;
end

%===== Méthode de tir =====%
lambda_km1 = 0; %Initialisation de lambda_0
lambda_k = 1; %Initialisation de lambda_1

dif_k = lambda_k-lambda_km1;
dif_phi = phi(lambda_k)-phi(lambda_km1);
dif_k = -phi(lambda_k)*dif_k/dif_phi;
lambda_kp1 = lambda_k + dif_k;

%== Paramètre d'arrêt de l'algo ==%
tol = 1e-5; %Tolérance pour la convergence
max_iter = 1000; %Nombre maximum d'itérations
iter = 1;


while (iter < max_iter) && (abs(dif_k) > tol)
    iter += 1;
    lambda_km1 = lambda_k;
    lambda_k = lambda_kp1;

    dif_k = lambda_k-lambda_km1;
    dif_phi = phi(lambda_k)-phi(lambda_km1);
    dif_k = -phi(lambda_k)*dif_k/dif_phi;
    lambda_kp1 = lambda_k + dif_k;
    if (iter >= max_iter)
        disp("Nombre maximum d'itérations atteint");
    end
end

lambda_sol = (lambda_kp1+lambda_k)/2;

disp(phi(lambda_sol)) %Doit être proche de 0

figure(1)
plot(x,sedoci(x,alpha,dalpha,beta,gamma,f,ci(lambda_sol)));
pause()
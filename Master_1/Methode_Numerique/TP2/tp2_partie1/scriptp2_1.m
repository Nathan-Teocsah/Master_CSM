% Tp2
% Partie 1 - 1) : Test de la methode de dichotomie
disp('---> Partie 1 - 1) Dichotomie')
a=0; b=2; rex=sqrt(3); disp('Fonction h(x) :');disp(' ');
for eps=[1e-2, 1e-7, 1e-14]
	[r,nit]=dichotomie(@h,a,b,eps);
	disp(sprintf('eps: %6.3g, approx: %18.16f, erreur: %e, nit= %d\n', eps,r,abs(rex-r), nit))
end
a=0; b=2; rex=pi/2; disp(sprintf('Fonction cos(x) :\n'));
for eps=[1e-2, 1e-7, 1e-14]
	[r,nit]=dichotomie(@cos,a,b,eps);
	disp(sprintf('eps: %6.3g, approx: %18.16f, erreur: %e, nit= %d\n', eps,r,abs(rex-r), nit))
end

% Partie 1 - 2) - Recherche de point fixe
disp('---> Partie 1 - 2) Recherche de point fixe')
x0=2; r3=sqrt(3); format long;
disp('g1 :   xk                 Erreur               Ordre');
N=20; xk = iter(@g1,x0,N); ord=log(abs(xk(2:N+1)-r3)) ./ log(abs(xk(1:N)-r3)); ord = [0 ord]; [xk' abs(xk'-r3) ord']
disp('g2 :   xk                 Erreur               Ordre');
N=5; xk = iter(@g2,x0,N); ord=log(abs(xk(2:N+1)-r3)+1e-16) ./ log(abs(xk(1:N)-r3)+1e-16); ord = [0 ord]; [xk' abs(xk'-r3) ord']
disp('g3 :   xk                 Erreur               Ordre');
N=5; xk = iter(@g3,x0,N); ord=log(abs(xk(2:N+1)-r3)+1e-16) ./ log(abs(xk(1:N)-r3)+1e-16); ord = [0 ord]; [xk' abs(xk'-r3) ord']

% Partie 1 - 3) - Methode de Newton
disp('---> Partie 1 - 3) Recherche de point fixe');disp(' ')
epsilon=1e-10; Nmax=100;
disp('    x0         racine           Niter');disp(' ')
for x0=0.9:0.1:2
  [r,nit]=newton(@h2,@h2p,x0,epsilon,Nmax);
  disp(sprintf(' %6.3g   %20.16f   %d\n',x0,r,nit))
end

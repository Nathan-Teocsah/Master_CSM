function [A,F]=syslin(gamma,f,u_0,u_1,J)
% Construction du système linéaire issu de la discrétisation du problème
% aux limites de Dirichlet
% -u’’(x) + gamma(x) u(x) = f(x) pour tout x dans ]0,1[
% u(0)=u_0
% u(1)=u_1
% par un schéma aux différences finies basé sur une approximation de la
% dérivée seconde par une différence divisée centrée d’ordre 2.
% L’intervalle [0,1] est subdivisé en J sous-intervalles.

h = 1/J;
x = h:h:1-h;
M = [-ones(J-1,1) 2*ones(J-1,1) -ones(J-1,1)];
M(:,2) = M(:,2) + h^2*gamma(x)';
A = spdiags(M, [-1 0 1], J-1, J-1);
F = h^2*f(x)' + [u_0; zeros(J-3, 1); u_1];
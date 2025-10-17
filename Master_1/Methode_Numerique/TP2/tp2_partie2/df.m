function [J]=df(x)
% Jacobienne de la fonction f(x) = [(1-x(1))*(2-x(2)); -1+(x(1)*x(2))^2]
J=[x(2)-2, x(1)-1; 2*x(1)*x(2)^2, 2*x(1)^2*x(2)];
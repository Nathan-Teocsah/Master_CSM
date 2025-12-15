function y = fp(x)
  % Ligne 1
  y(1,1) = x(2) - 1;
  y(1,2) = x(1) - 1/2;

  %ligne 2
  y(2,1) = x(2)^2 - 1/4;
  y(2,2) = 2*x(1)*x(2) - 2*x(2);
end

function y = f(t,x)
  %% y' = f(t,y)
  global a b p q;
  y = [(a-b*x(2))*x(1); (-p+q*x(1))*x(2)];

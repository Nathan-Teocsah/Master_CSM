function p = lagrangePM(f,x,k)
  %Interpolation sur les [xi, xi+1] de degré k
  n = length(x);
  for i=1:(n-1)
    y = linspace(x(i),x(i+1),k+1);
    p(i,:) = polyfit(y,f(y),k);
  end


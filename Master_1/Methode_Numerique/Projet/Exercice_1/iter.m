function xk = iter(f,x0,N)
  xk = [x0];
  for i=1:N
    xk = [xk; f(xk(i))];
  end
end

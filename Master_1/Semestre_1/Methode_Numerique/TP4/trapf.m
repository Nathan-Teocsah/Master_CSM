function T = trapf(a,b,n,f)
  T = 0;
  h = (b-a)/n;
  for i=1:1:(n-1)
    x = a + i*h;
    T += f(x);
  end
  T = h*((f(a)+f(b))/2+T);


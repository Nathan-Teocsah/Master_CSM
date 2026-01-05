function R = rectf(a,b,n,f)
  R = 0;
  h = (b-a)/n;
  for i=1:1:n
    x = a + i*h;
    R += f(x);
  end
  R = h*R;

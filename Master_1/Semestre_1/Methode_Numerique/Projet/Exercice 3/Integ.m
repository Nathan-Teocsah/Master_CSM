function I = Integ(f,x,nbP)
  %%x = Les points (il y en a n)
  %nbP (=1 si Trapèzes ou =2 si Simpson)
  %%f fonction à intégré
  I = 0;
  n = length(x);

  for i=1:(n-1)
    xp = linspace(x(i),x(i+1),nbP+1);
    if nbP==1
      X = xp(2)-xp(1);
      F = (f(xp(2)) + f(xp(1)))/2;
      I += X * F;
    elseif nbP==2
      X = (xp(3)-xp(1))/6;
      F = f(xp(1)) + 4*f(xp(2)) + f(xp(3));
      I += X * F;
    end
  end


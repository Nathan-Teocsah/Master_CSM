function [tt,y]=metimp(t0,tf,n,y0,f,tol,nitmax)
  %% Intégration implicite
  h = (tf-t0)/n;
  tt = linspace(t0,tf,n+1);
  y = zeros(n+1,length(y0));
  y(1,:) = y0; %% y(t) en t(1) = t0

  for i=1:n
    y(i+1,:)= fixe(f,tt(i),h,y(i,:),tol,nitmax);
  end



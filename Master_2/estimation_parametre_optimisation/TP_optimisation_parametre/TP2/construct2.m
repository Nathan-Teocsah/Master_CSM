function [AA,bb,A,b]=construct2(n)
  v=[1:n]; c=diag(1./v);
  v = 3*v.^2;
  b = ones(n,1);
  w = ones(n-1,n);
  A = diag(v) + diag(w,1)+diag(w,-1);
  AA = c*A*c;
  bb = c*b;
end

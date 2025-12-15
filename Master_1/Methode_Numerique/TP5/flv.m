function np = flv(t,x)
  global a b p q ;
  np=[(a-b*x(2))*x(1) ; (-p+q*x(1))*x(2)] ;

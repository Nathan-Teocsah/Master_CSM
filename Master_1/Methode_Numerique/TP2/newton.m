function [r,nbit]=newton(f,fp,x0,eps,Nmax)

  fx=f(x0) ;
  xk=x0
  nbit=0

  while (abs(fx) > eps) & (nbit < Nmax)
    ++nbit
    xk=xk-f(xk)/fp(xk);
  end

  r = xk
end

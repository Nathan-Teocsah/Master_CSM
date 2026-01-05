function [r,nbit]=newton_rd(f,Jf,x0,eps,Nmax)
  xk=x0;
  xkp1=xk-Jf(xk)\f(xk);
  nbit=0;
  while (norm(xkp1-xk)>eps)&(nbit<Nmax)
    ++nbit;
    xkp1=xk-Jf(xk)\f(xk);
  end
  r=(xkp1+xk)./2
 end


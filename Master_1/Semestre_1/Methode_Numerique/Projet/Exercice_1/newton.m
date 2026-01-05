function [r,nbit]=newton(f,fp,x0,eps,Nmax)

  echec = -Nmax/2;

  xk=x0;
  J = fp(xk);
  if (rcond(J)<1e-15),
      nbit=echec;
      r = x0;
      return
   end
  nbit=1;
  xp1 = xk - fp(xk)\f(xk);

  while (norm(xp1-xk) > eps) && (nbit < Nmax)
    ++nbit;
    xk = xp1;
    J = fp(xk);
    if (rcond(J)<1e-15),
      nbit=echec;
      break
    end
    xp1 = xk - fp(xk)\f(xk);
  end

  r = xp1;
end

function [xs,neval]=secdor(fonction,num,a,b,tol,gamma)
  delta = gamma./(1-gamma);
  alpha = a + gamma*(b-a);
  beta = a + (1-gamma)*(b-a);
  f1 = fonction(num,alpha);
  f2 = fonction(num,beta);
  neval = 2

  while (max(abs(beta-a),abs(b-alpha))>tol)

      if (f1<=f2)
        b = beta;
        beta = alpha;
        alpha = a+delta*(beta-a);
        f2 = f1;
        f1 = fonction(num,alpha)

      else
        a = alpha;
        alpha = beta;
        beta = b + delta*(alpha-b);
        f1=f2;
        f2=fonction(num,beta);
      end
      neval = neval+1;
  end

  if f1<=f2
    xs = (a+beta)/2;
  else
    xs = (alpha+b)/2
  end
end


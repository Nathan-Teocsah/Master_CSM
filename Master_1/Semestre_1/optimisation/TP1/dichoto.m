function [xs,neval]=dichoto(fonction,num,a,b,tol)
	neval = 0;

  if (abs(b-a)>2*tol)
    gamma = (a+b)/2;
		fg = fonction(num,gamma);
    neval = neval+1

    while (abs(b-a)>2*tol)

      fag = fonction(num,(a+gamma)/2);
      fbg = fonction(num,(b+gamma)/2)

      neval=neval+2;

      if (fag < fg)
        b = gamma;
        fg = fag;
        gamma = (a+b)/2;
      elseif (fbg < fg)
        a = gamma;
        fg = fbg;
        gamma = (a+b)/2;
      else
        a=(a+gamma)/2, b=(b+gamma)/2;
      end
    end

    fb = fonction(num,b);
    fa = fonction(num,a)

    neval=neval+2

    if fg < fb
       if fg < fa
         xs = gamma;
       else
         xs = a;
       end
    else
       if fb < fa
         xs = b;
       else
         xs = a;
       end
    end

  else %si a et b sont déjà suffisament proche il y a juste à renvoyer la valeur correspondante.
    xs = (a+b)/2;
  end
end





function [xs,neval]=dichoto(fonction,num,a,b,tol)
	neval = 0;

  figure
  a0 = a;
  b0 = b;

  if (abs(b-a)>2*tol)
    gamma = (a+b)/2;
		fg = fonction(num,gamma);
    neval = neval+3;


    while (abs(b-a)>2*tol)
      xmin = max(a0, min(2*a-b, a-0.5*10^(-3))); %les bornes sont ajustées de sorte à ce que la fenêtre s'ajuste "comme il faut"
      xmax = min(b0, max(2*b-a, b+0.5*10^(-3)));
      pas = max(2*10^(-7), (b-a)/1000);
      x = xmin:pas:xmax;

      plot(x,fonction(num,x));
      title(['dichotomie : num =' num2str(num),'     , tol = ', num2str(tol),'        et Neval = ', num2str(neval)]);  %Afficher sur le graphique les informations neval et la tolérance choisie
      hold on
      plot(a,0,'r*'); %Affiche le graphique de manière dynamique, montrant l'évolution des points qui encadrent le minimum
      plot(b,0,'b*');
      hold off

      fag = fonction(num,(a+gamma)/2);
      fbg = fonction(num,(b+gamma)/2)

      neval=neval+2;

      if (fag < fg)
        b = gamma;
        fg = fag;
        gamma = (a+b)/2
      elseif (fbg < fg)
        a = gamma;
        fg = fbg;
        gamma = (a+b)/2
      else
        a=(a+gamma)/2, b=(b+gamma)/2;
      end
      pause(0.1);
    end

    fb = fonction(num,b);
    fa = fonction(num,a)

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
    xs = (a+b)/2
  end

end





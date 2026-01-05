function [xs,neval]=secdor(fonction,num,a,b,tol,gamma)
  delta = gamma./(1-gamma);
  alpha = a + gamma*(b-a);
  beta = a + (1-gamma)*(b-a);
  f1 = fonction(num,alpha);
  f2 = fonction(num,beta);
  neval = 2

  figure
  a0 = a;
  b0 = b;
  while (max(abs(beta-a),abs(b-alpha))>tol)

      xmin = max(a0, min(2*a-b, a-0.5*10^(-3))); %les bornes sont ajustées de sorte à ce que la fenêtre s'ajuste "comme il faut"
      xmax = min(b0, max(2*b-a, b+0.5*10^(-3)));
      pas = max(2*10^(-7), (b-a)/1000);
      x = xmin:pas:xmax;

      plot(x,fonction(num,x));
      title(['secdor : num =' num2str(num),'     , tol = ', num2str(tol),'        et Neval = ', num2str(neval)]);  %Afficher sur le graphique les informations neval et la tolérance choisie
      hold on


      if (f1<=f2)
        plot(a,0,'r*'); %Affiche le graphique de manière dynamique, montrant l'évolution des points qui encadrent le minimum
        plot(beta,0,'b*');
        hold off

        b = beta;
        beta = alpha;
        alpha = a+delta*(beta-a);
        f2 = f1;
        f1 = fonction(num,alpha)

      else
        plot(alpha,0,'r*'); %Affiche le graphique de manière dynamique, montrant l'évolution des points qui encadrent le minimum
        plot(b,0,'b*');
        hold off

        a = alpha;
        alpha = beta;
        beta = b + delta*(alpha-b);
        f1=f2;
        f2=fonction(num,beta);
      end
      neval = neval+1;
      pause(0.1)
  end

  if f1<=f2
    xs = (a+beta)/2;
  else
    xs = (alpha+b)/2
  end
end


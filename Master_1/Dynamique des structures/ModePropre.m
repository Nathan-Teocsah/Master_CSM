function Y=ModePropre(kn,s,Nw,Aff)
  % Modes propres
  for in=1:Nw
      % Y_ij, avec i=>n et j=>s
      Y(in,:)=sin(kn(in)*s);
  end

  if (Aff==1)
    %=> visualisation de quelques modes propres
    figure(1);
    plot(s,Y([1:3 nmax],:),'LineWidth',2)
    xlabel('s [m]')
    legend('n=1','n=2','n=3','n=nmax')
    set(gca,'FontSize',24)
  end
end

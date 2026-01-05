function afficher_resultat(u,iter,itermax,nbevalinfmin)
  global numex

  disp(['Pour l''exemple numero ',int2str(numex)])
  disp(blanks(2)')
  disp(['le minimum trouve est : ']),u

  disp(['la fonctionnelle en ce point vaut : ',num2str(J(u))])
  disp(['||grad J(u*)|| =  ',num2str(norm(GJ(u),2))])
  if (iter < itermax)
    disp(['le nb d''iterations de boucle effectuees est : ',num2str(iter)])
  else
    disp(['le nb d''iterations maximum (',num2str(iter),') a ete atteint'])
  end

  if (nbevalinfmin!=0)
    disp(['le nb d''iterations total pour calculer le minimum est : ',num2str(nbevalinfmin)])
  end
  disp(blanks(2)')
end

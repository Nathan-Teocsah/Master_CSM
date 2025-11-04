function vitergc(u,Tabuk,Tabguk,iter,itermax)
%
% Permet dans le cas de la dimension 2 de visualiser les iterations de
% l''algorithme du gradient conjugue.
% On affiche : - la direction de descente  (en trait plein)
%              - la direction du gradient (en pointille)
%
%
% variables entree:
% u       = solution obtenue  argmin J(v)
% Tabuk   = tableau contenant la suite (u_k) des points intermediaires
%           u_k = (Tabuk(1,k),Tabuk(2,k))
% Tabguk  = tableau contenant la suite des gradients aux points intermediaires
% iter    = nb d''iterations effectuees
% itermax = nb max d''iterations autorisees




global isov   % tableau des isovaleurs retournees par la fonction visiso.m
global numex  % numero de l''exemple traite

lg = 1;       % longueur de la fleche du gradient
eps0=0.05;

hold on
plot(Tabuk(1,:),Tabuk(2,:),'ko')  % suite des points
hold on
plot(Tabuk(1,:),Tabuk(2,:),'k-')  % directions de descente
hold on
%
% affichage des directions du gradient
%
for k=1:iter
  gk = [Tabguk(1,k) , Tabguk(2,k)];
  uk = [Tabuk(1,k) , Tabuk(2,k) ];
  vk = uk + lg*gk./norm(gk,2);
  hold on
  plot([uk(1) vk(1)], [uk(2) vk(2)] ,'k-.')
end


text(u(1),u(2),['  u* =  (',num2str(u(1)),' , ', num2str(u(2)), ')'])
xlabel(['nb d''it?rations = ',num2str(iter), ...
        '        ||grad J(u*)|| =  ',num2str(norm(GJ(u),2)), ...
        '          J(u*) =  ',num2str(J(u))])
rep = input ('Voulez-vous afficher les isovaleurs (o/n) : ','s');
if rep=='o'
  clabel(isov,'labelspacing', 300);
end

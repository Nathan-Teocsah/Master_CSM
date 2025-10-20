function  visiso(xmin, xmax, ymin, ymax)
%
% affiche les isovaleurs pour la fonctionelle de numero numex
% [ xmin, xmax, ymin, ymax] = fenetre graphique
%
global numex    % numero de l'exemple traite
global isov

nbiso=80;       % nb d'isovaleurs
pas=0.1;        % pas entre deux points

x=xmin:pas:xmax;
y=ymin:pas:ymax;

for ix=1:length(x)
for iy=1:length(y)
 Z(iy,ix) = J([x(ix) , y(iy)]');
end
end

pcolor(x,y,Z)
shading interp
hold on
isov=contour(x,y,Z,nbiso);
grid
title(['fonction num?ro ',num2str(numex)])


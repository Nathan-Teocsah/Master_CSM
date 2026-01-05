% debitriv.m
% Calcul du debit d'une riviere.
%       1- Calcul de la vitesse moyenne a une distance x du bord par
%          la methode des trapezes, a partir de mesures ponctuelles donnees
%          dans un tableau
%       2- Calcul du debit par la methode de Simpson.
%
ty=[0, 0.2, 0.4, 0.6, 0.8, 1];
tf=[0.28, 0.23, 0.19, 0.17, 0.13, 0.02];
disp('1- La vitesse moyenne est :');
disp(trapt(ty,6,tf));

tx=[0, 3, 6, 9, 12, 15, 18, 21, 24];
th=[0, 0.51, 0.73, 1.61, 2.11, 2.02, 1.53, 0.64, 0];
tv=[0, 0.09, 0.18, 0.21, 0.36, 0.32, 0.19, 0.11, 0];
thv=th.*tv;
disp('2- Le debit est (simpson puis trapezes):');
disp(simpsont(tx,9,thv));
disp(trapt(tx,9,thv));

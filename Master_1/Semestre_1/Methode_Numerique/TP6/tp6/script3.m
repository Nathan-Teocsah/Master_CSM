% TP6 - script 3
% Resolution de systemes lineaires par decomposition LU
% en supposant que la matrice du systeme admet une telle factorisation
% Comparaison resolution pour matrice tridiagonale et pleine
disp('TP6 - Script 3')
n=4;
% Factorisation LU
disp('2.3) Comparaison stockages plein et creux :')
tplein=[];
tcreux=[];
i=0;tnp=[16,32,64,128,256,512,1024,2048]; 
ntnp=length(tnp);

format short e;

disp('        n       Plein      Creux');
for n=tnp
    i=i+1;
    A=mata(n);
    b=ones(n,1);
    tic; x=resyslinLU(A,b); tplein(i)=toc;
    tic; x=resyslinLUtridiag(A,b); tcreux(i)=toc;
    disp([n,tplein(i),tcreux(i)]);
end

figure(1)
plot(tnp,tplein,'-or',tnp,tcreux,'-xb');
legend('Stockage plein','Stockage creux');
xlabel('n');ylabel('Temps [s]'); title('Temps de resolution d un systeme lineaire par decomposition LU');
figure(2)
plot(log10(tnp),log10(tplein),'-or',log10(tnp),log10(tcreux),'-xb');
legend('Stockage plein','Stockage creux');
xlabel('log_{10}(n)');ylabel('log_{10}(Temps) [s]'); title('Temps de resolution d un systeme lineaire par decomposition LU');

pp=polyfit(log10(tnp(2:ntnp)),log10(tplein(2:ntnp)),1); disp(sprintf('LU stockage plein - ordre de la complexite : %10.3e',pp(1)));
pc=polyfit(log10(tnp(2:ntnp)),log10(tcreux(2:ntnp)),1); disp(sprintf('LU stockage creux - ordre de la complexite : %10.3e',pc(1)));


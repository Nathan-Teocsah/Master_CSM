clear all, close all;
fid = fopen("resultat.txt", "r");
data = textscan(fid, "%f %f", "HeaderLines", 1);
fclose(fid);

n      = data{2}(1:end-1);
Erreur = data{1}(2:end);

pas = abs(Erreur(2:end)-Erreur(1:end-1));
pas = max(pas)/3;

plot(n, Erreur, 'o-');
xticks(5:50:705);
yticks(0:pas:max(Erreur));

yticks = get(gca, 'ytick');           % récupérer les ticks actuels
yticklabels = arrayfun(@(v) sprintf('%.2e', v), yticks, 'UniformOutput', false);
set(gca, 'yticklabel', yticklabels);

xlabel('Taille de la matrice A');
ylabel('Erreur relative');
grid on;


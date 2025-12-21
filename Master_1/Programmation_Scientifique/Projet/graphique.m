clear all;
close all;

% Lecture des données
fid = fopen("resultat.txt", "r");
data = textscan(fid, "%f %f", "HeaderLines", 1);
fclose(fid);

n      = data{2}(1:end-1);
Erreur = data{1}(2:end);
logE   = log(Erreur);

%% ===== FIGURE 1 : log(Erreur) + régression =====

p = polyfit(n(2:end), logE(2:end), 1);
y = polyval(p, n);

figure(1);
hold on;
plot(n, logE, 'o-');
plot(n, y, 'LineWidth', 1.5);

r = logE - y;
R2 = 1 - norm(r)^2 / norm(logE - mean(logE))^2;

pas = abs(logE(2:end) - logE(1:end-1));
pas = max(pas) / 3;

set(gca, "xtick", 5:50:705);
set(gca, "ytick", min(logE):pas:max(logE)+5*pas);

xlabel('Taille de la matrice A');
ylabel("logarithme de l'erreur relative");
text(mean(n), mean(logE), sprintf("R^2 = %.4f", R2));
grid on;
hold off;


%% ===== FIGURE 2 : Erreur brute =====

figure(2);
plot(n, Erreur, 'o-');

pas = abs(Erreur(2:end) - Erreur(1:end-1));
pas = max(pas) / 3;

set(gca, "xtick", 5:50:705);

yticks_vals = min(Erreur):pas:max(Erreur)+5*pas;
set(gca, "ytick", yticks_vals);

% Format scientifique manuel (Octave-compatible)
ytick_labels = cell(size(yticks_vals));
for k = 1:length(yticks_vals)
    ytick_labels{k} = sprintf('%.2e', yticks_vals(k));
end
set(gca, "yticklabel", ytick_labels);

xlabel('Taille de la matrice A');
ylabel('Erreur relative');
grid on;

logE = logE(2:end);
n = n(2:end)
%% ===== FIGURE 3 : log(Erreur) + régression =====

p = polyfit(n(2:end), logE(2:end), 1);
y = polyval(p, n);

figure(3);
hold on;
plot(n, logE, 'o-');
plot(n, y, 'LineWidth', 1.5);

r = logE - y;
R2 = 1 - norm(r)^2 / norm(logE - mean(logE))^2;

pas = abs(logE(2:end) - logE(1:end-1));
pas = max(pas) / 3;

set(gca, "xtick", 5:50:705);
set(gca, "ytick", min(logE):pas:max(logE)+5*pas);

xlabel('Taille de la matrice A');
ylabel("logarithme de l'erreur relative");
text(mean(n), mean(logE), sprintf("R^2 = %.4f", R2));
grid on;
hold off;



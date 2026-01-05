% Effacer la figure précédente
clf;

% Définir les valeurs de x1 pour le tracé
x1 = linspace(0, 8, 1000);

% Tracer les contraintes
y1 = 0 * x1 + 6; % x1 <= 6
y2 = (15 - x1)/2; % x1 + 2x2 <= 15
y3 = (39 + 4*x1)/10; % -4x1 + 10x2 <= 39
y4 = (3 + 4*x1)/2; % -4x1 + 2x2 <= 3

% Remplir le domaine admissible (approximation)
% On trace les contraintes et on remplit "manuellement" la zone admissible
fill([0 0 3.375 6 6], [0 1.5 5.8125 4.5 0], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'k');
hold on;

% Tracer les contraintes
plot(x1, y1, 'r', 'LineWidth', 1.5);
plot(x1, y2, 'g', 'LineWidth', 1.5);
plot(x1, y3, 'b', 'LineWidth', 1.5);
plot(x1, y4, 'm', 'LineWidth', 1.5);

% Limites et labels
xlim([0 8]);
ylim([0 8]);
xlabel('x1');
ylabel('x2');
title('Domaine admissible');
grid on;
hold off;







% Créer une grille pour x1 et x2
[x1_grid, x2_grid] = meshgrid(linspace(0, 8, 100), linspace(0, 8, 100));

% Calculer la fonction objectif J1(x) = x1 - 4x2
J1 = x1_grid - 4 * x2_grid;

% Tracer les lignes de niveau avec contour
figure;
contour(x1_grid, x2_grid, J1, -20:2:20);
hold on;

% Tracer le domaine admissible
x1 = linspace(0, 8, 1000);
y1 = 0 * x1 + 6;
y2 = (15 - x1)/2;
y3 = (39 + 4*x1)/10;
y4 = (3 + 4*x1)/2;

fill([0 0 3.375 6 6], [0 1.5 5.8125 4.5 0], 'g', 'FaceAlpha', 0.3, 'EdgeColor', 'k');

% Tracer les contraintes
plot(x1, y1, 'r', 'LineWidth', 1.5);
plot(x1, y2, 'g', 'LineWidth', 1.5);
plot(x1, y3, 'b', 'LineWidth', 1.5);
plot(x1, y4, 'm', 'LineWidth', 1.5);

% Limites et labels
xlim([0 8]);
ylim([0 8]);
xlabel('x1');
ylabel('x2');
title('Lignes de niveau de J1(x) = x1 - 4x2 (Octave)');
colorbar;
hold off;


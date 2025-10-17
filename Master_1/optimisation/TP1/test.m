x = 1:21;
y = (1:21) + 0.2*randn(1,21);
yfit = x;
err = ones(1,21);
hold on;
h(1) = errorbar(x(1:11),y(1:11),err(1:11),'o', 'LineWidth', 2, 'MarkerFaceColor','g','Color','g');
h(2) = errorbar(x(12:end),y(12:end),err(12:end),'o', 'LineWidth', 2, 'MarkerFaceColor','b','Color','b');
h(3) = plot(x, yfit, '-r','LineWidth', 2);
legend(h,{'Loading','Unloading','Regression'},'location','northwest')
box on

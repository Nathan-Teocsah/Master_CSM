nb_pt_esp=10000;


CFL = 0.49;

k = input('Conductivite thermique k = ');
rho = input('Masse volumique rho = ');
cp = input('Capacite calorifique cp = ');

hx = 1/nb_pt_esp;;
alpha = k/(rho*cp);
ht = CFL * hx^2/alpha;
nb_pt_temp = round(1/ht);
disp(['Le point de temps = ', num2str(nb_pt_temp)]);

U = zeros(nb_pt_esp,nb_pt_temp);


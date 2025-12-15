clear, close all;

N = [32, 64, 128, 256, 512]; %% Nombre de points
n = 32;
k = 3; %% Degré du polynôme d'interpolation par morceau

for n=N
  x = linspace(-5,5,n); %% Point d'interpolation
  p = lagrangePM(@f,x,k);

  nbP = 5; %% Nb de points en lesquels on découpe chaque sous-intervalle
  [Nx,y] = lagrangeEval(nbP,x,p);

  figure(n)
  plot(Nx,y);
  title(["Interpolation de f pour n = ",num2str(n)]);
end

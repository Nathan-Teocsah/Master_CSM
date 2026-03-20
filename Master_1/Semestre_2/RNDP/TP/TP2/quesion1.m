f = @(x) sin(pi*x);
u = @(x) 1/pi^2 * sin(pi*x);

N = 25;
h = 1/N;

A = zeros(N-1,N-1);
F = zeros(N-1,1);

F(1) = f(0);
A(1,[1,2])=[2,-1];
for i = 2:N-2
    A(i,[i-1,i,i+1])=[-1,2,-1];
    F(i) = f(i*h);
end
A(N-1,[N-2,N-1])=[-1,2];
F(N-1) = f((N-1)*h);
A = 1/h^2 *A;

U = A\F;
U = [u(0); U; u(1)];
T = linspace(0,1,N+1);
figure()
plot(T,U)
hold on
plot(T,u(T))
legend('solution approchée','solution exacte')
title('Comparaison des solutions')
hold off

U1 = choltrd(A,F);
U1 = [u(0), U1, u(1)];

for i=1:length(U)
    U1(i)-U(i)
end

figure()
plot(T,U1)
hold on
plot(T,u(T))
legend('solution approchée','solution exacte')
title('Comparaison des solutions avec choltrd')
hold off


pause;
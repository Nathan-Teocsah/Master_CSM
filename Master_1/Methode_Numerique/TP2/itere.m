N = 5
x = 1.5

for i=1:1:6
  y = x;
  x = g(x);
  printf("vitesse = %f\n",(abs(x-sqrt(8))/abs(y-sqrt(8))^4));
end
disp(x)

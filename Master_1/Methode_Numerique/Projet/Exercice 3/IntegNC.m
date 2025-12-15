function I = IntegNC(f,x,l)
  %% Intégration composée, avec la méthode de Newton-Cotes
  %% L = nombre de points entre a_i et a_i+1 (max 5, min 1)

  omega = zeros(10,11);
  omega(1,1:2) = [1/2 1/2];
  omega(2,1:3) = [1/6 1/6 2/3];
  omega(3,1:4) = [1/8 3/8 3/8 1/8];
  omega(4,1:5) = [7/90 16/45 2/15 16/45 7/90];
  omega(5,1:6) = [19/188 75/288 50/288 50/288 75/288 19/288];

  n = length(x);
  I = 0;
  for i=1:(n-1)
    a = x(i);
    b = x(i+1);
    D = b - a;
    h = (b-a)/l;

    I_loc = 0;
    for j=1:(l+1)
      I_loc += omega(l,j)*f(a + (j-1)* h);
    end
    I += D*I_loc;
  end

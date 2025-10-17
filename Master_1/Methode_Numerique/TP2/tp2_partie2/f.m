function [y]=f(x)

n=length(x);
if(n~=2) 
    disp('*** --> Fonction f : n différent de 2');
end
y=[(1-x(1))*(2-x(2)); -1+(x(1)*x(2))^2];

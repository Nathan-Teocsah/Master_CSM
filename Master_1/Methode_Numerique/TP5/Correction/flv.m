% Methodes numeriques - TP 5 - flv.m
function lr = flv(t,x)
% 
global a b p q;
lr=[(a-b*x(2))*x(1); (-p+q*x(1))*x(2)];

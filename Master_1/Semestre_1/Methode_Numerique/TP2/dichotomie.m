function [r,nbit]=dichotomie(f,a,b,eps)
   nbit=0;

   while (abs(b-a)>eps)
     ++nbit;
     m=(a+b)/2
     fm=f(m);

     if fm*f(a) < 0
       b=m
     else
       a=m
     end
   end

   r = nbit
end
sdf



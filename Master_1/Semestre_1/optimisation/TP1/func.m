function f = func(num,x)
  N = length(num),nx=length(x);
  f=zeros(N,nx);
  for i=1:1:N
    switch (num(i))
      case {1}
        f(i,:) = (x-1).^2 ;

      case {2}
        for j=1:1:nx
          if (x(j) <= 1)
            f(i,j) = (x(j)-1).^2+2 ;
          elseif (1<x(j)&&x(j)<=2)
            f(i,j) = 1-x(j)./2 ;
          else
            f(i,j) = 0.5+(x(j)-2).^2 ;
          end
        end

      case {3}
        f(i,:) = abs(x-1).*(1.1-sin(6.*x)) ;

      case {4}
        f(i,:) = x.^2 ;

      case {5}
        f(i,:) = (x-3).^2 ;

    end
  end
end

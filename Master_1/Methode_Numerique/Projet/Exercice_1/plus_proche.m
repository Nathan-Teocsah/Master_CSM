function [xi,yj]=plus_proche(r,x,y)
  r1 = r(1);
  r2 = r(2);
  if ismember(r1,x)&&ismember(r2,y)
    xi = r1;
    yj = r2;
    return
  end

  n=length(x);
  m = length(y);

  i = 1;
  Min = abs(r1-x(i));
  for k=1:n
    a = abs(r1-x(k));
    if a<Min
      Min = a;
      i = k;
    end
    if Min==0
      break
    end
  end
  xi = x(i);

  j = 1;
  Min = abs(r2-y(j));
  for k=1:m
    a = abs(r2-y(k));
    if a<Min
      Min = a;
      j = k;
    end
    if Min==0
      break
    end
  end
  yj = y(j);

end

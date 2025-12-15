function T = periode(y,t,prec)
  h = 1;
  while t(h)-t(1) < prec
    h = h+1;
  end

  indice = [];
  i = 1;
  while  i <= length(t)-2*h
    if y(i) < y(i+h) && y(i+h) > y(i+2*h)
      indice = [indice i+h];
    end
    i = i+h;
  end

  t_max = t(indice);
  per = diff(t_max); %% les différentes périodes
  T = floor(mean(per)/prec)*prec;

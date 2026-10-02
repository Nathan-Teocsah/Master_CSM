function [x,err,it,Vector,temps]=GMO(A,b,x0,Tol,itmax)
% initialisation
    it=0; x=x0; g=A*x-b; err = norm(g);
    Vector = [err];
    temps = cputime();
    while (err > Tol) && (it < itmax)
        rho = g'*g/(g'*A*g);
        x = x-rho*g;
        g=A*x-b; err = norm(g); it = it+1;
        Vector = [Vector; err];
    end
    temps = cputime()-temps;
end

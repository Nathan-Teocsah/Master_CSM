function [x,err,it,Vector,temps]=CGM(A,b,x0,Tol,itmax)
% initialisation
    it=0; x=x0; g=A*x-b; err = norm(g);
    d = -g;
    Vector = [err];
    temps = cputime();
    while (err > Tol) && (it < itmax)
        rho = (g'*g)/(d'*A*d);
        x = x+rho*d;
        err0 = err;
        g = A*x-b;
        err = norm(g);
        Vector = [Vector;err];
        beta = err^2/err0^2;
        d = -g+beta*d;
        it = it+1;
    end
    temps = cputime()-temps;
end

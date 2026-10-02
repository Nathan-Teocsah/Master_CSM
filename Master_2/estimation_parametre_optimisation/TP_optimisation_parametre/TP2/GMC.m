function [x,err,it,Vector,temps]=GMC(A,b,x0,rho,Tol,itmax)
% initialisation
    it=0; x=x0; g=A*x-b; err = norm(g);
    Vector = [err];
    temps = cputime();
    while (err > Tol) && (it < itmax)
        x = x-rho*g;
        g=A*x-b; err = norm(g); it = it+1;
        Vector = [Vector; err];
    end
    temps = cputime()-temps;
end

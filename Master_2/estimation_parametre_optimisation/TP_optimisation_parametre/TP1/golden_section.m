function x,v=golden(f,a,b,Tol,itmax):
    it=0;
    p=(sqrt(5)-1)/2;
    c=b-p(b-a);
    d=a+p(b-a);
    fc = f(c);
    fd = f(d);
    nf = 2;
    while abs(c-d)>Tol && it < itmax:
        if fc < fd:
            b=d;
            d=c;
            fd=fc;
            c=b-p*(b-a);
            fc=f(c);
            nf = nf+1;
        else:
            a=c;
            c=d;
            fc=fd;
            d=a+p*(b-a);
            fd=f(d);
            nf=nf+1;
        it=it+1;
    end
    x=c;
    v=fc;
end




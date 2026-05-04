u_0=1;
u_1=-1;

uex=@(x)cos(pi*x);
J=50;

h = [];
err = [];
for J=10:10:1000
    [A,F]=syslin(@gamma,@f,u_0,u_1,J);
    h = [h 1/J];
    U = A\F;
    U = [u_0; U; u_1];
    x = 0:1/J:1;
    Uex = uex(x)';
    % calcul de l’erreur
    err = [err 100*norm(U-Uex)/norm(Uex)];
end

loglog(h,err,'x-'); 
xlabel('pas');
ylabel('erreur relative (%)');
pause;

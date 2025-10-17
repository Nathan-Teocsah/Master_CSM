% TP2 - Partie 2
% Script : coloriage du plan en fonction de la con vergence
%          de la methode de Newton pour resoudre f(x)=0 dans R^d.
%x1min=0.8;x1max=1.2;x2min=0;x2max=0.4;pas=0.001;
x1min=-1;x1max=2.5;x2min=-1.5;x2max=2.5;pas=0.001;
cs1=num2str([1;1]);cs2=num2str([1;-1]);cs3=num2str([0.5;2]);cs4=num2str([-0.5;2]);
x1=[x1min:pas:x1max];x2=[x2min:pas:x2max];n=length(x1);m=length(x2);c=zeros(m,n);
disp([n,m]);
nmax=7;eps=1e-7;
%warning off all;
for i=1:n
    disp(i);
    for j=1:m
        x0=[x1(i);x2(j)];
        [r,nbit]=newton2_rd(@f,@df,x0,eps,nmax);
        if (nbit<0)
            c(j,i)=0;
        else
            switch num2str(round(100*r)/100)
                case cs1
                    c(j,i)=1;
                case cs2
                    c(j,i)=2;
                case cs3
                    c(j,i)=3;
                case cs4
                    c(j,i)=4;
                otherwise
                    c(j,i)=0;
            end
        end
    end
end

%warning on all;
%pcolor(x1,x2,c);
contourf(x1,x2,c);

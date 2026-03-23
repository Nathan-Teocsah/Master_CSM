
%% Mono-atomic lattice

%% 0) Initialization & graphics 
clear all ; clc
set(0, 'DefaultAxesFontWeight', 'bold');
set(0, 'defaultAxesFontName','Times');
set(0,'DefaultLineLineWidth',2);
set(0,'defaultfigurecolor',[1 1 1]);
set(0, 'DefaultAxesBox', 'on');
set(0,'defaultAxesXGrid','on')
set(0,'defaultAxesYGrid','on')
set(0,'defaultaxesfontsize',12)

%% 1) Defining the model
a=1; % spatial periodicity
b=10000; % stifness of a coil string
gamma=0.05;
b=b*(1+gamma*1i); %On introduit une histérésis : Retard de l'effet sur la cause dans le comportement des corps soumis à une action physique.
m=1;
w0=2*sqrt(b/m);

samples=500; % number of samples (both freq or wavenumber)

%% 2) Given wavenumber resolution omega(k)

k_sample=linspace(-pi/a,pi/a,samples); % wavenumber samples
w=zeros(1,length(k_sample)); % initialize frequency solutions

for i=1:length(k_sample)
    k=k_sample(i);
    w(i)=w0*abs(sin(k*a/2));
end

% create new figure

figure; title('Mono-atomic \omega(k)');


plot(k_sample,w);

xlabel('Wavenumber')
xticks([-2*pi/a -pi/a 0 pi/a 2*pi/a])
xticklabels({'-^{2*\pi}/_a','-^\pi/_a','0','^\pi/_a','^{2*\pi}/_a'})

ylabel('Frequency')
yticks([0 w0 2*w0])
yticklabels({'0','\omega_0','2*\omega_0'})

%% 3.1) Real part-only of wavenumber

omega=linspace(1,400,samples);
k1=zeros(1,length(omega)); % initialize solutions
k2=zeros(1,length(omega));

for i=1:samples
    w=omega(i);
    k1(i)=2/a*asin(w/w0);
    k2(i)=-2/a*asin(w/w0);
end

% create new figure

figure; title('Mono-atomic k(\omega)')

plot(omega/w0,[k1 ; k2])

xlabel('Frequency')
xticks([0 1 2])
xticklabels({'0','\omega_0','2*\omega_0'})

ylabel('Wave number Re(k)')
yticks([-pi 0 pi])
yticklabels({'-^\pi/_a','0','^\pi/_a'})


%% 3.2) Complex wavenumbers

lb1=zeros(1,samples);
lb2=zeros(1,samples);

% compute complex propagation constants lb

for i=1:samples
    w=omega(i);
    lb1(i)=1-2*(w/w0)^2+2*1i*w/w0*sqrt(1-(w/w0)^2); %w < w0
    lb2(i)=1/lb1(i);
end


% retrieve wavenumber k from lb

k1=1./a*log(abs(lb1)); 
k2=1./a*log(abs(lb2));

% create new figure

figure; title('Mono-atomic k(\omega)')

plot(omega/w0,[k1 ; k2])

xlabel('Frequency')
xticks([0 1 2])
xticklabels({'0','\omega_0','400'})


ylabel('Wave number Im(k)')
yticks([-pi 0 pi])
%yticklabels({'-^\pi/_a','0','^\pi/_a'})

pause;
%% Bi-atomic lattice

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
a=1; % periodicity
b=1000;
m1=1.2; m2=0.7;
w1=sqrt(2*b/m1);
w2=sqrt(2*b/m2);
w3=sqrt(2*b*(1/m1+1/m2));

samples=500; % number of samples (both freq or wavenumber)


%% 2.1) Given wavenumber resolution 

k_range=linspace('____TO_FILL____');
wo=zeros('____TO_FILL____');
wa=zeros('____TO_FILL____');
for i=1:length(k_range)
    k=k_range(i);
    wo(i)=b*(1/m1+1/m2)-b*sqrt((1/m1+1/m2)^2-4/m1/m2*sin(k*a/2)^2);
    wa(i)='____TO_FILL____';
end

% create new figure
figure; title('Bi-atomic \omega(k)')

plot(k_range,'____TO_FILL____')

xlabel('Real wavenumber')
xticks([-2*pi/a -pi/a 0 pi/a 2*pi/a])
xticklabels('____TO_FILL____')

ylabel('Frequency')
yticks([0 w1 w2 w3])
yticklabels('____TO_FILL____')


%% 2.2) Let us try again with m1 = m2 (equiv mono-atomic with double period)

m_moy=(m1+m2)/2;
w_moy=sqrt(2*b/m_moy);

wo_mono=w_moy^2*(1-abs(cos(k_range*a/2))); % optic mode
wa_mono='____TO_FILL____'; % acoustic mode
hold on; plot(k_range,'____TO_FILL____','k--')


%% 3) Wavenumber as a function of Frequency

omega=linspace(1,80,samples);

Om1=(omega/w1).^2;
Om2=(omega/w2).^2;
Om3='____TO_FILL____';

% propagation constants analytical solutions (from lecture)
lb1='____TO_FILL____';
lb2='____TO_FILL____';

k1='____TO_FILL____';
k2='____TO_FILL____';

% create new figure
figure; title('Bi-atomic k(\omega)')

plot(omega,[k1 ; k2],'k.'); 
%hold on; plot(omega,[k1 ; k2]+2*pi/a,'k.')
%hold on; plot(omega,[k1 ; k2]-2*pi/a,'k.')

xlabel('Frequency')
xticks([0 w1 w2 w3])
xticklabels('____TO_FILL____')

ylabel('Real wavenumber Re(k)')
yticks([-pi/a 0 pi/a])
yticklabels('____TO_FILL____')

% To check, one can use expanded form 
newlb1=1/w1^2/w2^2*(2*omega.^4 - 2*omega.^2*w3^2 + w1^2*w2^2 + 2*omega.*sqrt((omega.^2-w1^2).*(omega.^2-w2^2).*(omega.^2-w3^2)));
newlb2=1/w1^2/w2^2*(2*omega.^4 - 2*omega.^2*w3^2 + w1^2*w2^2 - 2*omega.*sqrt((omega.^2-w1^2).*(omega.^2-w2^2).*(omega.^2-w3^2)));
newk1=1i*log(newlb1)/a; newk2=1i*log(newlb2)/a;
% figure; plot(omega,([newk1 ; newk2]))


%% Imaginary part :
figure; title('____TO_FILL____')

plot(omega,'____TO_FILL____')

xlabel('Frequency')
xticks([0 w1 w2 w3])
xticklabels({'0','\omega_1','\omega_2','\omega_3'})

ylabel('Imaginary wavenumber Im(k)')
yticks([-pi/a 0 pi/a])
yticklabels({'-^\pi/_a','0','^\pi/_a'})


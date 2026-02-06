%% Locally resonant lattice

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

b1=1000; 
b2=300;

m1=1; 
m2=0.5;

w1=sqrt(b1/m1);
w2=sqrt(b2/m2);
w3=sqrt(2*b1/m1);
r=b2/b1;

samples=500; 

%% 2) Given wavenumber resolution 

k_range=linspace(-2*pi/a, 2*pi/a,samples);
w=zeros(1,samples);
wpaper=zeros(length(k_range),2);

for i=1:length(k_range)
    k=k_range(i);
    c=cos(k*a);
    w1^2*(2*c-1)-r
    -2*w1^2 * w2^2 * (c-1)
    w(i,:)=roots([1 w1^2*(2*c-1)-r -2*w1^2 * w2^2 * (c-1)]);
end

% create new figure
figure; title('Locally resonant \omega(k)')

plot(k_range,w); 

xlabel('Wavenumber')
xticks([-2*pi/a -pi/a 0 pi/a 2*pi/a])
xticklabels({'-^{2*\pi}/_a','-^\pi/_a','0','^\pi/_a','^{2*\pi}/_a'})

pause;
% separate three cases for axis ticks
ylabel('Frequency')
if w2<2*w1
    yticks('____TO_FILL____')
    yticklabels({'0','\omega_2','2*\omega_1'})
elseif w2>2*w1
    yticks('____TO_FILL____')
    yticklabels({'0','2*\omega_1','\omega_2'})
else 
    yticks('____TO_FILL____')
    yticklabels({'0','2*\omega_1 = \omega_2'})
end



%% 3) Wavenumber as a function of Frequency

omega=linspace(1,80,samples);

Om1=(omega/w1).^2;
Om2=(omega/w2).^2;
Om3=(Om1-1).*(Om2-1);

% propagation constants analytical solutions (from lecture)
lb1= 1-Om1/2-r/2*Om2./(1-Om2) + 1/2*sqrt((Om1+r*Om2./(1-Om2)).*(Om1+r*Om2./(1-Om2)-4));
lb2= '____TO_FILL____';

k1='____TO_FILL____';
k2='____TO_FILL____';


figure; title('Locally resonant k(\omega)')

plot('____TO_FILL____','k.'); 
hold on; plot(omega,[k1 ; k2]+2*pi/a,'k.')
hold on; plot(omega,[k1 ; k2]-2*pi/a,'k.')

xlabel('____TO_FILL____')
xticks('____TO_FILL____')
xticklabels('____TO_FILL____')

ylabel('Real(k)')
yticks([-pi/a 0 pi/a])
yticklabels({'-^\pi/_a','0','^\pi/_a'})


%% Imaginary part :
figure; title('Locally resonant k(\omega)')

'____TO_FILL____'

'____TO_FILL____'
'____TO_FILL____'
'____TO_FILL____'

'____TO_FILL____'
'____TO_FILL____'
'____TO_FILL____'


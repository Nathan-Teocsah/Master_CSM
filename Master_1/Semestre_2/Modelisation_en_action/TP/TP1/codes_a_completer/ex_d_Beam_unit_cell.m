%% Beam elements lattice

%% 0) Initialization & graphics 
clear all ; clc
set('____TO_FILL____')

%% 1) Defining the model

a=0.1; % length of the beam element (period)

% Create a structure containing all physical parameters
beam_param=struct('nu',0.3,'rho',7800,'E',2e11,'b',1e-2,'h',1e-2,'L',a); % numerical values


% Generate M,K matrices for a beam element (call function 'ex_beam_element')
'____TO_FILL____'

% Define the left and right degrees of freedom (DOFs) for indexation
uL='____TO_FILL____'; 
uR='____TO_FILL____'; 

samples=500; 



%% 2) Given wavenumber resolution 

% Create tild function to retrieve M_tild and K_tild from M,K and
% wavenumber :

tld = @(k,X) '____TO_FILL____'

k_range='____TO_FILL____'

w_sol=zeros('____TO_FILL____');


for j=1:length(k_range) % we loop on frequency i=length(omegarange)
    
    k=k_range(j);

    K_tld = '____TO_FILL____';
    M_tld = '____TO_FILL____';
    
    w_pow2 = '____TO_FILL____' % (K_tld - w^2*M_tld)

    w_sol(:,j)=sqrt(w_pow2); % w_pow2 is only positive real

end


%% Plot results

figure; title('Beam element \omega(k)')

'____TO_FILL____'

%% 3) Given frequency resolution

omega=linspace(1,8e4,samples);
k_sol=zeros('____TO_FILL____');

for j=1:length(omega) % we loop on frequency i=length(omegarange)
    w=omega(j);

    '____TO_FILL____' 
    % DRL + (DL+DR)*lb + DLR*lb^2

    k_sol(:,j)=1i/a*log(lb);
end


%% Plot results

figure; title('Beam element k(\omega)')

'____TO_FILL____' % plot real(k_sol) with xlabel, yticks, yticklabels, ylabel

figure; title('Beam element k(\omega)')

plot(omega,imag(k_sol),'k.'); 

xlabel('Frequency')
ylabel('Wave decay Im(k)')

% zoom to highlight propagative waves' decays with 'ylim'
'____TO_FILL____'



%% Monte Carlo simulation of troponin activation. 

% + Each regulatory unit contains 7 actin subunits and one Tn-Tm assembly.
% + We have one strand of regulated actin consisting of RU regulatory units. 
% + Troponin activates when j or more myosin motors bind to the regulatory
% unit of the troponin 

%
% INPUTS:
%    constants 
%
% OUTPUTS:
%   d_bound - fractional activation of tropoinin
%   d_active - myosin saturation
%
% EXAMPLE: 
%    Edit constants then "Run"
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% Author: John M. Robinson MD, PhD
% email: john.robinson@myofilament.org
% Website: http://myofilament.org
% August 2015; Last revision: 28-August-2015

%------------- BEGIN CODE --------------

clear all;
RU = 500;
M = RU;
num_actin = 7*RU;

for j = 1:7 % j is the number of S1 needed to activate a regulatory unit
    for i = 1:M 
        N = floor(10*(i-1)^1.1);
        x = rand(N,1); % Uniform random numbers x from 0..1
        y = x*num_actin;
        z = floor(y/7); % is z counts over RU
        zu = unique(floor(y)); % can only have one S1 bound per actin
        frac_thrown = (N-length(zu))/N;
        frac_bound = length(zu)/num_actin;
        edges = 0:RU;
        h = histogram(z,edges);
        % h.Values;
        active = h.Values > (j-1); % are there at least j S1 bound in the RU?
        frac_active = sum(active)/RU; % number of troponin activated
        d_bound(i,j) = frac_bound;
        d_active(i,j) = frac_active;
    end
end
plot(d_bound,d_active,'o') % default coloring scheme
ylim([0,1.2])
hold on
line([0.143 0.143],[0 1.1]) % 1:7 marker
hold off
print('-depsc','overlay.eps')

% Extract the theta_50. 

% This is done by finding the root of theta_50 - 0.5. 
% Pick the root with Imaginary component = 0 and Real component between 0
% and 1

for i = 1:7
    i
    [fitresult, gof] = fit_titration(d_bound(:,i), d_active(:,i));
end

%------------- END OF CODE --------------







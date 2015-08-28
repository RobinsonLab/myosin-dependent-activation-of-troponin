%
% S1_AT = []
% paste data from excel
% save('S1_AT.mat','S1_AT')
%%
load('S1_AT.mat') % loads [S1]T/[Actin]T data 
AT = 1.75;
N = 1 % choose what you want to calculate

if (N == 1)
    % apo
    X0 = 0.8044*(AT/10);
    Kd = 1.006;
elseif (N == 2)
    %% +Ca
    X0 = 0.066*(AT/10);
    Kd = 1.16;
elseif (N == 3)
    %% PKA, apo
    X0 = 0.0;
    Kd = 0.15;
elseif (N == 4)
    %% PKA + Ca
    X0 = 0.0;
    Kd = 0.1521
end

S1T = S1_AT*AT;
% S1T = linspace(0,20,101);


pb = percent_binding(S1T,X0,AT,Kd);

plot(S1T/AT,pb);
xlabel('[S1]_T/[Actin]_T');
ylabel('% saturation');

% copy pb to excel or save, as desired
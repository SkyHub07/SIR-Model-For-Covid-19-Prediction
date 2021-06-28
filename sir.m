
clc;
clear all;
close all;
%%
%Reading data from .xls file
time = readtable('s_w_d.xls','range','A2:A1027');
time=(table2array(time));
time=(time(1:3:end,1))';
TC=readtable('s_w_d.xls','range','Y2:Y1027');
TC=(table2array(TC));

%%
%Initializing the variables
N=1370004385;
I=(TC(1:3:end,1))';
R=(TC(2:3:end,1))';
D=(TC(3:3:end,1))';
%N=suspectable+infected+recovered
S=N-I-R;
s=S./N;
i=I./N;
r=R./N;

%%
%Finding parameters beta and gamma
beta=-1.*([0 diff(s)]./(s.*i));
%eliminating NaN and infinity values before taking mean rate
beta(isnan(beta)) = [];
beta(isinf(beta)) = [];
beta=abs(mean(beta));
fprintf("Infection/transmission rate is: %d \n",...
    beta);
gamma=([0 diff(r)]./i);
gamma(isnan(gamma)) = [];
gamma(isinf(gamma)) = [];
gamma=abs(mean(gamma));
fprintf("recovery rate is: is %d \n",...
    gamma);

%%
%Solving the equations
ti = 0;
tf =300;
yi = [s(end) i(end) r(end)];
[t, yf] = ode45('ode',[ti tf],yi);


%%
%Plotting the prediction
figure()
plot(t,yf(:,1),t,yf(:,2),t,yf(:,3))
title('SIR Model');
xlabel('Time')
ylabel('Proportion of number of people')
legend('Susceptible', 'Infected', 'Recovered')
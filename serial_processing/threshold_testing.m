%% Define Parameters for Model
clear; clc; close all;
%%% Set
A=1; %drift rate
c=1; %noise
N=1000; %num trials
y01=0; %starting point
z2=0.9; %threshold for stimulus 2
T0=0.01; %non-decision time
dt=0.01; % time step

%%% Alter
z1=0.1:0.05:0.8; %threshold

for k=1:length(z1)
    [percent_correct(k), percent_falsepositive(k), avg_RT(k)] = SP_multiple_simulations(A,c,dt,y01,z1(k),z2,T0,N);
end

figure(1)
subplot(211)
plot(z1,avg_RT, 'o')
ylabel('Reaction Time (s)')
subplot(212)
plot(z1,percent_correct, 'o')
hold on
plot(z1,percent_correct-percent_falsepositive, 'o', 'Color','r')
legend('% Correct (Total)', "% Correct (Adjusted)", 'Location', 'northwest')
ylabel('Accuracy (%)')
xlabel('Threshold')
sgtitle('Stimulus 1 Threshold Impacts on Accuracy and RT')


%% Change z2
clear
z1=0.3;
A=1; %drift rate
c=1; %noise
N=1000; %num trials
y01=0; %starting point
T0=0.01; %non-decision time
dt=0.01; % time step
z2=0.4:0.05:0.95;
for k=1:length(z2)
    [percent_correct(k), percent_falsepositive(k), avg_RT(k)] = SP_multiple_simulations(A,c,dt,y01,z1,z2(k),T0,N);
end

figure(2)
subplot(211)
plot(z2,avg_RT, 'o')
ylabel('Reaction Time (s)')
subplot(212)
plot(z2, percent_correct, 'o')
hold on
plot(z2,percent_correct-percent_falsepositive, 'o', 'Color','r')
legend('% Correct (Total)', "% Correct (Adjusted)", 'Location', 'northwest')
ylabel('Accuracy (%)')
xlabel('Threshold')
sgtitle('Stimulus 2 Threshold Impacts on Accuracy and RT')
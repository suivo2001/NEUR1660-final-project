clear all

%% Define Parameters for Model
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
    [percent_correct(k), avg_RT(k)] = SP_multiple_simulations(A,c,dt,y01,z1(k),z2,T0,N);
end

figure(1)
subplot(211)
plot(z1,avg_RT, 'o')
ylabel('Reaction Time (s)')
subplot(212)
plot(z1,percent_correct, 'o')
ylabel('Accuracy (%)')
xlabel('Threshold')
sgtitle('Stimulus 1 Threshold Impacts on Accuracy and RT')
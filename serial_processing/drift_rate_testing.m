%% Define Parameters for Model
%%% Set
c=1; %noise
N=1000; %num trials
y01=0; %starting point
z1=0.4; %threshold
z2=0.9; %threshold for stimulus 2
T0=0.01; %non-decision time
dt=0.01; % time step


%%% Alter
A=0.1:0.2:4; % drift rate

for k=1:length(A)
    [percent_correct(k), avg_RT(k)] = SP_multiple_simulations(A(k),c,dt,y01,z1,z2,T0,N);
end

figure(1)
subplot(211)
plot(A,avg_RT, 'o')
ylabel('Reaction Time (s)')
subplot(212)
plot(A,percent_correct, 'o')
ylabel('Accuracy (%)')
xlabel('Drift Rate')
sgtitle('Stimulus 1 Drift Rate Impacts on Accuracy and RT')

% Expectedly as drift rate increases, rt decreases and accuracy increases.
% Why isn't the reaction time ever over 1 second? Will have to look in
% serial_processing.m
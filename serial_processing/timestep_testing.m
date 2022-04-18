%%% Set
A=1; %drift rate
c=1; %noise
N=1000; %num trials
y01=0; %starting point
z2=0.9; %threshold for stimulus 2
T0=0.01; %non-decision time
z1=0.3;

%%% Alter
dt=0.01:0.05:0.8; 

for k=1:length(dt)
    [percent_correct(k), avg_RT(k)] = SP_multiple_simulations(A,c,dt(k),y01,z1,z2,T0,N);
end

figure(1)
subplot(211)
plot(dt,avg_RT, 'o')
ylabel('Reaction Time (s)')
subplot(212)
plot(dt,percent_correct, 'o')
ylabel('Accuracy (%)')
xlabel('Time Step (s)')
sgtitle('Time Step Impacts on Accuracy and RT')
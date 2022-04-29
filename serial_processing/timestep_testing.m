clc; clear; close all
%%% Set
A=1; %drift rate
c=1; %noise
N=1000; %num trials
y01=0; %starting point
z1=0.6;
z2=0.8; %threshold for stimulus 2
T0=0.01; %non-decision time

%%% Alter
dt=0.01:0.05:0.8;

for k=1:length(dt)
    [percent_correct(k), percent_falsepositive(k), avg_RT(k)] = SP_multiple_simulations(A,c,dt(k),y01,z1,z2,T0,N);
end

figure(1)
subplot(211)
plot(dt,avg_RT)
ylabel('Reaction Time (s)')
title('Time Step Impacts on Accuracy and RT (Z1=0.6, Z2=0.8)')
subplot(212)
plot(dt,percent_correct-percent_falsepositive)
ylabel('Accuracy (%)')
xlabel('Time Step (s)')

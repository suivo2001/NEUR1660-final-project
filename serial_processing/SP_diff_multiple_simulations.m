function [percent_correct, percent_falsepositive, avg_RT] = my_multiple(A,c,dt,y01,z1,z2,T0,N)
%% Serial Processing (SP) run on multiple simulations (N)
% NEUR 1660: Final Project
% Last Update: April 17, 2022
% Michaela Alarie and Elizabeth Doss
% Usage: Drift Diffusion Model for serial processing. Serial processing task
    %%%  has two different stimuli, one that must reach a threshold before
    %%%  attending to the other.
% Inputs
    %%%  A: drift rate
    %%%  c: noise (usually value = 1)
    %%%  dt: step rate
    %%%  y01: starting point for the first stimulus
    %%%  z1: Threshold for the first stimulus
    %%%  z2: Threshold for the second stimulus
    %%%  T0: Non-decision time
    %%%  N: number simulations
% Outputs
    %%% percent_correct: Percentage of Correct choices across simulations (N)
    %%% avg_RT: Average reaction time across all simulations (N)
%% Determine Accuracy and RT
correct=zeros([1 N]);
incorrect=zeros([1 N]);
RT=zeros([1 N]);
for f=1:N
    [RT(f), correct(f), incorrect(f), false_positive(f)] = serial_processing(A,c,dt,y01,z1,z2,T0);
    clear y; clear y01; clear y02;
    y01=0;
end

percent_correct=mean(correct)*100;
percent_falsepositive=mean(false_positive)*100;
avg_RT=mean(RT);
end
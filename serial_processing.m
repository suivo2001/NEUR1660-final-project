%% Serial Processing DDM
% Michaela Alarie and Elizabeth Doss
% Neur1660 Final Project
% Updated: April 11, 2022
clc; clear; close all

%% Download Data File and Create RT, Correct, and trial type Variables
Data=readmatrix('hier_sub301_sess1_m11_d02_h11_m36.csv');
Trial_Type=Data(:,5);
RT2=Data(:,11);
Correct2=Data(:,12);

%% Remove any trial type 9 values
p=1;
for k=1:length(Trial_Type)
    if Trial_Type(k)==9
    else
        RT(p,:)=RT2(k);
        Correct(p,:)=Correct2(k);
        p=p+1;
    end
end

%% Define Parameters
A=1; %drift rate
c=1; %noise
dt=0.01; % time step
y0=0; %starting point
N=1000; %num trials
z=0.5; %threshold
T0=0.25; %non-decision time
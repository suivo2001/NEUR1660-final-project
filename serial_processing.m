%% Serial Processing DDM
% Michaela Alarie and Elizabeth Doss
% Neur1660 Final Project
% Updated: April 11, 2022
clc; clear; close all

% %% Download Data File and Create RT, Correct, and trial type Variables
% Data=readmatrix('hier_sub301_sess1_m11_d02_h11_m36.csv');
% Trial_Type=Data(:,5);
% RT2=Data(:,11);
% Correct2=Data(:,12);
% 
% %% Remove any trial type 9 values
% p=1;
% for k=1:length(Trial_Type)
%     if Trial_Type(k)==9
%     else
%         RT(p,:)=RT2(k);
%         Correct(p,:)=Correct2(k);
%         p=p+1;
%     end
% end

%% Define Parameters for Model
A=1; %drift rate
c=1; %noise
dt=0.001; % time step
y01=0; %starting point
N=1000; %num trials
z1=0.5; %threshold
z2=0.9; %threshold for stimulus 2
T0=0.01; %non-decision time

%% Determine Accuracy and RT
i=1;
while  abs(y01(i))<z1
    r=randn(1);
    dW=sqrt(dt)*r;
    dy=A*dt+c*dW;
    y01(i+1)=y01(i)+dy;
    i=i+1;
end

y02=y01(end); %starting point for second stimulus
j=1;
while  abs(y02(j))<z2
    r=randn(1);
    dW2=sqrt(dt)*r;
    dy2=A*dt+c*dW2;
    y02(j+1)=y02(j)+dy2;
    j=j+1;
end

y=[y01 y02];
RT=length(y)*dt+T0; 
correct=0; incorrect=0;
if y(end)>z2
    correct=correct+1;
elseif y(end)<-z2
    incorrect=incorrect+1;
end
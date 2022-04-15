%% Serial Processing DDM
% Michaela Alarie and Elizabeth Doss
% Neur1660 Final Project
% Updated: April 15, 2022
clc; clear; close all

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
correct=zeros([1 N]);
incorrect=zeros([1 N]);
RT=zeros([1 N]);
for f=1:N
    clear y;
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
    RT(f)=length(y)*dt+T0; 
    correct(f)=0; incorrect(f)=0;
    if y(end)>z2
        correct(f)=correct(f)+1;
    elseif y(end)<-z2
        incorrect(f)=incorrect(f)+1;
    end
end

percent_correct=mean(correct)*100;
avg_RT=mean(RT);
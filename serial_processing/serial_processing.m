function [RT, correct, incorrect] = serial_processing(A,c,dt,y01,z1,z2,T0)
%% -- NEUR1660 Final Project -- Serial Processing Function (DDM Model)
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
% Outputs
    %%% RT: predicted reaction times
    %%% Correct: Predicted accuracy (number correct)
    %%% Incorrect: Predicted number incorrect choices
%% ------------------Code --------------------------
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
end


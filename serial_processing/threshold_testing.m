%% Define Parameters for Model
clear; clc; close all;
A=1; %drift rate
c=1; %noise
N=200; %num trials
y01=0; %starting point
T0=0.01; %non-decision time
dt=0.05; % time step

%%% Alter
z1=0.1:0.05:0.85;
z2=0.15:0.05:0.9;
k1=0;
for k=1:length(z2)
    for p=1:length(z1)
        if z1(p)>z2(k)
        else
            [percent_correct(k,p), percent_falsepositive(k,p), avg_RT(k,p)] = SP_multiple_simulations(A,c,dt,y01,z1(p),z2(k),T0,N);
        end
    end
end
%%
figure(3);
hold on
imagesc(z1, z2, avg_RT);
xlim([0.1, 0.85])
ylim([0.15 0.9])
colorbar
xlabel('z1')
ylabel('z2')
hold off
sgtitle('Threshold Impacts on RT')

%%
figure(4);
subplot(131)
hold on
imagesc(z1, z2, percent_falsepositive);
xlim([0.1, 0.85])
ylim([0.15 0.9])
colorbar
title('% Correct (FALSE +)')
xlabel('z1')
ylabel('z2')
subplot(132)
hold on
imagesc(z1, z2, percent_correct-percent_falsepositive);
xlim([0.1, 0.85])
ylim([0.15 0.9])
colorbar
title('% Correct (Adjusted)')
xlabel('z1')
ylabel('z2')
subplot(133)
hold on
imagesc(z1, z2, percent_correct)%-percent_falsepositive);
xlim([0.1, 0.85])
ylim([0.15 0.9])
colorbar
title('% Correct (Total)')
xlabel('z1')
ylabel('z2')
hold off
sgtitle('Threshold Impact on False Positives')
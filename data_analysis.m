clear; close all; 
% pull data
[RT,Correct,part_num] = pulling_data();
% serial processing model #1
A=1; %drift rate
c=1; %noise
N=22000; %num trials
y01=0; %starting point
T0=0.01; %non-decision time
dt=0.15; % time step
z1=0.15;
z2=0.8;
[percent_correct, percent_falsepositive, avg_RT, RT2] = SP_multiple_simulations(A,c,dt,y01,z1,z2,T0,N);

%% experimental min/max, mean, std
mean_experimentalRT=nanmean(RT);
min_experimentalRT=min(RT);
max_experimentalRT=max(RT);
RT_std=nanstd(RT);
Correct_std=nanstd(Correct);
mean_experimnetalcorr=nanmean(Correct);

%% plot
% make histogram of the rt distribution (Experimental Data)
figure(1)
hold on
histogram(RT)
xline(mean_experimentalRT,'r', 'LineWidth', 1.1)
xlabel('Reaction Time (s)')
ylabel('Count')
title('Experimental RTs')

% make boxplot for accuracy by participant (Experimental Data)
for p=1:part_num(end)
    avg_accuracy_experimental(p)=nanmean(Correct(part_num==p))*100;
end
figure(2)
boxplot(avg_accuracy_experimental)
title('Experimental % Correct')
ylabel('Percent Correct (%)')
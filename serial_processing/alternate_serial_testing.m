clc; clear; close all
%%% Set
A=1; %drift rate
c=1; %noise
N=200; %num trials
y01=0; %starting point
%z2=0.8; %threshold for stimulus 2
T0=0.01; %non-decision time
%z1=0.45;
dt = 0.05;

%%% Alter
z1=0.1:0.05:0.85;
z2=0.15:0.05:0.9;

for k=1:length(z2)
    for p=1:length(z1)
        if (z2(k) < z1(p))
        else
            [percent_correct(k,p), percent_falsepositive(k,p), avg_RT(k,p)] = my_multiple(A,c,dt,y01,z1(p),z2(k),T0,N);
        end
    end
end

%%
figure(1);
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
figure(2);
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

%% avg_rt vs correct when z1,z2 = ideal from prev
%figure(3)

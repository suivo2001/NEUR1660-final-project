%%
clear all;
%% -- NEUR1660 Final Project -- Parallel Processing Function (DDM Model)
% Last Update: April 20, 2022
% Ivo Su and Kaitlyn Mundy
% Usage: Drift Diffusion Model for parallel processing. The parallel 
    %%%  processing task has two different stimuli, both of which
    %%%  accumulate evidence at the same time.
% Inputs
    %%%  A: drift rate
    %%%  c: noise (usually value = 1)
    %%%  y1_0: starting point for the first stimulus
    %%%  z1: Threshold for the first stimulus
    %%%  z2: Threshold for the second stimulus
    %%%  t0: Non-decision time
    %%%  dt: time step rate
% Outputs
    %%% rt: predicted reaction times
    %%% correct: Predicted accuracy (number correct)
    %%% incorrect: Predicted number incorrect choices
    %%% both_correct: Predicted accurate response due to correct processing
    
%% Initial Simulation
% ~~ Parameters ~~
A = 1;
c = 1;
y1_0 = 0;
z = 0.5;
%z1 = 0.5;
%z2 = z1;
t0 = 0.25;
dt = 0.1;

% ~~ Simulate One Decision ~~
[rt, correct, both_correct] = parallelProcessingSimulation(A,c,y1_0,z,dt)


% ~~ Simulation ~~
[rt_mean, rt_std, correct_mean, both_correct_mean] = parallelProcessingTrial(A,c,y1_0,z,dt)

%% Drift Rate Testing
% ~~ Parameters ~~
A = 0.1:0.2:4; % drift rate

% ~~ Initialize Matrices ~~
avg_RT_DRtest = zeros();
percent_correct_DRtest = zeros();
percent_both_correct_DRtest = zeros();

% ~~ Simulation ~~
for k = 1:length(A)
    [avg_RT_DRtest(k), ~, percent_correct_DRtest(k), percent_both_correct_DRtest(k)] = parallelProcessingTrial(A(k), c, y1_0, z, dt);
end

% ~~ Plot ~~
figure(1)
subplot(211)
plot(A, avg_RT_DRtest, 'o-')
ylabel('Reaction Time (s)')
subplot(212)
plot(A, percent_correct_DRtest, 'o-')
hold on;
plot(A, percent_both_correct_DRtest, 's-')
ylabel('Accuracy (%)')
legend('Percent Correct', 'Percent Both Correct')
xlabel('Drift Rate')
sgtitle('Drift Rate Alteration Impact on Accuracy and RT')

A = 1; % reset drift rate for future tests

%% Threshold Testing
% ~~ Parameters ~~
z = 0.1:0.05:1; % threshold

% ~~ Initialize Matrices ~~
avg_RT_THtest = zeros();
percent_correct_THtest = zeros();
percent_both_correct_THtest = zeros();

% ~~ Simulation ~~
for k = 1:length(z)
    [avg_RT_THtest(k), ~, percent_correct_THtest(k), percent_both_correct_THtest(k)] = parallelProcessingTrial(A, c, y1_0, z(k), dt);
end

% ~~ Plot ~~
figure(2)
subplot(211)
plot(z, avg_RT_THtest, 'o-')
ylabel('Reaction Time (s)')
subplot(212)
plot(z, percent_correct_THtest, 'o-')
hold on;
plot(z, percent_both_correct_THtest, 's-')
ylabel('Accuracy (%)')
legend('Percent Correct', 'Percent Both Correct')
xlabel('Threshold')
sgtitle('Threshold Alteration Impact on Accuracy and RT')

z = 0.5; % reset drift rate for future tests

%% Timestep Testing
% ~~ Parameters ~~
dt = 0.01:0.05:0.8; 

% ~~ Initialize Matrices ~~
avg_RT_TStest = zeros();
percent_correct_TStest = zeros();
percent_both_correct_TStest = zeros();

% ~~ Simulation ~~
for k = 1:length(dt)
    [avg_RT_TStest(k), ~, percent_correct_TStest(k), percent_both_correct_TStest(k)] = parallelProcessingTrial(A, c, y1_0, z, dt(k));
end

% ~~ Plot ~~
figure(3)
subplot(211)
plot(dt, avg_RT_TStest, 'o-')
ylabel('Reaction Time (s)')
subplot(212)
plot(dt, percent_correct_TStest, 'o-')
hold on;
plot(dt, percent_both_correct_TStest, 's-')
ylabel('Accuracy (%)')
xlabel('Timestep')
legend('Percent Correct', 'Percent Both Correct')
sgtitle('Timestep Alteration Impact on Accuracy and RT')

dt = 0.1; % reset timestep for future tests

%% Combined Drift Rate and Threshold Testing
% ~~ Parameters ~~
A = 0:0.2:4;
z = 0:0.05:1;

% ~~ Initialize Matrices ~~
avg_RT_DRTHtest = zeros();
percent_correct_DRTHtest = zeros();
percent_both_correct_DRTHtest = zeros();

% ~~ Simulation ~~
for k = 1:length(A)
    for j = 1:length(z)
        [avg_RT_DRTHtest(k,j), ~, percent_correct_DRTHtest(k,j), percent_both_correct_DRTHtest(k,j)] = parallelProcessingTrial(A(k), c, y1_0, z(j), dt);
    end     
end

figure(4)
subplot(211)
imagesc(A, z, avg_RT_DRTHtest);
ylabel('Threshold')
title('RT')
colorbar
subplot(212)
imagesc(A, z, percent_correct_DRTHtest - (1 - percent_both_correct_DRTHtest));
ylabel('Threshold')
title('Accuracy (Both Correct)')
colorbar
%subplot(313)
%imagesc(A, z, percent_both_correct_DRTHtest);
%ylabel('Threshold')
xlabel('Drift Rate')
sgtitle('Effect of Drift Rate and Threshold on RT and Accuracy')

A = 1;
z = 0.5;

%% Finding best parameters that match the results (time step, threshold):

% ~~ Parameters ~~
A = 1;
c = 1;
y1_0 = 0;
z_vals = 0:0.05:1;
dt_vals = 0.01:0.05:0.8;

% ~~ Experimental ~~
exp_rt=1.26;
exp_correct=0.92;



% ~~ Initialize Matrices ~~
avg_RT = zeros();
percent_correct = zeros();
percent_both_correct = zeros();

% ~~ Parameters to find max ~~
delta=1000;
best_dt=-1;
best_z=-1;



% ~~ Simulation ~~
for k = 1:length(dt_vals)
    for j = 1:length(z_vals)
        [avg_RT(k,j), ~, percent_correct(k,j), percent_both_correct(k,j)] = parallelProcessingTrial(A, c, y1_0, z_vals(j), dt_vals(k));
        difference=abs(avg_RT(k,j)-exp_rt)+abs(percent_correct(k,j)-exp_correct);
        if difference<delta
            best_dt=k;
            best_z=j;
            delta=difference;
        end
    end     
end
tuned_rt=avg_RT(best_dt,best_z)
tuned_correct=percent_correct(best_dt,best_z)
true_positive=percent_both_correct(best_dt,best_z)
best_dt=dt_vals(best_dt);
best_z=z_vals(best_z);

figure(4)
subplot(211)
hold on
imagesc(dt_vals, z_vals, avg_RT);
ylabel('Threshold')
xlabel('Time step')
title('RT')
plot(best_dt, best_z, '*g')
colorbar
xlim([0.01, 0.8])

subplot(212)
hold on
imagesc(dt_vals, z_vals, percent_correct);
plot(best_dt, best_z, '*g')
ylabel('Threshold')
title('Accuracy (Both Correct)')
colorbar
xlim([0.01, 0.8])
%subplot(313)
%imagesc(A, z, percent_both_correct_DRTHtest);
%ylabel('Threshold')
xlabel('Time step')
sgtitle('Finding best values')

%% Plotting for best value 

% ~~ Parameters ~~
A = 1;
c = 1;
y1_0 = 0;
best_dt=0.06;
best_z=0.95;

% Running for 22000 trials
N=22000;
    
    rts=zeros(N,1);
    corrects=zeros(N,1);
    both_corrects=zeros(N,1);
    
    for i=1:N
        [rt,correct,both_correct]=parallelProcessingSimulation(A,c,y1_0,best_z,best_dt);
        rts(i)=rt;
        corrects(i)=correct;
        both_corrects(i)=both_correct;
    end
hold on
figure(6)
hist(rts,50)
xline(1.245,'--',"mean rt")
xlabel("rt")
ylabel("count")
title("rt histogram for tuned parameters")
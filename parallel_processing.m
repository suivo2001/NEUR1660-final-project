[rt,choice]=parallelProcessingSimulation();
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

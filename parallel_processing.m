[rt,choice]=parallelProcessingSimulation();
%% -- NEUR1660 Final Project -- Parallel Processing Function (DDM Model)
% Last Update: April 20, 2022
% Ivo Su and Kaitlyn Mundy
% Usage: Drift Diffusion Model for parallel processing. The parallel 
    %%%  processing task has two different stimuli, both of which
    %%%  accumulate evidence at the same time.
% Inputs
    %%%  A: drift rate
    %%%  c: noise (usually value = 1)
    %%%  dt: time step rate
    %%%  y01: starting point for the first stimulus
    %%%  z1: Threshold for the first stimulus
    %%%  z2: Threshold for the second stimulus
    %%%  t0: Non-decision time
% Outputs
    %%% rt: predicted reaction times
    %%% correct: Predicted accuracy (number correct)
    %%% incorrect: Predicted number incorrect choices
    %%% both_correct: Predicted accurate response due to correct processing
    
%% Initial Simulation
% ~~ Parameters ~~
A = 1;
c = 1;
y1_0 = 0.3;
z1 = 0.5;
z2 = z1;
t0 = 0.25;
dt = 0.1;

% ~~ Simulate One Decision ~~
[rt, correct, both_correct] = parallelProcessingSimulation(A,c,y1_0,z1,dt)


% ~~ Simulation ~~
[rt_mean, rt_std, correct_mean, both_correct_mean] = parallelProcessingTrial(A,c,y1_0,z1,dt)


%% Drift Rate Testing
% ~~ Parameters ~~
A = 0.1:0.1:2; % drift rate
avg_RT = zeros();
percent_correct = zeros();

% ~~ Simulation ~~
for k = 1:length(A)
    [avg_RT(k), percent_correct(k), ~] = parallelProcessingTrial(A(k), c, y1_0, z1, dt);
end

% ~~ Plot ~~
figure(1)
subplot(211)
plot(A, avg_RT, 'o-')
ylabel('Reaction Time (s)')
subplot(212)
plot(A, percent_correct, 'o-')
ylabel('Accuracy (%)')
xlabel('Drift Rate')
sgtitle('Drift Rate Alteration Impact on Accuracy and RT')


%% Time Step Testing
% ~~ Parameters ~~
A = 1
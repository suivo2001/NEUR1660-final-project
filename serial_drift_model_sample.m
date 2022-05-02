%% Define Parameters for Model
%%% Set
c=1; %noise
N=1000; %num trials
y01=0; %starting point
z1=0.4; %threshold
z2=0.9; %threshold for stimulus 2
T0=0.01; %non-decision time
dt=0.01; % time step
A = 0.5; % drift rate

figure(1)
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

% concatanate the accumulated evidence to plot
dtmat = 1:1:(i+j);
alldata = cat(2,y01, y02);

hold on
plot(dtmat,alldata)
yline(z1)
yline(-z1)
yline(z2)
yline(-z2)
xline(i)
title('Evidence Accumulation for z1=0.4,z2=0.9,dt=0.01')
ylabel('Evidence Accumulation')
xlabel('Time Step')


%% Try the same thing with different threshold meanings
%%% So starting point for z2 will be 0
c=1; %noise
N=1000; %num trials
y01=0; %starting point
z1=0.4; %threshold
z2=0.9; %threshold for stimulus 2
T0=0.01; %non-decision time
dt=0.01; % time step
A = 0.5; % drift rate

figure(2)
i=1;
while  abs(y01(i))<z1
    r=randn(1);
    dW=sqrt(dt)*r;
    dy=A*dt+c*dW;
    y01(i+1)=y01(i)+dy;
    i=i+1;
end

y02=0; %starting point for second stimulus

j=1;
while  abs(y02(j))<z2
    r=randn(1);
    dW2=sqrt(dt)*r;
    dy2=A*dt+c*dW2;
    y02(j+1)=y02(j)+dy2;
    j=j+1;
end

% concatanate the accumulated evidence to plot
dtmat1 = 1:1:i;
dtmat2 = i+1:1:i+j;

hold on
plot(dtmat1,y01)
plot(dtmat2,y02)
yline(z1)
yline(-z1)
yline(z2)
yline(-z2)
xline(i)
title('Evidence Accumulation for z1=0.4,z2=0.9,dt=0.01')
ylabel('Evidence Accumulation')
xlabel('Time Step')

% Display only thresholds that matter
% Have a label/title that states whether decision was correct or not at
% each threshold

% define correctness - false positives?
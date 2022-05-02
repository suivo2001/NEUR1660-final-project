%% plotting
close all;
A=1; %drift rate
c=1; %noise
N=200; %num trials
y01=0; %starting point
T0=0.01; %non-decision time
dt=0.05; % time step
z1=0.2;
z2=0.8;

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
correct=0; incorrect=0; false_positive=0;
if y02(end)>z2 && y01(end)>z1
    correct=correct+1;
elseif y02(end)<-z2 && y01(end)<-z1
    false_positive=false_positive+1;
else
    incorrect=incorrect+1;
end
correct=correct+false_positive;
dtmat = (1:1:(i+j))*dt;
alldata = cat(2,y01, y02);

figure(1)
plot(dtmat,alldata, 'k', 'LineWidth', 1.2)
hold on
if y01(end)>z1 && y02(end)>z2
    yline(y02(end), '--r', 'LineWidth', 1.2)
    hold on
    yline(y01(end), '--r', 'LineWidth', 1.2)
    title('Evidence Accumulation (Correct Choice)')
elseif y01(end)<-z1 && y02(end)<-z2
    yline(y02(end), '--r', 'LineWidth', 1.2)
    hold on
    yline(y01(end), '--r', 'LineWidth', 1.2)
    title('Evidence Accumulation (Correct Choice: FALSE POSITIVE)')
else
    yline(y02(end), '--r', 'LineWidth', 1.2)
    hold on
    yline(y01(end), '--g', 'LineWidth', 1.2)
    title('Evidence Accumulation (Incorrect Choice)')
end
xline(dt*i, 'b','LineWidth', 1.1)
hold on
xline(dtmat(end), 'm','LineWidth', 1.1)
ylabel('Evidence Accumulation')
xlabel('Time Step')
legend({'Evidence Accumulation', 'Threshold 2', 'Threshold 1', 'Time Point Stimulus 1', 'RT'},...
    'Location', 'northwest')
function [rt, correct, both_correct] = parallelProcessingSimulation(A1,c1,y1_0,z1,dt)
    % decision maker parameters for 1st stimulus
%     A1=1;
%     c1=1;
%     y1_0=0.3;
%     z1=0.5;
     y1=y1_0;
    
    % decision maker parameters for 2nd stimulus (currently same as first parameter)
    A2=A1;
    c2=c1;
    y2_0=y1_0;
    z2=z1;
    y2=y2_0;
    
    % simulation parameters
    t0=0.01;
    %dt=0.01;
    
    % storage matrices for visualization
    %accumulation = zeros();
    
    % simulation
    steps=1;
    while abs(y1(steps))<z1 || abs(y2(steps))<z2
        % first parameter update
        if abs(y1(steps))<z1
            r1=randn(1);
            dW1=sqrt(dt)*r1;
            dy1=A1*dt+c1*dW1;
            y1(steps+1)=y1(steps)+dy1;
        % keep same value if reached threshold
        else
            y1(steps+1)=y1(steps);
        end
        % second parameter update
        if abs(y2(steps))<z2
            r2=randn(1);
            dW2=sqrt(dt)*r2;
            dy2=A2*dt+c2*dW2;
            y2(steps+1)=y2(steps)+dy2;
        % keep same value if reached threshold
        else
            y2(steps+1)=y2(steps);
        end
        %accumulation(1, steps) = y1(steps);
        %accumulation(2, steps) = y2(steps);
        steps=steps+1;
    end
    
    %accumulation(1, steps) = y1(steps);
    %accumulation(2, steps) = y2(steps);
    
    % Reaction time
    rt=t0+steps*dt;
    
    % Correct or not -> if both reached the correct threshold
    correct=0;
    both_correct=0;
    if (y1(steps)>=z1 && y2(steps)>=z2 )
        correct=1;
        both_correct=1;
    end
    if (y2(steps)<=-z1 && y2(steps)<=-z2)
        correct=1;
    end
    
%     figure
%     plot(1:steps,y1, 1:steps,y2)
%     title('parallel processing')
%     yline(z1,'--')
%     yline(-z1,'--')
%     ylim([-1.2,1.2])
%     legend('stimulus 1', 'stimulus 2', 'upper threshold', 'lower threshold')
end

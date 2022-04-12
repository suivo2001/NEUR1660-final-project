function [rt, correct] = parallelProcessingSimulation()
    % decision maker parameters for 1st stimulus
    A1=1;
    c1=1;
    y1_0=0.3;
    z1=0.5;
    y1=y1_0;
    % decision maker parameters for 2nd stimulus
    A2=1;
    c2=1;
    y2_0=0.3;
    z2=0.5;
    y2=y2_0;
    % simulation parameters
    t0=0.25;
    dt=0.01;
    
    % simultaion
    steps=1;
    while abs(y1(steps))<z1 && abs(y2(steps))<z2
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
        steps=steps+1;
    end
    % Reaction time
    rt=t0+steps*dt;
    % Correct or not -> if both reached the correct threshold
    correct=false;
    if y1(steps)>z1 && y2(steps)>z2
        correct=true;
    end
end
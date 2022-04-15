% function to get average rt, standard deviation of rt, and percent of
% correct and "true" correct from all responses.
function [rt_mean, rt_std, correct_mean, both_correct_mean] = parallelProcessingTrial(A1,c1,y1_0,z1,dt)
    N=1000;
    
    rts=zeros(N,1);
    corrects=zeros(N,1);
    both_corrects=zeros(N,1);
    
    for i=1:N
        [rt,correct,both_correct]=parallelProcessingSimulation(A1,c1,y1_0,z1,dt);
        rts(i)=rt;
        corrects(i)=correct;
        both_corrects(i)=both_correct;
    end
    
    rt_mean=mean(rts);
    rt_std=std(rts);
    
    correct_mean=mean(corrects);
    both_correct_mean=mean(both_corrects);
end
function [RT, Correct, part_num]=pulling_data()
%% Pulling Data
% Last Update: April 18, 2022
% Michaela Alarie and Elizabeth Doss
% Usage: Function that pulls real data from task (non-simulated)
% Inputs: None as of now, could set filepath as an input if wanted
% Outputs
    %%% RT: Experimental Reaction Times
    %%% Correct: Experimental Accuracy
    %%% part_num: Participant number
%% ------------------Code --------------------------

filepath='C:\Users\Michaela\Documents\MATLAB\Courses\NEUR1660\Final Project\hier\';
datafiles=[filepath, '*.csv'];
datafiles=dir(datafiles);
RT=[];
Correct=[];
part_num=[];

for i=1:length(datafiles)
    DataTable=readmatrix([filepath datafiles(i).name]);
    Trial_Type=DataTable(:,5);
    RT2=DataTable(:,11);
    Correct2=DataTable(:,12);
    p=1;
    for k=1:length(Trial_Type)
        if Trial_Type(k)==9
        else
            RT_unique(p)=[RT2(k,1)];
            RT=[RT RT2(k,1)];
            Correct=[Correct; Correct2(k,1)];
            p=p+1;
        end
    end
    part_num=[part_num i*ones(1, length(RT_unique))];
    clear Correct2; clear Trial_Type; clear RT2; clear p; clear RT_unique;
end

RT_avg=nanmean(RT);
Correct_avg=nanmean(Correct);
end
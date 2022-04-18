%% Download Data File and Create RT, Correct, and trial type Variables
Data=readmatrix('hier_sub301_sess1_m11_d02_h11_m36.csv');
Trial_Type=Data(:,5);
RT2=Data(:,11);
Correct2=Data(:,12);

%% Remove any trial type 9 values
p=1;
for k=1:length(Trial_Type)
    if Trial_Type(k)==9
    else
        RT(p,:)=RT2(k);
        Correct(p,:)=Correct2(k);
        p=p+1;
    end
end

nanmean(RT2)
nanmean(Correct2)
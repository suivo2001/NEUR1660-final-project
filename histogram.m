clear all

% pull data
[RT,Correct,part_num] = pulling_data();

median_rt = nanmedian(RT);

% make a box plot of the rt distribution
hold on
boxplot(RT)
yline(median_rt, 'r')
ylabel('Reaction Time')
title('Distribution of Reaction Times for All Hier Data, Median='+string(median_rt))
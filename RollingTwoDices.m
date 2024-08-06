clear; clc; close;

N = 100;

a = 0;
b = 6;

dice1 = randi([1,6],1,N);
dice2 = randi([1,6],1,N);
sum_num = dice1+dice2;

exact_prob = [1,2,3,4,5,6,5,4,3,2,1] / 36;

sim_counts = histcounts(sum_num, 'BinEdges', 1.5:1:12.5);
sim_prob = sim_counts / N;

figure;
hold on;
histogram(sum_num, 'BinEdges', 1.5:1:12.5, 'Normalization', 'probability');
plot(2:12, sim_prob, 'LineWidth', 2);
plot(2:12, exact_prob, 'LineWidth', 2);
xlabel('The sum of rolling two dice');
ylabel('Probability');
title(['Total number of step = ',num2str(N)]);
legend('hist','sim','exact');
hold off;


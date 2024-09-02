clearvars;
Nrun = 100; % Number of simulations
time_step = 1; % [second]
n_step = 60*60*24*30*12;
initial_balance = 6000;
monthly_income = 4500;
last_balance = zeros(1, Nrun);

% Plot results
figure; clf;
for i = 1:Nrun
    i
    [balance_week] = fixedtime_algorithm_bank(time_step, n_step, initial_balance, monthly_income);
    last_balance(i) = balance_week(end);
    hold on;
    plot(1:size(balance_week,1), balance_week);
end
mean_balance = mean(last_balance);
fprintf('Mean Final Balance: %.2f\n', mean_balance);
xlabel('Time (weeks)');
ylabel('Bank Account Balance (Baht)');
title('Prediction of Bank Account Balance Using Fixedtime Algorithm');
hold off;
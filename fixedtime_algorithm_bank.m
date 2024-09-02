function [balance_week] = fixedtime_algorithm_bank(time_step, n_step, initial_balance, monthly_income)
    
    % Income and Expense rates (events per day) and amounts
    income_categories = {'mom-dad', 'ancle-grandma'};
    income_raw_event_times = [11,4]; % Total occurs income events in 10 months
    income_raw_amounts = [14900,2299]; % Total amount for each income events in 10 months
    income_rates = income_raw_event_times./(10*30*24*60*60); % Average number of income events per second
    income_amounts = income_raw_amounts./income_raw_event_times; % Average income amount per event
    
    expense_categories = {'food', 'travel', 'goods'};
    expense_raw_event_times = [808,227,39]; % Total occurs expense events in 10 months
    expense_raw_amounts = [48780,6785.5,7107.18]; % Total amount for each expense events in 10 months
    expense_rates = expense_raw_event_times./(10*30*24*60*60); % Average number of expense events per second
    expense_amounts = expense_raw_amounts./expense_raw_event_times; % Average expense amount per event

    % Arrays to store balance and time
    balance = zeros(1, n_step);
    balance_week = [];

    % Initial conditions
    current_balance = initial_balance;
    balance(1) = current_balance;
    
    occur_count = zeros(1,6);
    
%     sum_prob = zeros(1,n_step);

    for i = 1:n_step-1
        % Add monthly income
        if mod(i*time_step,60*60*24*30) == 0
            balance(i) = balance(i)+ monthly_income;
        end
        
        % Step 1: Generate random numbers r1 uniformly distributed in (0,1)
        r1 = rand;
        
        % Step 2: Compute the propensity functions
        a = income_rates(1)*time_step;
        b = income_rates(2)*time_step;
        c = expense_rates(1)*time_step;
        d = expense_rates(2)*time_step;
        e = expense_rates(3)*time_step;
        
        %sum_prob(i) = a+b+c+d+e;
        
        % Step 3: Determine which transaction occurs
        if r1 <= a
            % First income event
            balance(i+1) = balance(i) + income_amounts(1);
            occur_count(1) = occur_count(1) + 1;
        elseif r1 > a && r1 <= a+b
            % Second income event
            balance(i+1) = balance(i) + income_amounts(2);
            occur_count(2) = occur_count(2) + 1;
        elseif r1 > a+b && r1 <= a+b+c
            % First expense event
            balance(i+1) = balance(i) - expense_amounts(1);
            occur_count(3) = occur_count(3) + 1;
        elseif r1 > a+b+c && r1 <= a+b+c+d
            % Second expense event
            balance(i+1) = balance(i) - expense_amounts(2);
            occur_count(4) = occur_count(4) + 1;
        elseif r1 > a+b+c+d && r1 <= a+b+c+d+e
            % Third expense event
            balance(i+1) = balance(i) - expense_amounts(3);
            occur_count(5) = occur_count(5) + 1;
        else
            % Nothings occur
            balance(i+1) = balance(i);
            occur_count(6) = occur_count(6) + 1;
        end
        
        if mod(i*time_step,60*60*24*7) == 0
            balance_week = [balance_week; balance(i)];
        end
%         if balance(i+1) <= 0
%             balance(i+1) = balance(i);
%         end
    end


    
    occur_count
end
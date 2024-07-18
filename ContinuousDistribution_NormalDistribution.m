N = 1000;

mu = 0;
sigma = 1;
target = @(x) (1/(sigma*sqrt(2*pi)))*exp(-0.5*((x-mu)/sigma).^2);

% Define the proposal distribution (uniform distribution)
a = -5;
b = 5;
proposal_sampler = (b-a).*rand(1,N)+a;

% Storage for accepted and rejected samples
accepted_samples = [];
rejected_samples = [];


% Acceptance-Rejection Sampling
for i = 1:N
    x = proposal_sampler(1,i);
    y = rand() * max(target(proposal_sampler)); % scale y to the max of distribution
    if y <= target(x)
        accepted_samples = [accepted_samples; x y];
    else
        rejected_samples = [rejected_samples; x y];
    end
end

% Plotting
figure;
hold on;

% Plot accepted-rejected samples
plot(rejected_samples(:,1), rejected_samples(:,2), 'rx');
plot(accepted_samples(:,1), accepted_samples(:,2), 'bo');

% plot normal distribution
syms x_
fplot(target(x_), [-5, 5], 'k', 'LineWidth', 1.5);

% Labels and title
xlabel('x');
ylabel('target(x)');
title('Acceptance-Rejection Method for Normal Distribution');
legend({'reject', 'accept', 'target'});

hold off;
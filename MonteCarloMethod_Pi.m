N = 10000;
x = rand(N,1);
y = rand(N,1);
distances = sqrt(x.^2 + y.^2);

insideCircle = distances <= 1;
outsideCircle = distances > 1;
pi_estimate = 4 * sum(insideCircle) / N;

figure;
hold on;
axis equal;
plot(x(insideCircle), y(insideCircle), 'g.');
plot(x(outsideCircle), y(outsideCircle), 'b.');
xlabel('x');
ylabel('y');
xlim([0 1]);
ylim([0 1]);
title(sprintf('\\pi: %.3f with N = %d', pi_estimate, N));
legend('Inside Circle', 'Outside Circle');
hold off;
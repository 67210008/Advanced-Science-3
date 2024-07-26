N = 1000; % walker
n = 1000; % step
dx = 1;

figure(1);
hold on;
xlabel('number of step');
ylabel('position');
grid on;

total_pos = 0;
final_pos = zeros(1, N);
sum_each_pos_sqr = zeros(1, n);

% For walker 1 to N
for i = 1:N
  pos = 0;
  x = zeros(1, n);
  % For walk step 1 to n max step
  for j = 1:n
      if rand() > 0.5
          pos = pos + dx;
      else
          pos = pos - dx;
      end
      x(j) = pos;
      sum_each_pos_sqr(j) = sum_each_pos_sqr(j) + pos^2;
  end
  total_pos = total_pos + pos;
  final_pos(i) = pos;
  
  figure(1);
  hold on;
  plot(1:n, x, 'LineWidth', 1);
  title(['N = ', num2str(i), ', n = ', num2str(j), ', <x> = ', num2str(total_pos/i)]);
  %title(sprintf('N = {%4d}, n = {%3d}, <x> = {%.6f},', i, j, total_pos/i));
end

figure(2);
histogram(final_pos, 'FaceColor', 'blue', 'EdgeColor', 'black', 'BinWidth', 5);
title('100 steps of random walk');
xlabel('position');
ylabel('number of particles');

figure(3);
plot(1:n, sum_each_pos_sqr./n, 'LineWidth', 1);
title([num2str(n),' steps of random walk, ',num2str(N),' walker']);
xlabel('step (n)');
ylabel('<x^2>');
hold on;
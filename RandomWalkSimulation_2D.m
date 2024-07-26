N = 1; % walker
n = 1000; % step
dpos = 1;

figure(1);
hold on;
xlabel('x position');
ylabel('y position');
grid on;



pos_x = 0;
pos_y = 0;
x = zeros(1, n);
y = zeros(1, n);
% For walk step 1 to n max step
for j = 1:n
  if rand() > 0.5
    if rand() > 0.5
    	pos_x = pos_x + dpos;
    else
        pos_x = pos_x - dpos;
    end
  else
    if rand() > 0.5
    	pos_y = pos_y + dpos;
    else
        pos_y = pos_y - dpos;
    end
  end
  x(j) = pos_x;
  y(j) = pos_y;
end
figure(1);
hold on;
plot(x, y, 'LineWidth', 1);
plot(0, 0, 'ro');
title(['2D random walk; 1 walker and n = ', num2str(j)]);
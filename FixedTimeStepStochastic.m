clear; clc;

Nrun = 100; % num simulation
nstep = 10000; % num step
A = zeros(Nrun,nstep);
A(1:Nrun,1) = 20;
k = 0.1;
dt = 0.005;
t(1) = 0;
for i=1:Nrun
    for j=1:nstep
        if A(i,j) > 0
            if rand(1)<k*dt*A(i,j)
                A(i,j+1) = A(i,j)-1;
            else
                A(i,j+1) = A(i,j);
            end
        else
            A(i,j+1) = A(i,j);
        end
        t(j+1) = t(j)+dt;
    end
end
figure;
hold on;
plot(t, A);
plot(t, mean(A,1),'--k','Linewidth',2);
xlabel('Time(sec)');
ylabel('Number of Molecules A');
title('Fixed time step stochastic simulation');

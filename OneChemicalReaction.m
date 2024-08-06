clear; clc;

Nrun = 100; % num simulation
nstep = 10000; % num step
A = zeros(Nrun,nstep);
A0 = 20;
A(1:Nrun,1) = A0;
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
plot(t, A, 'HandleVisibility', 'off');
plot(t, mean(A,1),'--k','Linewidth',2,'DisplayName','Mean (SSA)');
xlabel('Time(sec)');
ylabel('Number of Molecules A');
title('Gillespie compare with SSA');

A_gillespie = zeros(1, A0);
t_gillespie = zeros(1, A0);
A_gillespie(:,1) = A0;
A = A0;
t = 0;
i = 1;
while A > 0
    r = rand(1); % random number for time step
    tau = (1 / (A * k)) * log(1 / r); % calculate tau
    t = t + tau;
    A = A-1;
    A_gillespie(1,i) = A; % store value
    t_gillespie(1,i) = t;
    
    i = i+1;
end

plot(t_gillespie, A_gillespie,'--r','Linewidth',2,'DisplayName','Gillespie');
legend;
clear; clc;

A0 = 0;
B0 = 0;
k1 = 10*10^-3;
k2 = 10*10^-2;
k3 = 1.2;
k4 = 1;

Nrun = 2; % num simulation
nstep = 500; % num step
A_gillespie = zeros(Nrun,nstep);
B_gillespie = zeros(Nrun,nstep);
A_gillespie(:,1) = A0;
B_gillespie(:,1) = B0;
t_gillespie = zeros(Nrun,nstep);

for i = 1:Nrun
    t = 0;
    for j=2:nstep
        r1 = rand(1); % random number for time step
        r2 = rand(1);
        alpha1 = A_gillespie(i,j)*A_gillespie(i,j-1)*k1;
        alpha2 = A_gillespie(i,j)*B_gillespie(i,j)*k2;
        alpha3 = k3;
        alpha4 = k4;
        alpha0 = alpha1+alpha2+alpha3+alpha4;
        tau = (1 / alpha0) * log(1 / r1); % calculate tau
        if 0 <= r2 && r2 < alpha1/alpha0 && A_gillespie(i,j)>1
            A_gillespie(i,j+1) = A_gillespie(i,j)-2;
            B_gillespie(i,j+1) = B_gillespie(i,j);
        elseif alpha1/alpha0 <= r2 && r2 < (alpha1+alpha2)/alpha0 && A_gillespie(i,j)>0 && B_gillespie(i,j) > 0
            A_gillespie(i,j+1) = A_gillespie(i,j)-1;
            B_gillespie(i,j+1) = B_gillespie(i,j)-1;
        elseif (alpha1+alpha2)/alpha0 <= r2 && r2 < (alpha1+alpha2+alpha3)/alpha0
            A_gillespie(i,j+1) = A_gillespie(i,j)+1;
            B_gillespie(i,j+1) = B_gillespie(i,j);
        elseif (alpha1+alpha2+alpha3)/alpha0 <= r2 && r2 < 1
            A_gillespie(i,j+1) = A_gillespie(i,j);
            B_gillespie(i,j+1) = B_gillespie(i,j)+1;
        else
            A_gillespie(i,j+1) = A_gillespie(i,j);
            B_gillespie(i,j+1) = B_gillespie(i,j);
        end
        t = t + tau;
        t_gillespie(i,j+1) = t;
    end
end

figure(1);
plot(t_gillespie, A_gillespie);
figure(2)
plot(t_gillespie, B_gillespie);
% Load Data
clear;
clc;
load('G32/teste_14_int.mat')
Ts = 0.001; % Sampling time

% Plot lab data (u and y) using Ts to plot the time

% u and y must be in separated figures 
t = 0:Ts:(length(u)-1)*Ts; % Create time vector based on sampling time
figure;
plot(t, u);
title('System Input $u$', 'Interpreter', 'latex', 'FontSize', 12);
xlabel('Time (s)');
ylabel('Voltage (V)');
grid on;
figure;
plot(t, y);
title('System Response: $\alpha$ and $\beta$ Angles', 'Interpreter', 'latex', 'FontSize', 12);
xlabel('Time (s)');
ylabel('Angle (Radians)');
legend('$\alpha$ [rad]', '$\beta$ [rad]', 'Interpreter', 'latex', 'FontSize', 16);
grid on;
% Performance Metrics
alpha = y(:,1);
beta  = y(:,2);

% Time step and total time
dt = t(2) - t(1);
T_total = t(end) - t(1);
N = length(t);

% MSE (Mean Squared Error)
MSE_alpha = sum(alpha.^2) / N;
MSE_beta  = sum(beta.^2)  / N;

% ISE (Integral Squared Error)
ISE_alpha = trapz(t, alpha.^2);
ISE_beta  = trapz(t, beta.^2);

% Control effort (energy)
control_energy = trapz(t, u.^2);

% Settling time (robust)
threshold = 0.02; % rad
settling_time = NaN;

for k = 1:length(beta)
    if all(abs(beta(k:end)) <= threshold)
        settling_time = t(k);
        break;
    end
end



% Print results
fprintf("Performance Metrics\n")

fprintf("MSE (alpha): %.6f\n", MSE_alpha)
fprintf("MSE (beta) : %.6f\n", MSE_beta)

fprintf("ISE (alpha): %.6f\n", ISE_alpha)
fprintf("ISE (beta) : %.6f\n", ISE_beta)

fprintf("Control energy: %.6f\n", control_energy)



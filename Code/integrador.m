% Simulator Q8 + integrator
clear;
clc;
% Load data
load('IP_MODEL.mat')

% Augmented state model
C_alpha = [1 0 0 0 0];
    
% Aumented matrices
Aa = [A zeros(5,1); C_alpha 0 ];
Ba = [B; 0];

% Matrices for augmented model
Q_ra = diag([100,0,5000, 0, 2,1]);
R_r = 0.04;

[K_aug, S, P] = lqr(Aa, Ba, Q_ra, R_r);

% Ver pág 224/225 livro
K = K_aug(1:5);
ki = -0.05;
fprintf("Question 11\n \n Vector K (Original States): \n")
disp(K)
fprintf("Gain ki (Error state): \n")
disp(K_aug(6))

% Observer
G = eye(size(A)); % Gain of the process noise
Qe = eye(size(A))*1000; % Variance of process errors
Re = eye(2)*0.001; % Variance of measurement errors
L = lqe(A, G, C, Qe, Re); % Calculate estimator gains

fprintf("Vector L (Observer): \n")
disp(L)

estim_A = A - B*K - L*C;
fprintf("Poles of the final system (controller + observer): \n")
disp(eig(estim_A))

D_estim = zeros(1,2);

% Simulation
% Init condition
x0=[0.1 0 0 0 0]';

% Simulate controller
T=100; % Time duration of the simulation
out = sim('integrador.slx',T);
figure(1)
gg=plot(out.t.Data,out.y.Data);
set(gg,'LineWidth',1.5)
gg=xlabel('Time (s)');
set(gg,'Fontsize',14);
gg=ylabel('Angle states [rad]');
%ylim([-0.4, 0.4])
set(gg,'Fontsize',14);
legend('\alpha [rad]', '\beta [rad]', 'Interpreter', 'latex', 'Fontsize', 16)

% Control effort
figure(2)
gg2=plot(out.t.Data,out.u.Data);
set(gg2,'LineWidth',1.5)
gg2=xlabel('Time (s)');
set(gg2,'Fontsize',14);
gg2=ylabel('$u$ [V]', 'Interpreter','latex', 'FontSize', 16); 


figure(3)
gg=plot(out.t.Data,out.y.Data);
hold on
% Plot the first column
gg = plot(out.t.Data, out.y1.Data(:, 1)); 
hold on 
% Plot the second column
gg = plot(out.t.Data, out.y1.Data(:, 3)); 
set(gg,'LineWidth',1.5)
gg=xlabel('Time (s)');
set(gg,'Fontsize',14);
gg=ylabel('Angle states [rad]');
%ylim([-0.4, 0.4])
set(gg,'Fontsize',14);
%legend('\alpha [rad]', '\beta [rad]', '\hat{\alpha} [rad]', '\dot{\hat{\alpha}} [rad/s]', ...
 %   '\hat{\beta} [rad]','\dot{\hat{\beta}}','\hat{i}' ,...
  %  'Interpreter',  'latex', 'Fontsize', 12)

legend('\alpha [rad]', '\beta [rad]', '\hat{\alpha} [rad]', '\hat{\beta} [rad]', ...
    'Interpreter', 'latex')
% Performance Metrics
t = out.t.Data;
alpha = out.y.Data(:,1);
beta  = out.y.Data(:,2);
u     = out.u.Data;

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


% Overshoot
overshoot = max(abs(beta));

% Print results
fprintf("Performance Metrics\n")

fprintf("MSE (alpha): %.6f\n", MSE_alpha)
fprintf("MSE (beta) : %.6f\n", MSE_beta)

fprintf("ISE (alpha): %.6f\n", ISE_alpha)
fprintf("ISE (beta) : %.6f\n", ISE_beta)

fprintf("Control energy: %.6f\n", control_energy)

fprintf("Settling time: %.3f s\n", settling_time)

fprintf("Overshoot: %.6f rad\n", overshoot)

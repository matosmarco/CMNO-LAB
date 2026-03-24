% Question 8

% K computation: computing the Regulator Gain
load("IP_MODEL.mat")
Q_r = diag([90, 0, 3200, 0, 0]); 
R_r = 0.04;
%R_r = 10;

[K,S,P] = lqr(A,B,Q_r,R_r); %Calculate feedback gain

fprintf("Question 5\n \n Vector K: \n")
disp(K)

% L computation
G = eye(size(A)); %Gain of the process noise
Qe = eye(size(A))*100; %Variance of process errors
Re = eye(2); %Variance of measurement errors

L = lqe(A, G, C, Qe, Re); %Calculate estimator gains
disp(L)



estim_A = A - B*K - L*C;
fprintf("Poles of the final system (controller + observer): \n")

disp(eig(estim_A))

D_estim = zeros(1,2);

% Init condition
x0=[0.1 0 0 0 0]';

% Simulate controller
T=10; % Time duration of the simulation
out = sim('q8.slx',T);
figure(1)
gg=plot(out.t.Data,out.y.Data);
set(gg,'LineWidth',1.5)
gg=xlabel('Time (s)');
set(gg,'Fontsize',14);
gg=ylabel('Angle states [rad]');
ylim([-0.4, 0.4])
set(gg,'Fontsize',14);
legend('\alpha [rad]', '\beta [rad]', 'Interpreter', 'latex', 'Fontsize', 16)

% Control effort
figure(2)
gg2=plot(out.t.Data,out.u.Data);
set(gg2,'LineWidth',1.5)
gg2=xlabel('Time (s)');
set(gg2,'Fontsize',14);
gg2=ylabel('$u$ [V]', 'Interpreter','latex', 'FontSize', 16); 


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
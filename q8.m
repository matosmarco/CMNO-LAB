% Question 8

% K computation: computing the Regulator Gain
load("IP_MODEL.mat")
Q_r = diag([1,0,10,0,0]);

R_r = 1;
%R_r = 10;

[K,S,P] = lqr(A,B,Q_r,R_r); %Calculate feedback gain

fprintf("Question 5\n \n Vector K: \n")
disp(K)



% L computation
G = eye(size(A)); %Gain of the process noise
Qe = eye(size(A))*10; %Variance of process errors
Re = eye(2); %Variance of measurement errors

L = lqe(A, G, C, Qe, Re); %Calculate estimator gains
disp(L)



estim_A = A - B*K - L*C;
D_estim =D';

% Simulate controller
x0=[0.1 0 0 0 0]';
T=20; % Time duration of the simulation
sim('q8.slx',T);
gg=plot(out.t.Data,out.y.Data);
set(gg,'LineWidth',1.5)
gg=xlabel('Time (s)');
set(gg,'Fontsize',14);
gg=ylabel('\beta (rad)');
set(gg,'Fontsize',14);

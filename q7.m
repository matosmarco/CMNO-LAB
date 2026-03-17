% Compute the estimator gain
load("IP_MODEL.mat")
G = eye(size(A)); %Gain of the process noise
Qe = eye(size(A))*10; %Variance of process errors
Re = eye(2); %Variance of measurement errors
L = lqe(A, G, C, Qe, Re); %Calculate estimator gains
disp(L)

obs_A = A- L*C;


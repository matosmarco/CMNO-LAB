clc;
% Compute the Regulator Gain
load("IP_MODEL.mat")

%Q_r = diag([1,0,10,0,0]);

%Q_r = diag([10,0,1,0,0]);
Q_r = diag([4, 1, 100, 1, 0]);
R_r = 0.04;
%R_r = 10;

[K,S,P] = lqr(A,B,Q_r,R_r); %Calculate feedback gain

fprintf("Question 5\n \n Vector K: \n")
disp(K)

A_new = (A - B*K);

eig_A_new = eig(A_new);

fprintf("\nEigenvalues of A- BK:\n")
disp(eig_A_new)
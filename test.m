% Computation of the characteristic model
load("IP_MODEL.mat")
syms s % s variable


Q_r = diag([1,0,10,0,0]);

R_r = 1;

[K,S,P] = lqr(A,B,Q_r,R_r); %Calculate feedback gain

A_new = (A - B*K);

% Rank closed-loop characteristic polynomial:
rank_poly = rank(s*eye(size(A)) - A_new);
disp(rank_poly)


fprintf("Characteristic polynomial\n");
disp(s*eye(size(A)) - A_new)
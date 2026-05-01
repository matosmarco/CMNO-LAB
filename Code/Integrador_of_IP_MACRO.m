% ------------------------------
% CMNO 2024/2025 - Alberto Vale
% ------------------------------

% Load state model
load('IP_MODEL.mat')

% Constraints
V_MAX = 5; % Maximum motor voltage
V_MIN = -5; % Minimum motor voltage

ALPHA_MAX = 90 * pi/180; % Maximum angle accepted for motor shaft
BETA_MAX = 15 * pi/180; % Maximum angle before falling
TIME_DELAY = 6; % seconds before start

T = 30; % Time duration of the simulation
Ts = 0.001; % Sampling time

% Regulator parameters
% Augmented state model
C_alpha = [1 0 0 0 0];

% Aumented matrices
Aa = [A zeros(5,1); -C_alpha 0 ];
Ba = [B; 0];

% Matrices for augmented model
Q_ra = diag([100,0,5000, 0, 1,1]);
R_r = 0.04;

[K_aug, S, P] = lqr(Aa, Ba, Q_ra, R_r);
% Ver pág 224/225 livro
K = K_aug(1:5);
ki = K_aug(6);

% Observer
G = eye(size(A)); % Gain of the process noise
Qe = eye(size(A))*1000; % Variance of process errors
Re = eye(2)*0.01; % Variance of measurement errors
L = lqe(A, G, C, Qe, Re); % Calculate estimator gains


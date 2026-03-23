% Question 4: Plot the Bode diagram of the open-loop system.
clc;

% Load the matrices that constitutes the model (state model)
load('IP_MODEL.mat');

% Build state-space model 
sys = ss(A,B,C,D);

% Convert state-space representation to transfer function
[num, den]= ss2tf(A,B,C,D);

% Transfer function
transfer_function = tf({num(1,:), num(2, :)},den)

% Bode frequency response of dynamic system
w = {1e-1, 1e4}; % frequency range

bode(sys, w)
%pzplot(sys) % Plot pole-zero map of dynamic system
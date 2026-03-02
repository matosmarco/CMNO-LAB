% Question 1: Characterize the model. Computation of the eigenvalues of
% matrix A
clc;
% Load the matrices that constitutes the model (state model)
load('IP_MODEL.mat');

% Eigenvalues computation
eig_values_A = eig(A);

% Print to console the results
fprintf("Question 1\n \nEigenvalues of A:\n")
disp(eig_values_A)

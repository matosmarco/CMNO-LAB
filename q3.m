% Question 3: Characterize the open loop system in terms of observability
clc;
% Load the matrices that constitutes the model (state model)
load('IP_MODEL.mat');

fprintf("Question 3\n\n")

% Given that x= [x_1 x_2 x_3 x_4 x_5]^T
% If the only output was x_3, then C = [0 0 1 0 0]

fprintf("Case 1: Only output is x3\n")
C_x3 = [0 0 1 0 0];
obser_x3 = obsv(A, C_x3);
fprintf("\nObservability matrix:\n")
disp(obser_x3)

rank_x3 = rank(obser_x3);
% Determine the number of unobservable states.
n = length(A);
unobsv_1 = length(A) - rank_x3;

if unobsv_1 == 0
    fprintf("The rank of the observability matrix is equal to the dimension of state.\n");
    fprintf("The model is observable.\n")
    fprintf("Rank of observability matrix: %d\nDimension of state: %d\n", rank_x3, n);
else
    fprintf("Rank of observability matrix: %d\nDimension of state: %d\n", rank_x3, n);
    fprintf("The model is not observable.\n");
end


fprintf("\nCase 2: Output is measured x1 and x3 (matrix loaded from the model)\n")
obser_x1_x3 = obsv(A, C);
fprintf("\nObservability matrix:\n")
disp(obser_x1_x3)

rank_x1_x3 = rank(obser_x1_x3);
% Determine the number of unobservable states.
unobsv_2 = n - rank_x1_x3;

if unobsv_2 == 0
    fprintf("The rank of the observability matrix is equal to the dimension of state.\n");
    fprintf("The model is observable.\n")
    fprintf("Rank of observability matrix: %d\nDimension of state: %d\n", rank_x1_x3, n);
else
    fprintf("Rank of observability matrix: %d\nDimension of state: %d\n", rank_x1_x3, n);
    fprintf("The model is not observable.\n");
end

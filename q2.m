% Question 2: Characterize the open loop system in terms of controllability
clc;
% Load the matrices that constitutes the model (state model)
load('IP_MODEL.mat');

% Compute controllability matrix.
control = ctrb(A,B);
fprintf("Question 2\n \nControllabity matrix:\n")
disp(control)

% Rank of controllability matrix
rank_C= rank(control);
n = 5; % Dimension of state

% Determine the number of uncontrollable states.
unco = length(A) - rank_C; 

if unco == 0 
    fprintf("The rank of the controllability matrix is equal to the dimension of state.\n");
    fprintf("The model is controllable.\n")
    fprintf("Rank of controllability matrix: %d\nDimension of state: %d\n", rank_C, n);
else
    fprintf("Rank of controllability matrix: %d\nDimension of state: %d\n", rank_C, n);
    fprintf("The model is not controllable.");
end

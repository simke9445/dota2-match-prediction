function [theta] = trainLogReg(X, y, lambda)
% params:
%   X: training set size MxN, where M is the num of training
%      examples and N is the number of features
%   y: training set output vector
%   lambda: L2 regularization parameter which tells
%           how much to penalize our weights
% return:
%   theta: feature weights 

% Initialize Theta
initial_theta = zeros(size(X, 2), 1); 

% Create "short hand" for the cost function to be minimized
costFunction = @(t) computeCostFunc(X, y, t, lambda);

% Now, costFunction is a function that takes in only one argument
options = optimset('MaxIter', 200, 'GradObj', 'on');

% Minimize using fmincg
theta = fmincg(costFunction, initial_theta, options);

% ============================================================

end

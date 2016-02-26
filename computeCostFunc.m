function [J, grad] = computeCostFunc(Xarg, yarg, thetaarg, lambdaarg)
% params:
%   Xarg: training set
%   yarg: training set output vector
%   thetaarg: initial feature weights 
%   lambdaarg: L2 regularization parameter
% return:
%   J: Logistic cost function computed value
%   grad: vector of gradients ready for update in our
%         fmincg optimization method

% number of training examples
m = size(Xarg,1);

% vector of gradients
grad = zeros(size(thetaarg));

% cast the parameters to double
lambda = double(lambdaarg);
X = double(Xarg);
theta = double(thetaarg);
y = double(yarg);

% calculate cost function
J = ((y'*log(sigmoid(X*theta)) + ...
    (1 - y')*log(1 - sigmoid(X*theta))))*(-1/double(m)) + ...
    (lambda/(2*double(m)))*(theta(2:end)'*(theta(2:end)));

tmpTheta = theta;
tmpTheta(1) = 0;

% calculate the gradients
grad = (grad + X'*(sigmoid(X*theta) - y))./m + (lambda/m).*tmpTheta;


end
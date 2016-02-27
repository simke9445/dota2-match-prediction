function p = predict(theta, X)
% params:
%   theta: weight vector obtained from the training data
%   X: test set for which we have to compute the output vector
% return:
%   p: prediction vector which contains the result of the classification.
%      the way we classify is:
%                   - if the sigmoid(theta'.*currentExample) >= 0.5 
%                     predict class 1, otherwise 0

% Number of training examples
m = size(X, 1);

p = zeros(m, 1);

for i=1:m
    if (sigmoid(sum(theta'.*X(i,:)))) >= 0.5
        p(i) = 1;
    end
end




end

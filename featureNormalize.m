function [X_norm, mu, sigma] = featureNormalize(X)
% params:
%   X: Matrix that needs to scaled
% return:
%   X_norm: normalized matrix X
%   mu: vector of mean values for each of X's features
%   sigma: vector of standard deviations for each of 
%          X's features


mu = mean(X);

% bsxfun is like apply function, it applies the 
% function that's passed as a pointer to each element
X_norm = bsxfun(@minus, X, mu);

sigma = std(X_norm);
X_norm = bsxfun(@rdivide, X_norm, sigma);

% ============================================================

end

function g = sigmoid(z)
% params: 
%   z: vector or a number thats being 
%      transformed
% return:
%   g: vector or a number equal to the
%      sigmoid transformation over the input
%      argument

g = zeros(size(z));

g = 1./(1 + exp(-1.*z));
   

% =============================================================

end

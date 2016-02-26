function [X, y] = structToMatrix(T, structArray, heroList)
% params:
%   T: initial dataset which contains all the matches
%   structArray: array of structures that contain
%                certain hero characteristics like:
%                   - XPM, GPM, role prefernce...
%   heroList: list of all heroes names
% return:
%   X: training set where size MxN, where each row contains
%      one training example.
%   y: training set output vector

% size of a block in a structure field;
blockSize = size(structArray(1).safe,2); 

% number of structure fields, excluding the 'name' one;
num = length(fieldnames(structArray(1))) - 1;

% number of players within a game
noPlayers = 10;

% X = zeros(size(T,1),size(heroList,1) + num*noPlayers);
X = zeros(size(T,1), 259);

fprintf('Process: feature extraction started...\n');

% intialize X
for i=1:size(T,1)
    X(i,:) = makeFeatureVector(T{i,1:10}', structArray)';
end

fprintf('Process completed...\n');

% intialize y
y = T{:,11};

% ============================================================

end

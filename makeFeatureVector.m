function [featureVector] = makeFeatureVector(X, structArray)
% params:
%      X: row which contains both team Heroes
%        Example: 
%           -Nyx Assassin = team 1, Nyx AssassinE = team 2 ( E stands for Enemy)
%      structArray: Array of structures containing hero names + their
%      characteristics like XPM, GPM, role prefernces...
% 
% return:
%      featureVector - vector that contains 1 if a Hero is included in the game
%      and 0 if he isn't(with 'e' flag if he's on the enemy team). 

m = size(structArray,1);

enemy = 'e';

% size of a block in a structure field;
blockSize = size(structArray(1).safe,2);

% number of structure fields, excluding the 'name' one;
num = length(fieldnames(structArray(1))) - 1;

% featureIndicies contain indexes the 
% picked in t1 & t2 heroes in heroList
t1FeatureIndicies = zeros(size(X,1)/2,1);
t2FeatureIndicies = zeros(size(X,1)/2,1);
featureVector = zeros(m, 1);

t1 = 1;
t2 = 1;

for k=1:size(X,1)
    i=1;
    str = lower(char(X(k)));
    if k > 5
        str = [str,enemy];
    end
    while i <= m
        if strcmp(str, structArray(i).name)
            if k <= 5
                t1FeatureIndicies(t1) = i;
                t1 = t1 + 1;
            else
                t2FeatureIndicies(t2) = i;
                t2 = t2 + 1;
            end
            
            break;
        end
        i = i + 1;
    end     
end

% attach t1 attributes to the feature vectors
% tmpVec - team characteristics like total GPM, total XPM etc
for i=1:size(t1FeatureIndicies,1)
    featureVector(t1FeatureIndicies(i)) = 1; 
    tmpVec = structArray(t1FeatureIndicies(i)).safe';
    tmpVec = tmpVec + structArray(t1FeatureIndicies(i)).off';
    tmpVec = tmpVec + structArray(t1FeatureIndicies(i)).jungle';
    tmpVec = tmpVec + structArray(t1FeatureIndicies(i)).middle';
    tmpVec = tmpVec + structArray(t1FeatureIndicies(i)).roaming';
    featureVector = [featureVector; tmpVec];
end

% add quadratic team characteristics feature, cuz its significat
featureVector = [featureVector; tmpVec .* tmpVec];
t1vec = tmpVec;

% attach t2 attributes to the feature vectors
for i=1:size(t2FeatureIndicies,1)
    featureVector(t2FeatureIndicies(i)) = 1; 
    tmpVec = structArray(t2FeatureIndicies(i)).safe';
    tmpVec = tmpVec + structArray(t2FeatureIndicies(i)).off';
    tmpVec = tmpVec + structArray(t2FeatureIndicies(i)).jungle';
    tmpVec = tmpVec + structArray(t2FeatureIndicies(i)).middle';
    tmpVec = tmpVec + structArray(t2FeatureIndicies(i)).roaming';
    featureVector = [featureVector; tmpVec];
end

% add quadratic team characteristics feature, difference 
% between both teams total characteristics
featureVector = [featureVector; tmpVec .* tmpVec;...
    (tmpVec - t1vec).*(tmpVec - t1vec)];

% ============================================================

end
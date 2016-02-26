function [heroList] = getHeroList(T)
% params:
%   T: Cell array containing necessary match data:
%                   - both team picks
%                   - score, who won
% return:
%   heroList: list of all hero names contained in the dataset
%             in their original form


% count of unique heroes
maxHeroes = 194;

% hashmap of heroes
mapObj = containers.Map;

% placeholder
currentIndex = 1;

% for loop for caching the hero names from the initial dataset
for i=1:size(T,1)
    if size(mapObj.keys(),2) >= maxHeroes
        break;
    end
    for j=1:size(T,2)-1
        if ~(mapObj.isKey(lower(char(T{i,j}))))
            % add the current name to the hashmap
            newMap = containers.Map(lower(char(T{i,j})), currentIndex);
            % add the same name flagged as enemy
            newMapE = containers.Map(lower(strcat(...
                lower(char(T{i,j})),'e')), currentIndex);
            % add both previous to the map
            mapObj = [mapObj;newMap; newMapE];
        end
    end
end

% initialize heroList by hashmap keys
heroList = mapObj.keys()';

% ============================================================

end
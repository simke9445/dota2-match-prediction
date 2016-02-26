function [structArray] = makeStructArray(heroMap)
% params:
%   heroMap: heroMap with hero name as key, and it's index 
%            in the map as value
% return:
%   structArray: structure containing hero names mapped to their
%                descriptive values:
%                       - Gold per minute (GPM)
%                       - Experience per minute (XPM)
%                       - Safe lane, off lane, support, jungler, mid role
%                         scores

% intialize the structure and its fields
tempStruct = struct('name','','safe',double(zeros(1,5))... 
    ,'off',double(zeros(1,5)),'middle',double(zeros(1,5))...
    ,'jungle',double(zeros(1,5)),'roaming',double(zeros(1,5)));

structArray = repmat(tempStruct, size(heroMap,1), 1);

% intialize the heroList
heroList = heroMap.keys();

% set the names of the structure to the heroList names
for i=1:size(heroMap,1)
    structArray(i).name = heroList{i};
end

% datamined information about heroes characteristics described earlier
[num,txt,raw] = xlsread('dota2Attributes.xls');

% set the necessary textual data
txt = txt(4:end,6:7);

% set the necessary numeric data
num = num(:,7:end);
num = num(:,[2 4 4:end]);
num = num(:,[1 3:end]);

for ind=1:size(txt,1)
    
    % parse the hero name value
    expression = '\/';
    splitStr = regexp(txt{ind,1},expression,'split');
    expression = '-';
    replace = ' ';
    tempStr = regexprep(splitStr(end),expression,replace);
    tempStr = lower(tempStr);
    
    % hero name
    str = char(tempStr);
    
    % update misspelled names
    if strcmp(str,'anti mage')
        str = 'anti-mage';
    end
    if strcmp(str,'necrophos')
        str = 'necrolyte';
    end
    if strcmp(str,'windranger')
        str = 'windrunner';
    end
    if strcmp(str,'lycan')
        str = 'lycanthrope';
    end
    if strcmp(str, 'io')
        str = 'wisp';
    end
    if strcmp(str, 'wraith king')
        str = 'skeleton king';
    end
    if strcmp(str, 'natures prophet')
        str = 'nature''s prophet';
    end
    
    % if key is heroMap, update the characteristics
    if heroMap.isKey(str)
        
        % set the index to the mapped value
        index = heroMap(str);

        % update middle lane role value for hero name
        % and enemy flagged name also
        if strcmp('Middle Lane',char(txt{ind,2}))
            structArray(index).middle = num(ind,:);
            structArray(index+1).middle = num(ind,:);
        end
        
        % -||- role: off lane
        if strcmp('Off Lane',char(txt{ind,2}))
            structArray(index).off = num(ind,:);
            structArray(index+1).off = num(ind,:);
        end
        
        % -||- role: roaming
        if strcmp('Roaming',char(txt{ind,2}))
            structArray(index).roaming = num(ind,:);
            structArray(index+1).roaming = num(ind,:);
        end
        
        % -||- role: safe lane
        if strcmp('Safe Lane',char(txt{ind,2}))
            structArray(index).safe = num(ind,:);
            structArray(index+1).safe = num(ind,:);
        end
        
        % -|| role: jungle
        if strcmp('Jungle',char(txt{ind,2}))
            structArray(index).jungle = num(ind,:);
            structArray(index+1).jungle = num(ind,:);
        end
    end
end

% ============================================================

end
%% Initialize the Hero List

% format for reading the data C - string , d - digit
formatSpec = '%C%C%C%C%C%C%C%C%C%C%d';
T = readtable('trainingdata.txt','Delimiter',',','Format',formatSpec);

heroList = getHeroList(T);

% ============================================================
%% Initialization of Data Structure

% create the Heroes Map
setKeys = heroList';
setValues = 1:size(setKeys,2);
heroMap = containers.Map(setKeys, setValues);

keys = heroMap.keys();
values = heroMap.values();

structArray = makeStructArray(heroMap);

% ============================================================
%% Data Transformation

% create matrix representation of training data
[X, y] = structToMatrix(T, structArray, heroList);

% ============================================================
%% Feature scaling

% Zero mean and Unit variance scaling
[X, mu, sigma] = featureNormalize(X);

% add the bias column
X = [ones(size(X,1),1) X];

% ============================================================
%% K-Fold cross validation

% reducing output vector to {0,1} instead of {1,2}
y = y - 1; 

% k-fold
k = 4;

% initialize the cross-validated accuracy & theta param
cvAccuracy = 0.0;
cvTheta = zeros(size(X,2), k); 

for i=1:k
    
    % split the training/test/cv sets on 60/20/20
    [Xtrain, ytrain, Xcv, ycv, Xtest, ytest] = testSplit(X, y);
    
    Xtrain = [Xtrain; Xcv];
    ytrain = [ytrain; ycv];

    % initialize the L2 regularization parameter
    lambda = 0;

    % train the classifier
    theta = trainLogReg(Xtrain,ytrain, lambda);

    % predict the test set outputs
    p = predict(theta, Xtest);

    fprintf('Train Accuracy with Logistic Regression on test set: %f\n', mean(double(p == ytest)) * 100);
    
    cvAccuracy = cvAccuracy + mean(double(p == ytest));
    
    % vector of correct/incorrect predictions
    predictions = (double(p == ytest));
    % num of false positives
    fp = sum((predictions == 1) & (ytest == 0));
    % num of true positives
    tp = sum((predictions == 1) & (ytest == 1));
    % compute num of false negatives
    fn = sum((predictions == 0) & (ytest == 1));

    % compure precision/recall & F1-score
    precision = tp/(tp + fp);
    recall = tp/(tp + fn);
    F1 = (2*precision*recall)/(precision + recall);


    fprintf('Recall = %f\n',recall);
    fprintf('Precision = %f\n',precision);
    fprintf('F1 score = %f\n',F1);
    
    cvTheta(:, i) = theta;
end

fprintf('Cross Validated Accuracy = %f \n', 100*cvAccuracy/k);

% ============================================================
function [Xtrain, ytrain, Xcv, ycv, Xtest, ytest] = testSplit(X, y)

% train/cv/test splits like 60/20/20
mTrain = floor((size(X,1)*6)/10);
mCV = floor((size(X,1) - mTrain )/2);
mTest = mCV + mod(size(X,1) - mTrain ,2);

% shuffle the array
randidx = randperm(size(X,1));

% compute training set input & output pairs
Xtrain = X(randidx(1:mTrain+mCV),:);
ytrain = y(randidx(1:mTrain+mCV));

% compute cross-validation input & output pairs
Xcv = X(randidx(mTrain+1:mTrain+mCV),:);
ycv = y(randidx(mTrain+1:mTrain+mCV));

% compute test set input & output pairs
Xtest = X(randidx(mTrain+mCV+1:size(X,1)),:);
ytest = y(randidx(mTrain+mCV+1:size(X,1)));

% ============================================================

end

    
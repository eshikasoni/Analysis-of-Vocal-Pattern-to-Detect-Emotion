function stats = confusionmatStats( value)
% INPUT
% group = true class labels
% grouphat = predicted class labels
%
% OR INPUT
% stats = confusionmatStats(group);
% group = confusion matrix from matlab function (confusionmat)
%
% OUTPUT
% stats is a structure array
% stats.confusionMat
%               Predicted Classes
%                    p'    n'
%              ___|_____|_____| 
%       Actual  p |     |     |
%      Classes  n |     |     |
%
% stats.accuracy = (TP + TN)/(TP + FP + FN + TN) ; the average accuracy is returned
% stats.precision = TP / (TP + FP)                  % for each class label
% stats.sensitivity = TP / (TP + FN)                % for each class label
% stats.specificity = TN / (FP + TN)                % for each class label
% stats.recall = sensitivity                        % for each class label
% stats.Fscore = 2*TP /(2*TP + FP + FN)            % for each class label
%
% TP: true positive, TN: true negative, 
% FP: false positive, FN: false negative
%  
TP=value(1,1);
 TN=value(1,2);
 FP=value(2,1);
 FN=value(2,2);
 
% stats.accuracy = (TP + TN)/(TP + FP + FN + TN);
 stats.precision = TP / (TP + FP);
  stats.sensitivity = TP / (TP + FN) ;   
  stats.specificity = TN / (FP + TN);  
  stats.Fscore = 2*TP /(2*TP + FP + FN);  
end
    
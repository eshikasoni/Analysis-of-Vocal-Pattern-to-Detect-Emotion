clc;
clear all;
close all;
load fisheriris
load all_feat.mat
load svm_label.mat
X = total_set; % use all data for fitting
Y = svm_label; % response data
%%

%%
mdl = fitcknn(X,Y);
mdl.NumNeighbors = 1;
mdl = fitcknn(X,Y,'NumNeighbors',1);
rloss = resubLoss(mdl)
cvmdl = crossval(mdl)
kloss = kfoldLoss(cvmdl)


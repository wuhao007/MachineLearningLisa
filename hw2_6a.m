%% Naive Bayes HW1 - ENRON EMAILS
clear all; close all; clc;

% Load the data from the course directory
load('enron.mat');

% VARIABLES IN 'enron.mat'
% trainFeat: sparse matrix of word counts for training documents.
% trainLabels: matrix of {0,1} training labels where 0=ham,1=spam.
% valFeat: sparse matrix of word counts for validation documents. 
% valLabels: matrix of validation document labels.
% testFeat: sparse matrix of word counts for test documents.
% testLabels: matrix of test document labels.
% vocab: cell array giving word (character string) for each vocabulary index.

%% Calculate ML distribution over words for ham and spam
%% p(x_ij|y_i=spam) p(x_ij|y_i=ham) (i.e. multinomial parameters)
k = 0.1;
numTrainDocs = size(trainFeat, 1);
numTokens = size(trainFeat, 2);
spam_indices = find(trainLabels);
nonspam_indices = find(trainLabels == 0);
prob_spam = length(spam_indices) / numTrainDocs

non = find(sum(trainFeat)==0);
nonSize = length(non)
col = trainFeat(:, find(strcmp(vocab, 'success')));
success_indices = find(col);
often = sum(trainLabels(success_indices))
l = length(success_indices);
%often = sum(trainFeat(spam_indices, index))
%email_lengths = sum(trainFeat, 2);
%spam_wc = sum(email_lengths(spam_indices));
%prob_success_spam = sum(trainFeat(spam_indices, index)) ./ spam_wc;
prob_success_spam = often / l

%% Calculate log likelihoods on validation datasets
numValDocs = size(valFeat, 1);
numTokens = size(valFeat, 2);
spam_indices = find(valLabels);
nonspam_indices = find(valLabels == 0);
prob_spam = length(spam_indices) / numValDocs

%% Set rho as a parameter to threshold words, recalculate 
%% various models as rho changes on validation data
% Note alpha should not be included here.

%% Plot accuracies as a function of rho



%% Set alpha as a parameter for smoothing (i.e Dirichlet prior)
%% recalculate various models as alpha changes on validation data
% Note rho should not be included in these models



%% Plot accuracies as a function of alpha



%% Pick the best model above and calculate/report accuracy on test data
numTestDocs = size(testFeat, 1);
numTokens = size(valFeat, 2);
spam_indices = find(testLabels);
nonspam_indices = find(testLabels == 0);
prob_spam = length(spam_indices) / numTestDocs

%% Find the top 10 words for spam/ham using your best model and report them




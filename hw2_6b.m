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

prob_spam = length(spam_indices) / numTrainDocs;
email_lengths = sum(trainFeat, 2);
spam_wc = sum(email_lengths(spam_indices));
nonspam_wc = sum(email_lengths(nonspam_indices));
prob_tokens_spam = (sum(trainFeat(spam_indices, :)) + k) ./ (spam_wc + k*numTokens);
prob_tokens_nonspam = (sum(trainFeat(nonspam_indices, :)) + k) ./ (nonspam_wc + k*numTokens);

output = zeros(numTrainDocs, 1);
log_a = trainFeat*(log(prob_tokens_spam))' + log(prob_spam);
log_b = trainFeat*(log(prob_tokens_nonspam))'+ log(1 - prob_spam);  

%% Calculate/report accuracy on training data
output = log_a > log_b;
numdocs_wrong = sum(xor(output, trainLabels));
fraction_wrong = numdocs_wrong/numTrainDocs;
accuracy = 1 - fraction_wrong

%% Calculate log likelihoods on validation datasets
%numValDocs = size(valFeat, 1);
%numTokens = size(valFeat, 2);
% spam_indices = find(valLabels);
% nonspam_indices = find(valLabels == 0);
% prob_spam = length(spam_indices) / numValDocs;
%output = zeros(numValDocs, 1);
%log_a = valFeat*(log(prob_tokens_spam))' + log(prob_spam);
%log_b = valFeat*(log(prob_tokens_nonspam))'+ log(1 - prob_spam);  

%% Calculate/report accuracy on validation data
%output = log_a > log_b;
%numdocs_wrong = sum(xor(output, valLabels));
%fraction_wrong = numdocs_wrong/numValDocs;
%accuracy = 1 - fraction_wrong;

%% Set rho as a parameter to threshold words, recalculate 
%% various models as rho changes on validation data
% Note alpha should not be included here.
%rho = (1:10:200);

%% Plot accuracies as a function of rho



%% Set alpha as a parameter for smoothing (i.e Dirichlet prior)
%% recalculate various models as alpha changes on validation data
% Note rho should not be included in these models
%alpha = [.0001, .001, .01, .1, 1, 10];



%% Plot accuracies as a function of alpha



%% Pick the best model above and calculate/report accuracy on test data
%numTestDocs = size(testFeat, 1);
%spam_indices = find(testLabels);
%spam_indices = find(trainLabels);
%nonspam_indices = find(testLabels == 0);
%non = find(sum(trainFeat)==0)
%prob_spam = length(spam_indices) / numTestDocs;
%index = find(strcmp(vocab, 'success'));
%often = sum(trainFeat(spam_indices, index));
%prob_tokens_spam = sum(trainFeat(spam_indices, index)) ./ spam_wc;
numTestDocs = size(testFeat, 1);
numTokens = size(testFeat, 2);
output = zeros(numTestDocs, 1);
log_a = testFeat*(log(prob_tokens_spam))' + log(prob_spam);
log_b = testFeat*(log(prob_tokens_nonspam))'+ log(1 - prob_spam);  

%% Calculate/report accuracy on test data
output = log_a > log_b;
numdocs_wrong = sum(xor(output, testLabels));
fraction_wrong = numdocs_wrong/numTestDocs;
accuracy = 1 - fraction_wrong

%% Find the top 10 words for spam/ham using your best model and report them




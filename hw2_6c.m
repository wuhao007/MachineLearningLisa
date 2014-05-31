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
es = -prob_spam*log(prob_spam)-(1-prob_spam)*log(1-prob_spam);

x = zeros(1,numTokens);
for n = 1:numTokens
    col = trainFeat(:, n);
    success_indices = find(col);
    
    %s = sum(trainFeat(spam_indices, n));
    %l = sum(trainFeat(:, n));
    s = sum(trainLabels(success_indices));
    l = length(success_indices);
    tl = (numTrainDocs - l);
    ts = length(spam_indices) - s;
    %ss =-l/numTrainDocs*(s/l*log2(s/l)+(l-s)/l*log2((l-s)/l)) - tl/numTrainDocs*(ts/tl*log2(ts/tl)+(tl-ts)/tl*log2((tl-ts)/tl));
    ss= -l/numTrainDocs*(s/l*log2(s/l)+(l-s)/l*log2((l-s)/l));
    %if l == 0 
    %    ss = 1;
    %end
    %if tl == 0
    %    ss = 1;
    %end
    x(n)= ss;
    %if x(n) < 0
    %    x(n) = 0;
    %end
end
v = 10;
m = zeros(1,v);

information_gain=x(find(strcmp(vocab, 'success')))

for n = 1:v
    ig = find(x==max(x));
    m(n) = ig(1);
    x(ig(1))= 0;
end

word = vocab(m)

train_matrix = trainFeat(:,m);
test_matrix = testFeat(:,m);
val_matrix = valFeat(:,m);
numTokens = v;

prob_spam = length(spam_indices) / numTrainDocs;
email_lengths = sum(train_matrix, 2);
spam_wc = sum(email_lengths(spam_indices));
nonspam_wc = sum(email_lengths(nonspam_indices));
prob_tokens_spam = (sum(train_matrix(spam_indices, :)) + k) ./ (spam_wc + k*numTokens);
prob_tokens_nonspam = (sum(train_matrix(nonspam_indices, :)) + k) ./ (nonspam_wc + k*numTokens);

output = zeros(numTrainDocs, 1);
log_a = train_matrix*(log(prob_tokens_spam))' + log(prob_spam);
log_b = train_matrix*(log(prob_tokens_nonspam))'+ log(1 - prob_spam);  

%% Calculate/report accuracy on training data
output = log_a > log_b;
numdocs_wrong = sum(xor(output, trainLabels));
fraction_wrong = numdocs_wrong/numTrainDocs;
accuracy = 1 - fraction_wrong;

%% Calculate log likelihoods on validation datasets
numValDocs = size(val_matrix, 1);
numTokens = size(val_matrix, 2);
% spam_indices = find(valLabels);
% nonspam_indices = find(valLabels == 0);
% prob_spam = length(spam_indices) / numValDocs;
output = zeros(numValDocs, 1);
log_a = val_matrix*(log(prob_tokens_spam))' + log(prob_spam);
log_b = val_matrix*(log(prob_tokens_nonspam))'+ log(1 - prob_spam);  

%% Calculate/report accuracy on validation data
output = log_a > log_b;
numdocs_wrong = sum(xor(output, valLabels));
fraction_wrong = numdocs_wrong/numValDocs;
accuracy = 1 - fraction_wrong

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
%numTestDocs = size(test_matrix, 1);
%spam_indices = find(testLabels);
%spam_indices = find(trainLabels);
%nonspam_indices = find(testLabels == 0);
%non = find(sum(train_matrix)==0)
%prob_spam = length(spam_indices) / numTestDocs;
%index = find(strcmp(vocab, 'success'));
%often = sum(train_matrix(spam_indices, index));
%prob_tokens_spam = sum(train_matrix(spam_indices, index)) ./ spam_wc;
numTestDocs = size(test_matrix, 1);
numTokens = size(test_matrix, 2);
output = zeros(numTestDocs, 1);
log_a = test_matrix*(log(prob_tokens_spam))' + log(prob_spam);
log_b = test_matrix*(log(prob_tokens_nonspam))'+ log(1 - prob_spam);  

%% Calculate/report accuracy on test data
output = log_a > log_b;
numdocs_wrong = sum(xor(output, testLabels));
fraction_wrong = numdocs_wrong/numTestDocs;
accuracy = 1 - fraction_wrong

%% Find the top 10 words for spam/ham using your best model and report them




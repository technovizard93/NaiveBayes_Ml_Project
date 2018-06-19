% count how many mails there are in the training set
numTrainDocs = spam_number + non_spam_number;

% read the features matrix
spmatrix = sparse(train_features(:,1), train_features(:,2), train_features(:,3), numTrainDocs, numTokens);
train_matrix = full(spmatrix);
% train_matrix now contains information about the words within the emails
% the i-th row of train_matrix represents the i-th training email
% for a particular email, the entry in the j-th column tells
% you how many times the j-th dictionary word appears in that email

% find the indices for the spam and nonspam labels
spam_indices = find(train_labels);
nonspam_indices = find(train_labels == 0);

% calculate probability of spam
prob_spam = length(spam_indices) / numTrainDocs;

% sum the number of words in each email by summing along each row of train_matrix
email_lengths = sum(train_matrix, 2);
% now find the total word counts of all the spam emails and nonspam emails
spam_wc = sum(email_lengths(spam_indices));
nonspam_wc = sum(email_lengths(nonspam_indices));

% calculate the probability of the tokens in spam emails
prob_tokens_spam = (sum(train_matrix(spam_indices, :)) + 1) ./ (spam_wc + numTokens);
% now the k-th entry of prob_tokens_spam represents phi_(k|y=1)

% calculate the probability of the tokens in non-spam emails
prob_tokens_nonspam = (sum(train_matrix(nonspam_indices, :)) + 1) ./ (nonspam_wc + numTokens);
% now the k-th entry of prob_tokens_nonspam represents phi_(k|y=0)


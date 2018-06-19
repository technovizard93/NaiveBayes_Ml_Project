% read the test matrix in the same way we read the training matrix
spmatrix = sparse(test_features(:,1), test_features(:,2), test_features(:,3));
test_matrix = full(spmatrix);

% store the number of test documents and the size of the dictionary
numTestDocs = size(test_matrix, 1);
numTokens = size(test_matrix, 2);

% the output vector is a vector that will store the spam/nonspam prediction
% for the documents in our test set.
output = zeros(numTestDocs, 1);

% calculate log p(x|y=1) + log p(y=1) and log p(x|y=0) + log p(y=0) 
% for every document, make your prediction based on what value is higher
log_a = test_matrix*(log(prob_tokens_spam))' + log(prob_spam);
log_b = test_matrix*(log(prob_tokens_nonspam))'+ log(1 - prob_spam);  
output = log_a > log_b;

% a document is misclassified if it's predicted label is different from
% the actual label, so count the number of 1's from an exclusive "or"
numdocs_wrong = sum(xor(output, test_labels))

% print out error statistics on the test set
fraction_wrong = numdocs_wrong/numTestDocs



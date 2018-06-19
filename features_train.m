% allocate an empty array to contain all the labels
% at the end of the script train_labels will contain a row for every mail 
% in the training set with value 0 when the mail is classified as 'not spam' 
% and 1 when classified as 'spam'
train_labels = [];

% non spam training features
% allocate an empty matrix to contain all the features of the non spam mails
% at the end of the script non_spam_features_list will contain 3 columns
% the first one is a number representing a mail, the second one
% representing the index in the dictionary of a word contained in the mail
% and the third representing the occurencies of this word in the mail itself
non_spam_features_list = {};
non_spam_files = dir('nonspam-train/*.txt');
non_spam_number = length(non_spam_files);

% read every mail, split them into single words, count the words and check 
% which ones are in the dictionary, every found words add a row to the
% feature list
for i=1:non_spam_number
    mail = fileread(strcat('nonspam-train/', non_spam_files(i).name));
    mailWords = strsplit(mail, ' ');
    
    [uniqueXX, ~, J] = unique(mailWords); 
    occ = histc(J, 1:numel(uniqueXX));
    mailWords_counted = horzcat(uniqueXX.', num2cell(occ));
    mailWords_counted = mailWords_counted(2:end, :);
    
    for j=1:length(mailWords_counted)
        index = find(ismember(sorted_result, mailWords_counted(j)));
        if(~isempty(index))
            non_spam_features_list = vertcat(non_spam_features_list, [i, index, mailWords_counted(j, 2)]);
        end
    end
    
    % add a non spam mail row to the labels array
    train_labels = vertcat(train_labels, 0);
end

disp('Non spam features calculated.')

% spam training features
% same execution as the non spam feature 
spam_features_list = {};
spam_files = dir('spam-train/*.txt');
spam_number = length(spam_files);

for i=1:spam_number
    mail = fileread(strcat('spam-train/', spam_files(i).name));
    mailWords = strsplit(mail, ' ');
    
    [uniqueXX, ~, J] = unique(mailWords); 
    occ = histc(J, 1:numel(uniqueXX));
    mailWords_counted = horzcat(uniqueXX.', num2cell(occ));
    mailWords_counted = mailWords_counted(2:end, :);
    
    for j=1:length(mailWords_counted)
        index = find(ismember(sorted_result, mailWords_counted(j)));
        if(~isempty(index))
            spam_features_list = vertcat(spam_features_list, [i+non_spam_number, index, mailWords_counted(j, 2)]);
        end
    end
    
        % add a spam mail row to the labels array
        train_labels = vertcat(train_labels, 1);
end

disp('Spam features calculated.')

% concat the feature lists and convert the cell matrix into a normal matrix
train_features = cell2mat(vertcat(non_spam_features_list, spam_features_list));

clear occ, clear i, clear j, clear J, clear non_spam_files, clear spam_files, clear uniqueXX, clear J, clear mail
clear mailWords_counted, clear index, clear mailWords, clear non_spam_features_list, clear spam_features_list
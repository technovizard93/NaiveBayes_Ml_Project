% this script calculate the features of the test set in the same way as the
% features_train one
% keep track of the labels to test the algorythm and calculate the error
test_labels = [];

% non spam test features
non_spam_features_list_test = {};
non_spam_files = dir('nonspam-test/*.txt');
non_spam_test_number = length(non_spam_files);

for i=1:non_spam_test_number
    mail = fileread(strcat('nonspam-test/', non_spam_files(i).name));
    mailWords = strsplit(mail, ' ');
    
    [uniqueXX, ~, J] = unique(mailWords); 
    occ = histc(J, 1:numel(uniqueXX));
    mailWords_counted = horzcat(uniqueXX.', num2cell(occ));
    mailWords_counted = mailWords_counted(2:end, :);
    
    for j=1:length(mailWords_counted)
        index = find(ismember(sorted_result, mailWords_counted(j)));
        if(~isempty(index))
            non_spam_features_list_test = vertcat(non_spam_features_list_test, [i, index, mailWords_counted(j, 2)]);
        end
    end
    
    test_labels = vertcat(test_labels, 0);
end

disp('Non spam features calculated.')

% spam test features
spam_features_list_test = {};
spam_files = dir('spam-test/*.txt');
spam_test_number = length(spam_files);

for i=1:spam_test_number
    mail = fileread(strcat('spam-test/', spam_files(i).name));
    mailWords = strsplit(mail, ' ');
    
    [uniqueXX, ~, J] = unique(mailWords); 
    occ = histc(J, 1:numel(uniqueXX));
    mailWords_counted = horzcat(uniqueXX.', num2cell(occ));
    mailWords_counted = mailWords_counted(2:end, :);
    
    for j=1:length(mailWords_counted)
        index = find(ismember(sorted_result, mailWords_counted(j)));
        if(~isempty(index))
            spam_features_list_test = vertcat(spam_features_list_test, [i+non_spam_test_number, index, mailWords_counted(j, 2)]);
        end
    end
    
        test_labels = vertcat(test_labels, 1);
end

disp('Spam features calculated.')

test_features = cell2mat(vertcat(non_spam_features_list_test, spam_features_list_test));

clear occ, clear i, clear j, clear J, clear non_spam_files, clear spam_files, clear uniqueXX, clear J, clear mail
clear mailWords_counted, clear index, clear mailWords, clear non_spam_features_list_test, clear spam_features_list_test
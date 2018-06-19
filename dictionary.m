% allocate an empty cell array to contain all the words
allWords = {};

% set the dictionary size
numTokens = 2500;

% get the name of all the files in the directory 'nonspam-train'
files = dir('nonspam-train/*.txt');

% split every mail word by word and add them to the words array
for i=1:length(files)
    mail = fileread(strcat('nonspam-train/', files(i).name));
    mailWords = strsplit(mail, ' ');
    allWords = horzcat(allWords, mailWords);
end
disp(['Non Spam Train Folder completed: ', num2str(length(files))])


% same as before but this time using the 'spam-train' directory
files = dir('spam-train/*.txt');

for i=1:length(files)
    mail = fileread(strcat('spam-train/', files(i).name));
    mailWords = strsplit(mail, ' ');
    allWords = horzcat(allWords, mailWords);
end
disp(['Spam Train Folder completed: ', num2str(length(files))])


% same as before but this time using the 'nonspam-test' directory
files = dir('nonspam-test/*.txt');

for i=1:length(files)
    mail = fileread(strcat('nonspam-test/', files(i).name));
    mailWords = strsplit(mail, ' ');
    allWords = horzcat(allWords, mailWords);
end
disp(['Non Spam Test Folder completed: ', num2str(length(files))])

% same as before but this time using the 'spam-test' directory
files = dir('spam-test/*.txt');

for i=1:length(files)
    mail = fileread(strcat('spam-test/', files(i).name));
    mailWords = strsplit(mail, ' ');
    allWords = horzcat(allWords, mailWords);
end
disp(['Spam Test Folder completed: ', num2str(length(files))])


% allWords now contains all the words within the mail in the 4 diretories

disp('Split complete, grouping and counting');
clear mail, clear mailWords, clear files, clear i

% word grouping and counting
% proceed by grouping them and counting them in order to have a 2 column matrix 
% with all the words in the first column and their occurrencies in the second
[uniqueXX, ~, J] = unique(allWords); 
occ = histc(J, 1:numel(uniqueXX));
result = horzcat(uniqueXX.', num2cell(occ));
result = result(2:end, :);

% sort the result matrix and keep the first 'numTokens' rows
% sorted_result now contains the 'numTokens' most frequent words in all the mails
sorted_result = sortrows(result, 2, 'descend');
sorted_result = sorted_result(1:numTokens,1:1);

clear uniqueXX, clear occ, clear J, clear result, clear allWords
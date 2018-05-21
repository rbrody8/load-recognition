% DESCRIPTION
% This function performs linear descriminant analysis using classify() to
% classify each dataset in the test group from generate_test.m based on the 
% datasets and classifications of the training group from generate_training.m.
% This function has two options. The first option reads in the training
% data from text files and determines the grouping based on the name of
% each file. The second option takes the training and grouping data as
% inputs. To use option one, pass 2 arugments: the directory of the
% training data, and the directory of the test data. To use option one, 
% pass 3 arugments: a valid training matrix, and the directory of the test
% data, and a valid grouping matrix corresponding to the training matrix.

% CONDITIONS    
%   - input directories must be a valid directory with properly formatted 
%   text files such that textToArr.m can sort the data properly.

% INPUT
%   training_dir - directory containing the training data, OR valid
%   training matrix
%   test_dir    - directory containing the test data
%   input_group - (optional) matrix that classifies each column of data in
%   teh input training matrix. If passing this argument, training_dir must
%   be a valid training matrix.

% OUTPUT
%   load_type   - column vector where the index represents the
%   classification of the data from the testing array at that row

function [load_type,training,group] = detect_load(training_dir, test_dir, input_group)
    
    % checking number of input argumetns
        % if 2, training and grouping data must be read in from files
        % if 3, training and grouping matrix have been passed in
    inputs = nargin;
    if (inputs == 2)
        fprintf('generating training array...');
        [training,group] = generate_training(training_dir);
        fprintf('complete\n');
    elseif (inputs == 3)
        training = training_dir;
        group = input_group;
    end
    
    fprintf('generating test array...');
    test = generate_test(test_dir);
    fprintf('complete\n');
    
    fprintf('classifying test data...');
    load_type = classify(test,training,group,'diaglinear');
    fprintf('complete');
    
    print_results(load_type);
    
end
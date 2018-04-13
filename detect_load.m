% DESCRIPTION
% This function performs linear descriminant analysis using classify() to
% classify each dataset in the test group from generate_test.m based on the 
% datasets and classifications of the training group from generate_training.m.

% CONDITIONS    
%   - input directories must be a valid directory with properly formatted 
%   text files such that textToArr.m can sort the data properly.

% INPUT
%   training_dir - directory containing the training data
%   test_dir    - directory containing the test data

% OUTPUT
%   load_type   - column vector where the index represents the
%   classification of the data from the testing array at that row

function [load_type] = detect_load(training_dir, test_dir)
    
    fprintf('generating training array...');
    [training,group] = generate_training(training_dir);
    fprintf('complete\n');
    
    fprintf('generating test array...');
    test = generate_test(test_dir);
    fprintf('complete\n');
    
    fprintf('classifying test data...');
    load_type = classify(test,training,group,'diaglinear');
    fprintf('complete');
    
    print_results(load_type);
    
end
% DESCRIPTION
% This function creates a training and grouping matrix for the classify() 
% funciton using phase current waveforms from textToArr.m and zero-crossings 
% returned from get_crossings.m

% CONDITIONS    
%   - data_dir must be a valid directory with properly formatted text files
%   such that textToArr.m can sort the data properly.

% INPUT
%   data_dir    - directory containing the training data

% OUTPUT
%   training    - an nxm maxtrix (n=number of samples, m = number points in
%               sample of data files) containing each data set in the
%               training group.
%   group       - the classification of each dataset. see generate_group.m
%               for more detail.

function [training,group] = generate_training(data_dir) 

    % read in and process data from files from directory
    [time,Va,Vb,Vc,Ia,Ib,Ic,cycles,listing] = textToArr(data_dir);
    [pre_start,pre_end,post_start,post_end]=get_crossings(time,Va,Vb,Vc,Ia,Ib,Ic);
    [rows,numFiles]=size(time);
    
    % iteratively creating matrix of training data for the machine learning algorithm
    diff = pre_end(1,1)-pre_start(1,1)+1; % difference in index between 
                                        % beginning and end of each dataset
    col = 1; % current column of phase A pre-transient data
    training = zeros(diff,6*numFiles); % preallocating training matrix
    for i = 1:numFiles
        training(1:(diff+1),col)   = Ia(pre_start(1,i):pre_end(1,i),i);
        training(1:(diff+1),col+1) = Ia(post_start(1,i):post_end(1,i),i);
        training(1:(diff+1),col+2) = Ib(pre_start(2,i):pre_end(2,i),i);
        training(1:(diff+1),col+3) = Ib(post_start(2,i):post_end(2,i),i);
        training(1:(diff+1),col+4) = Ic(pre_start(3,i):pre_end(3,i),i);
        training(1:(diff+1),col+5) = Ic(post_start(3,i):post_end(3,i),i);
        
        col = col+6;
    end
    training = -training'; % transposing the training matrix to work for "classify"
                           % negating training matrix because CTs were backwards
    
    % classify each training dataset
    group = generate_group(time,Va,Vb,Vc,Ia,Ib,Ic,listing,pre_start,pre_end,post_start,post_end);
    
    save('training.mat');
end
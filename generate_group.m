% DESCRIPTION
% This helper function creates a group matrix for the classify() funciton 
% using phase current waveforms and zero-crossings returned from get_crossings

% CONDITIONS    
%   - inputs must be formatted as specified in the output section of
%   textToArr.m and get_crossings.m

% INPUT
%   time,Va,Vb,Vc,Ia,Ib,Ic,listing - training data as formated by
%   textToArr.m
%   pre_start,pre_end,post_start,post_end - starting and ending index of
%   the pre- and post-trasient samples as formated by get_crossings.m

% OUTPUT
%   group - the classification of each dataset. see generate_group.m
%   for more detail.

function [group] = generate_group(time,Va,Vb,Vc,Ia,Ib,Ic,listing,...
    pre_start,pre_end,post_start,post_end)
    
    % declaring constants
    MAX_PERCENTAGE = 0.25;

    load_str = {
                    'no load';
                    'R';
                    'C';
                    'L';
                    'CFL'       };

    [numIndices, numFiles] = size(time);
    
    % order of each dataset in training array from generate_training.m
    a_pre_ind = 0;
    a_post_ind = 1;
    b_pre_ind = 2;
    b_post_ind = 3;
    c_pre_ind = 4;
    c_post_ind = 5;
    
    % preallocating output array
    group = zeros(numFiles*6,1);
    i = 1;
    
    % for every file in data_dir
    for n = 1:numFiles

        % use listing.name and load_str/load_val to determine the classify 
        % value associated with that type of files appropriate classifier
        tokens = split(listing(n).name, '_');
        load_type = tokens(1);
        load_index = find(strcmp(load_str,load_type)); % these are the values
                                                       % the AI will use to
                                                       % identify which
                                                       % component is used
                                                       % in a given event

        % calculate the rms value of current waveform for each phase from 
        % pre/post_start to pre/post_end
        Ia_pre = Ia(pre_start(1,n):pre_end(1,n),n);
        rms_ia_pre = rms(Ia_pre);
        Ib_pre = Ib(pre_start(2,n):pre_end(2,n),n);
        rms_ib_pre = rms(Ib_pre);
        Ic_pre = Ic(pre_start(3,n):pre_end(3,n),n);
        rms_ic_pre = rms(Ic_pre);

        Ia_post = Ia(post_start(1,n):post_end(1,n),n);
        rms_ia_post = rms(Ia_post);
        Ib_post = Ib(post_start(2,n):post_end(2,n),n);
        rms_ib_post = rms(Ib_post);
        Ic_post = Ic(post_start(3,n):post_end(3,n),n);
        rms_ic_post = rms(Ic_post);

        % compute threshold value based on which RMS value changed the most
        delta_a = rms_ia_post-rms_ia_pre;
        delta_b = rms_ib_post-rms_ib_pre;
        delta_c = rms_ic_post-rms_ic_pre;
        max_delta = max([abs(delta_a),abs(delta_b),abs(delta_c)]);
        RMS_THRESHOLD = abs(max_delta*MAX_PERCENTAGE);

        % if rms of any phase is less than RMS_THRESHOLD
            % classify as no load
        % classify based on file name
        if (delta_a >= RMS_THRESHOLD) % turn on
           group(i+a_post_ind) = load_index-1;
        elseif (delta_a < -RMS_THRESHOLD) % turn off
           group(i+a_pre_ind) = load_index-1;
        end
        if (delta_b >= RMS_THRESHOLD) % turn on
           group(i+b_post_ind) = load_index-1;
        elseif (delta_b < -RMS_THRESHOLD) % turn off
           group(i+b_pre_ind) = load_index-1;
        end
        if (delta_c >= RMS_THRESHOLD) % turn on
           group(i+c_post_ind) = load_index-1;
        elseif (delta_c < -RMS_THRESHOLD) % turn off
           group(i+c_pre_ind) = load_index-1;
        end

        i=i+6;
    end

end
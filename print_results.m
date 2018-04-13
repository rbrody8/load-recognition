% DESCRIPTION
% This funciton neatly prints the event type for each waveform in the input
% array data

% CONDITIONS    
%   - input array must format each even as follows:
    %   row i   : pre-transient Ia
    %   row i+1 : post-transient Ia
    %   row i+2 : pre-transient Ib
    %   row i+3 : post-transient Ib
    %   row i+4 : pre-transient Ic
    %   row i+5 : post-transient Ic
%   - the events must be ordered according to the order of the files in
%   the variable listing within test.mat.
%   - each value in the input data array must correspond to an event in
%   load_str

% INPUT
%   data - test data classification determined by matlab

% OUTPUT
%   printing to console

function print_results(data)
    
    % declaring constants
    load_str = {
                    'no load';
                    'R';
                    'C';
                    'L';
                    'CFL'       };
    
    % loading file details for test data
    load('test.mat');
    numFiles = length(listing);
    
    % indexing through each file
    i = 1;
    for n = 1:numFiles
        fprintf('Analyzing %s results...\n', listing(n).name);
        
        % extracting event data from input array
        current_event = data(i:(i+5),:)
        phase_a = current_event(1:2)
        phase_b = current_event(3:4)
        phase_c = current_event(5:6)
        
        % determining event type
        if (phase_a(1) == 0 && phase_a(2) == 0 )
            % no event
            fprintf('\tPhase A - no event\n');
        elseif (phase_a(1) > 0 && phase_a(2) == 0)
            % turn off
            load_type = string(load_str(phase_a(1)+1));
            fprintf('\tPhase A - %s turn off\n',load_type);
        elseif (phase_a(1)== 0 && phase_a(2) > 0)
            % turn on
            load_type = string(load_str(phase_a(2)+1));
            fprintf('\tPhase A - %s turn on\n',load_type);
        end
        
        % determining event type
        if (phase_b(1) == 0 && phase_b(2) == 0 )
            % no event
            fprintf('\tPhase B - no event\n');
        elseif (phase_b(1) > 0 && phase_b(2) == 0)
            % turn off
            load_type = string(load_str(phase_b(1)+1));
            fprintf('\tPhase B - %s turn off\n',load_type);
        elseif (phase_b(1)== 0 && phase_b(2) > 0)
            % turn on
            load_type = string(load_str(phase_b(2)+1));
            fprintf('\tPhase B - %s turn on\n',load_type);
        end
        
        % determining event type
        if (phase_c(1) == 0 && phase_c(2) == 0 )
            % no event
            fprintf('\tPhase C - no event\n\n');
        elseif (phase_c(1) > 0 && phase_c(2) == 0)
            % turn off
            load_type = string(load_str(phase_c(1)+1));
            fprintf('\tPhase C - %s turn off\n\n',load_type);
        elseif (phase_c(1)== 0 && phase_c(2) > 0)
            % turn on
            load_type = string(load_str(phase_c(2)+1));
            fprintf('\tPhase C - %s turn on\n\n',load_type);
        end
       
        i = i+6;
        
    end

end
% DESCRIPTION
% This iteratively determines where to start and end pre- and post-transient phase 
% current waveform samples based on the location of the positively-sloped
% zero-crossings of the phase voltage. The current wavefroms must all start 
% at the same reference point (i.e. the voltage phase angle equals 0) to be 
% used in the load detection AI, assuming there is no stochasticity between
% runs.

% CONDITIONS    
%   - the column number of each matrix must corespond to the same dataset
%   across all variables.
%   - thre must be a sufficiently small SNR and sampling frequency such 
%   that the only time a negative value follows a positive value is during
%   a zero-crossing.

% INPUT
%   time        - an nxm maxtrix (n=number of data points in a files, m = number
%               of data files) containing the time stamp of each data point
%               in the directory.
%   Vx          - an nxm matrix containing the phase voltage for each data file
%               in the directory, where x is the phase.

% OUTPUT
%   pre_start   - an 3xm matrix specifying the first point in the pre-transient
%               data samples. row 1 corresponds to phase A, row 2 to phase
%               B, and row 3 to phase c.
%   pre_end   - an 3xm matrix specifying the last point in the post-transient
%               data samples. row 1 corresponds to phase A, row 2 to phase
%               B, and row 3 to phase c.
%   post_start   - an 3xm matrix specifying the first point in the post-transient
%               data samples. row 1 corresponds to phase A, row 2 to phase
%               B, and row 3 to phase c.
%   post_end   - an 3xm matrix specifying the last point in the post-transient
%               data samples. row 1 corresponds to phase A, row 2 to phase
%               B, and row 3 to phase c.

function [pre_start,pre_end,post_start,post_end]=get_crossings(time,Va,Vb,Vc)
    [numIndices, numFiles] = size(time); % each column represents a dataset
    T = 2; % number of periods to use
    n = 256; % samples per cycle
    delta_n = T*n-1; % number of indecies between start and end crossings
    
    pre_start = zeros(3, numFiles); % first positive value after first 
                                      % positively-sloped zero crossing
    pre_end = zeros(3, numFiles); % first positive value after first 
                                      % positively-sloped zero crossing
    post_start = zeros(3, numFiles); % first positive value after first 
                                      % positively-sloped zero crossing
    post_end = zeros(3, numFiles); % first positive value after first 
                                      % positively-sloped zero crossing
                                      
    % assuring votlage probes are polarized correctly
    if (Va(2)<0)
        Va = -Va;
        Vb = -Vb;
        Vc = -Vc;
    end
    
    % PRE-TRANSIENT - find first positively-sloped zero crossing, store
    % index in pre_start, and store index+delta_n in pre_stop
    for n = 1:numFiles
        
        % iteratively search through each column checking where a negative
        % value is adjacent to a postive value.
        lastV = [Va(1,n), Vb(1,n), Vc(1,n)]; % latter of the two adjacent
                                            % voltage values to check
        
        found_v = 0; % number of phases for which the sampling interval has
                    % has been determined       
        for i = 2:numIndices-1
            curV = [Va(i,n), Vb(i,n), Vc(i,n)]; % former of the two adjacent
                                                % voltage values to check
            nextV = [Va(i+1,n),Vb(i+1,n),Vc(i+1,n)];
            
            for phase=1:3
                if(curV(phase)>0 && lastV(phase)<=0)
                    if(pre_start(phase,n) == 0)
                        if (nextV(phase) > 0) % in the event noise crosses the time axis
                            pre_start(phase,n) = i;
                            pre_end(phase,n) = i+delta_n;
                            found_v = found_v + 1;
                            continue;
                        end
                    end
                end
            end
            
            % go to next dataset if sampling interval has been determined
            % for all three phases
            if (found_v == 3)
                continue;
            end
            
            lastV = curV;
        end
    end
    
    % POST-TRANSIENT - find third positively-sloped zero-crossing from the
    % end, ignoring zero-padding at end of columns and storing
    % index in pre_start and index+delta_n in pre_stop.
    for n = 1:numFiles
        
        % iteratively search through each column checking where a negative
        % value is adjacent to a postive value.
        lastV = [Va(end,n), Vb(end,n), Vc(end,n)]; % latter of the two adjacent
                                                % voltage values to check
        num_crossing = [0,0,0]; % number of zero-crossings encountered so far 
                                % for each phase
        found_v = 0; % number of phases for which the sampling interval has
                    % has been determined    
        
        for j = 1:(numIndices-2)
            i = numIndices - j;
            curV = [Va(i,n), Vb(i,n), Vc(i,n)]; % former of the two adjacent
                                                % voltage values to check
            nextV = [Va(i-1,n),Vb(i-1,n),Vc(i-1,n)];
            
            for phase=1:3
                if(curV(phase)==0 && lastV(phase)==0) % ignoring zero-padding
                    continue;
                elseif(curV(phase)<=0 && lastV(phase)>0)
                    if(post_end(phase,n) == 0)
                        if (nextV(phase) < 0) % in the event noise crosses the time axis
                            if(num_crossing(phase) == 2)
                                post_start(phase,n) = i+1;
                                post_end(phase,n) = post_start(phase,n)+delta_n;
                                found_v = found_v + 1;
                                continue;
                            else
                                num_crossing(phase) = num_crossing(phase)+1;
                            end
                        end
                    end
                end
            end
            
            % go to next dataset if sampling interval has been determined
            % for all three phases
            if (found_v == 3)
                continue;
            end
            
            lastV = curV;
        end
    end
end
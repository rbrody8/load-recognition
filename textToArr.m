% DESCIPTION
%   This funciton will read all of the data from each .txt file in data_dir
%   and sort the data into the matricies explained in 'OUTPUT'.

% CONDITIONS    
%   - data_dir must be a valid directory with properly formatted text files
%   according to text_export.aes using DranView 7

% INPUT
%   data_dir    - directory of the data to be 

% OUTPUT
%   time        - an nxm maxtrix (n=number of data points in a files, m = number
%               of data files) containing the time stamp of each data point
%               in the directory
%   Vx          - an nxm matrix containing the phase voltage for each data file
%               in the directory, where x is the phase
%   Ix          - an nxm matrix containing the phase current for each data file
%               in the directory, where x is the phase
%   cycles      - contains the indecies that mark the end of a half cycle for
%               each data file
%   listing     - struct containing the contents of the current directory

function [time, Va, Vb, Vc, Ia, Ib, Ic, cycles, listing] = textToArr(data_dir)
    
    % changing cwd to data_dir
    cur_dir = pwd;
    cd(data_dir);
    
    % getting contents of current working directory
    listing = dir('*.txt');
    [numFiles, columns] = size(listing); % number of text files in cwd
    
    % extracting contents of each files in cwd iteratively
    for(n = 1:numFiles)
        %opening a file
        fileID = fopen(listing(n).name, 'r');

        %reading the file line by line
        row = 1;
        cycleNum = 1;
        fgets(fileID); % skipping first 2 lines 
        fgets(fileID); % skipping first 2 lines
        line = fgets(fileID); % first line of data
        while (line ~= -1) % continue to EOF
            if(ismember(line,string(char([13,10]))) == 0) % skip blank lines

                tokens = split(line,','); % splitting comma-seperated values
                
                % if any token is not a double, the dranetz has detected
                % that a half cycle has completed and prints RMS values for
                % that half cycle and the index at which the cycle ends.
                % this index is saved in the cycle array, but the RMS
                % values are of no use to us
                if isnan(double(tokens(3))) || isnan(double(tokens(4)))||...
                    isnan(double(tokens(5)))|| isnan(double(tokens(6)))||...
                    isnan(double(tokens(7)))|| isnan(double(tokens(8)))
                        cycles(cycleNum,n) = row;
                        cycleNum = cycleNum+1;
                else
                    % storing needed values
                    time(row,n) = double(tokens(2)); % time (nanoseconds)
                    Va(row,n) = double(tokens(3)); % Phase A voltage (V)
                    Vb(row,n) = double(tokens(4)); % Phase B voltage (V)
                    Vc(row,n) = double(tokens(5)); % Phase C voltage (V)
                    Ia(row,n) = double(tokens(6)); % Phase A current (A)
                    Ib(row,n) = double(tokens(7)); % Phase B current (A)
                    Ic(row,n) = double(tokens(8)); % Phase C current (A)
                    
                    row=row+1;
                end
            end
            
            % getting next line
            line = fgets(fileID);

        end
        
        % closing file
        fclose(fileID);
    end
    
    % changing directory back to what it was when function was called
    cd(cur_dir);
end
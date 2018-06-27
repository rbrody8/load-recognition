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
                
                % 6/27/2018 - it was discovered that some data files were
                % erroneously seperated by tabs instead of by commans.
                % Rather than recolleting data, this if statement serves as
                % error checking for those data files:
                % 1) see if seperating by commas generated expected number
                % of tokens
                % 2) split line by tabs (char(9) = ASCII tab
                % 3) realign time stamp in array, as that field is still
                % comma-seperated
                if (length(tokens) == 2) % 1)
                    tokens = split(line,char(9)); % 2)
                    
                    % 3)
                    temp = split(tokens(1),',');
                    tokens(1) = temp(2);
                    tokens(2:(end+1))= tokens(:);
                end
                
                % if any token is not a double, the dranetz has detected
                % that a half cycle has completed and prints RMS values for
                % that half cycle and the index at which the cycle ends.
                % this index is saved in the cycle array, but the RMS
                % values are of no use to us
                if isnan(str2double(tokens(3))) ||...
                    isnan(str2double(tokens(4)))||...
                    isnan(str2double(tokens(5)))||...
                    isnan(str2double(tokens(6)))||...
                    isnan(str2double(tokens(7)))||...
                    isnan(str2double(tokens(8)))
                        cycles(cycleNum,n) = row;
                        cycleNum = cycleNum+1;
                else
                    % storing needed values
                    time(row,n) = str2double(tokens(2)); % time (nanoseconds)
                    Va(row,n) = str2double(tokens(3)); % Phase A voltage (V)
                    Vb(row,n) = str2double(tokens(4)); % Phase B voltage (V)
                    Vc(row,n) = str2double(tokens(5)); % Phase C voltage (V)
                    Ia(row,n) = str2double(tokens(6)); % Phase A current (A)
                    Ib(row,n) = str2double(tokens(7)); % Phase B current (A)
                    Ic(row,n) = str2double(tokens(8)); % Phase C current (A)
                    
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
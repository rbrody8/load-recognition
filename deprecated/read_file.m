%%
% this is a helpfer function for textToStruct and textToArr
% it reads the data from a file specified by fileID and sorts the contents
% of the file into appropriate arrays
%%
function [time,Va,Vb,Vc,Ia,Ib,Ic,cycles] = read_file(fileID)
    fgets(fileID);
    fgets(fileID);
    line = fgets(fileID);
    i = 1;
    j = 1;
    while (line ~= -1) % has next line
        if(ismember(line,string(char([13,10]))) == 0) % skip blank lines

            tokens = split(line,','); % splitting comma-seperated values

            if isnan(double(tokens(3))) || isnan(double(tokens(4)))||...
                isnan(double(tokens(5)))|| isnan(double(tokens(6)))||...
                isnan(double(tokens(7)))|| isnan(double(tokens(8)))
                    % end of cycle - Dranetz prints RMS values
                    cycles(j) = i;
                    j = j+1;
            else
                % storing needed values
                time(i) = double(tokens(2)); % time (nanoseconds)
                Va(i) = double(tokens(3)); % Phase A voltage (V)
                Vb(i) = double(tokens(4)); % Phase B voltage (V)
                Vc(i) = double(tokens(5)); % Phase C voltage (V)
                Ia(i) = double(tokens(6)); % Phase A current (A)
                Ib(i) = double(tokens(7)); % Phase B current (A)
                Ic(i) = double(tokens(8)); % Phase C current (A)

                i=i+1;
            end
        end
        line = fgets(fileID);
    end
end
function [waveforms] = textToStruct()
    r_class = [10, 10, 10;
            11, 11, 11;
            10, 00, 00;
            11, 00, 00;
            00, 10, 00;
            00, 11, 00;
            00, 00, 10;
            00, 00, 11;];
    c_class = [20, 20, 20;
            21, 21, 21;
            20, 00, 00;
            21, 00, 00;
            00, 20, 00;
            00, 21, 00;
            00, 00, 20;
            00, 00, 21;];
    l_class = [30, 30, 30;
            31, 31, 31;
            30, 00, 00;
            31, 00, 00;
            00, 30, 00;
            00, 31, 00;
            00, 00, 30;
            00, 00, 31;];
    cfl_class = [40, 40, 40;
            41, 41, 41;];
            
    % getting all R data
    clear listing;
    listing = dir('R*.txt');
    [numFiles, columns] = size(listing); % number of R text files in cwd
    
    % extracting contents of each R files in cwd
    for (n = 1:numFiles)
        clear time Va Vb Vc Ia Ib Ic cycles current_file;
        % opening a file
        fileID = fopen(listing(n).name, 'r');
        
        % reading the file line by line, skipping first 2 lines
        [time,Va,Vb,Vc,Ia,Ib,Ic,cycles] = read_file(fileID);
        
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(m==1 || m==3)
            classifier = r_class(1,:);
        elseif(m==2 || m==4)
            classifier = r_class(2,:);
        else
            classifier = r_class(m-2,:);
        end
        
        current_file = struct('time',time,'Va',Va,'Vb',Vb,'Vc',Vc,'Ia',Ia,'Ib',Ib,'Ic',Ic,'cycles',cycles,'classifier',classifier);
        waveforms.(listing(n).name(1:end-4)) = current_file;
        fclose(fileID);
    end
    
    % getting all C data
    clear listing;
    listing = dir('C_*.txt');
    [numFiles, columns] = size(listing); % number of C text files in cwd
    
    % extracting contents of each C files in cwd
    for(n = 1:numFiles)
        clear time Va Vb Vc Ia Ib Ic cycles current_file;
        % opening a file
        fileID = fopen(listing(n).name, 'r');
        
        % reading the file line by line, skipping first 2 lines
        [time,Va,Vb,Vc,Ia,Ib,Ic,cycles] = read_file(fileID);
        
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(m==1 || m==3)
            classifier = c_class(1,:);
        elseif(m==2 || m==4)
            classifier = c_class(2,:);
        else
            classifier = c_class(m-2,:);
        end
        
        current_file = struct('time',time,'Va',Va,'Vb',Vb,'Vc',Vc,'Ia',Ia,'Ib',Ib,'Ic',Ic,'cycles',cycles,'classifier',classifier);
        waveforms.(listing(n).name(1:end-4)) = current_file;
        fclose(fileID);
    end
    
    % getting all L data
    clear listing;
    listing = dir('L*.txt');
    [numFiles, columns] = size(listing); % number of L text files in cwd
    
    % extracting contents of each L files in cwd
    for(n = 1:numFiles)
        clear time Va Vb Vc Ia Ib Ic cycles current_file;
        % opening a file
        fileID = fopen(listing(n).name, 'r');
        
        % reading the file line by line, skipping first 2 lines
        [time,Va,Vb,Vc,Ia,Ib,Ic,cycles] = read_file(fileID);
        
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(m==1 || m==3)
            classifier = l_class(1,:);
        elseif(m==2 || m==4)
            classifier = l_class(2,:);
        else
            classifier = l_class(m-2,:);
        end
        
        current_file = struct('time',time,'Va',Va,'Vb',Vb,'Vc',Vc,'Ia',Ia,'Ib',Ib,'Ic',Ic,'cycles',cycles,'classifier',classifier);
        waveforms.(listing(n).name(1:end-4)) = current_file;
        fclose(fileID);
    end
    
      % getting all CFL data
    clear listing;
    listing = dir('CFL*.txt');
    [numFiles, columns] = size(listing); % number of CFL text files in cwd
    
    % extracting contents of each CFL files in cwd
    for(n = 1:numFiles)
        clear time Va Vb Vc Ia Ib Ic cycles current_file;
        % opening a file
        fileID = fopen(listing(n).name, 'r');
        
        % reading the file line by line, skipping first 2 lines
        [time,Va,Vb,Vc,Ia,Ib,Ic,cycles] = read_file(fileID);
        
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(mod(m,2)==1)
            cfl = cfl_class(1,:);
        elseif(mod(m,2)==0)
            cfl = cfl_class(2,:);
        end
    end
end
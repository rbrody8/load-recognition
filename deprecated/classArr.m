function [classify] = classArr()
    r_class = [10, 10, 10;
            11, 11, 11;
            10, 00, 00;
            11, 00, 00;
            00, 10, 00;
            00, 11, 00;
            00, 00, 10;
            00, 00, 11;]';
    c_class = [20, 20, 20;
            21, 21, 21;
            20, 00, 00;
            21, 00, 00;
            00, 20, 00;
            00, 21, 00;
            00, 00, 20;
            00, 00, 21;]';
    l_class = [30, 30, 30;
            31, 31, 31;
            30, 00, 00;
            31, 00, 00;
            00, 30, 00;
            00, 31, 00;
            00, 00, 30;
            00, 00, 31;]';
    cfl_class = [40, 40, 40;
            41, 41, 41;]';
            
    % getting all R data
    clear listing;
    listing = dir('R*.txt');
    [numFiles, columns] = size(listing); % number of R text files in cwd
    
    % extracting contents of each R files in cwd
    for (n = 1:numFiles)        
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(m==1 || m==3)
            r(:,n) = r_class(:,1);
        elseif(m==2 || m==4)
            r(:,n) = r_class(:,2);
        else
            r(:,n) = r_class(:,m-2);
        end
    end
    
    % getting all C data
    clear listing;
    listing = dir('C_*.txt');
    [numFiles, columns] = size(listing); % number of C text files in cwd
    
    % extracting contents of each C files in cwd
    for(n = 1:numFiles)
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(m==1 || m==3)
            c(:,n) = c_class(:,1);
        elseif(m==2 || m==4)
            c(:,n) = c_class(:,2);
        else
            c(:,n) = c_class(:,m-2);
        end
    end
    
    % getting all L data
    clear listing;
    listing = dir('L*.txt');
    [numFiles, columns] = size(listing); % number of L text files in cwd
    
    % extracting contents of each L files in cwd
    for(n = 1:numFiles)
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(m==1 || m==3)
            l(:,n) = l_class(:,1);
        elseif(m==2 || m==4)
            l(:,n) = l_class(:,2);
        else
            l(:,n) = l_class(:,m-2);
        end
    end
    
      % getting all CFL data
    clear listing;
    listing = dir('CFL*.txt');
    [numFiles, columns] = size(listing); % number of CFL text files in cwd
    
    % extracting contents of each CFL files in cwd
    for(n = 1:numFiles)
        % classifier:   1st digit corresponds to type of device
        %               2nd digit corresponds to turn on/turn off
        tokens = split(listing(n).name, 't');
        m = str2double(tokens(2))
        if(mod(m,2)==1)
            cfl(:,n) = cfl_class(:,1);
        elseif(mod(m,2)==0)
            cfl(:,n) = cfl_class(:,2);
        end
    end
    
    classify = [cfl,c,l,r];
end
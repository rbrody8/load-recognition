
[r_num,c_num] = size(class);
new_class = zeros(c_num*6,1);
i=1;
k=1;
    for j = 1:c_num
        if(mod(class(1,j),2)==0)
            %turn on
            new_class(k,1) = 0; % everything off
            new_class(k+1,1) = (class(i,j)-mod(class(i,j),10))/10;
        else
            
            new_class(k+2,1) = 0; % everything off
            new_class(k+3,1) = (class(i+1,j)-mod(class(i+1,j),10))/10;
            
            new_class(k+4,1) = 0; % everything off
            new_class(k+5,1) = (class(i+2,j)-mod(class(i+2,j),10))/10;
            k = k+6;
        else
            %turn off
            new_class(k,1) = (class(i,j)-mod(class(i,j),10))/10;
            new_class(k+1,1) = 0;
            new_class(k+2,1) = (class(i+1,j)-mod(class(i+1,j),10))/10;
            new_class(k+3,1) = 0;
            new_class(k+4,1) = (class(i+2,j)-mod(class(i+2,j),10))/10;
            new_class(k+5,1) = 0;
            k = k+6;
        end
    end 
[r,c] = size(I);
for i = 1:c
   test_current = I(1:1:end,i);
   test_current = test_current(1:find(test_current,1,'last'));
   test_time = time_all(1:1:end,i);
   test_time = test_time(1:length(test_current));
   
   del_t = test_time(2)-test_time(1);
%    del_t = del_t*10^-9;
   
%    std_start = std(test_current(15:12));
%    std_end = std(test_current((end-512):end));
   %threshold = min(std_start,std_end)*2
   threshold = 0.1;
   [t_start,t_end] = detect_events(test_current,del_t,threshold);
   
   %pause;
end
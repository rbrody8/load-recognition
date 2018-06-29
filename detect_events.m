%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encoding of this algorithm was guided by the algorithm formulated in:
%   M. Nait Meziane, P. Ravier, G. Lamarque, J. C. Le Bunetel and Y. Raingeaud, 
%       "High accuracy event detection for Non-Intrusive Load Monitoring," 
%       2017 IEEE International Conference on Acoustics, Speech and Signal 
%       Processing (ICASSP), New Orleans, LA, 2017, pp. 2452-2456.
%   doi: 10.1109/ICASSP.2017.7952597
%   keywords: {signal detection;appliance clustering;event detection algorithm;
%               event-based NILM systems;global electrical energy consumption;
%               individual appliances consumption;non-intrusive load monitoring;
%               signal envelope;Detectors;Event detection;Monitoring;
%               Signal to noise ratio;Standards;Steady-state;Event detection;
%               Non-Intrusive Load Monitoring (NILM);energy disaggregation;
%               event-based NILM;unsupervised NILM},
%   URL: http://ieeexplore.ieee.org.pitt.idm.oclc.org/stamp/stamp.jsp?tp=&arnumber=7952597&isnumber=7951776
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t_start, t_end]=detect_events(time_series, delta_t, threshold)

% Notes
% - gamma is the change threshold and is equal to the std of system noise
% - we will treat this as a discrete signal, as opposed to continuous time
% - window delay correction is a factor of (L-1), as opposed to L, in step 6
% - seems like different thresholds are needed for different loads

% Variables
f = 60;  % Hz
T = 1/f; % s
n_cycle = 256; % # points per cycle
N = length(time_series);

% step 1) get envelope from input discrete-time series
[envelope,envelope_index] = get_envelope(time_series, n_cycle,N);

% step 2) fix moving window size
L = 4; % cycles in window

% step 3) initializing window statistics
k=1;
N_env = length(envelope);
window_mean = zeros(1,N_env);
window_std = zeros(1,N_env);
for k=1:L
   window = envelope(1:k);
   window_mean(k) = mean(window);
   window_std(k) = std(window);
end

% step 4) iteratively compute statistics - i.e. application of equation (1)
for k = (L+1):N_env
    window_mean(k) = window_mean(k-1) + (1/L)*(envelope(k)-envelope(k-L));
    window_std(k) = sqrt(window_std(k-1)^2 + (1/(L-1))*(envelope(k)^2 - envelope(k-L)^2)...
        + (L/(L-1))*(window_mean(k-1)^2 - window_mean(k)^2));
end

% step 5) choose a threshold and find starting/stopping times
%std_diff = diff(window_std);
t_start = -1;
t_end = -1;
%for k = 2:N_env
for k = 1:N_env
    %if(window_std(k)>threshold &&  std_diff(k-1)>0 && t_start<0)
    if(window_std(k)>threshold &&  t_start<0)
        t_start = k;
    end
    
    %if(window_std(k)>threshold && std_diff(k-1)<0)
    if(window_std(k)>threshold && t_start>0)
        t_end = k;
    end
end

% step 6) post-processing: event approval and window delay correction
if (t_start>0 && t_end>0)
    for i=t_start:t_end
        if (window_std(i)<=threshold)
            t_start = -1;
            t_end = -1;
        end
    end
end

if(t_start>0)
    t_start=envelope_index(t_start);
end
if(t_end>0)
    t_end=envelope_index(t_end-(L-1));
end

plot(time_series)
hold on;
plot(envelope_index,envelope);
if (t_start>0)
    plot(t_start,time_series(t_start),'o');
end
if (t_end>0)
   plot(t_end,time_series(t_end),'o');
end
hold off;

end
function [envelope,envelope_index] = get_envelope(time_series,n_cycle,N)
    num_peaks = floor(N/n_cycle);
    envelope = zeros(1,num_peaks);
    envelope_index = zeros(1,num_peaks);
    
    i = 1;
    p = 1;
    for p = 1:num_peaks
        if ((i+n_cycle-1)<N)
            sample = time_series(i:(i+n_cycle));
        else
            sample = time_series(i:end);
        end
        [envelope(p),envelope_index(p)] = max(sample);
        envelope_index(p)=envelope_index(p)+i-1;
        i = i+n_cycle;
    end

end
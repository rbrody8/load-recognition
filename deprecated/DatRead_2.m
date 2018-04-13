% AUTHORS:          ADAM EMES AND RYAN BRODY
% LAST UPDATED:     04/02/2018
%
% DESCRIPTION:      This script takes voltage and current waveform data,
% collected by the Dranetz PowerVisa meter, and performs a series of
% calculations. The phase angles for each phase are calculated by looking
% at differences in peak voltages for each cycle (for now). The steady
% state real and reactive power is then calculated for each waveform. The
% eventual goal is to compare changes in steady state power before and
% after transient events to determine the type of loads currently present
% in the power system.
%
% INPUTS: None - but need to run 'textToArr.m' before running this script

%% 

clear all
close all
clc

% Loading data file produced by 'textToArr.m' into the workspace
load('data_v8.mat')

[rows, cols] = size(cycles);

% System inputs
f = 60;              % frequency (Hz)
T = 1/f*10^9;        % Period (ns)

%% POWER CALCULATIONS FROM V AND I DATA

for k = 1:cols

    % Increment points for one cycle (before transient)
    Cstart1 = cycles(2,k);
    Cend1 = cycles(4,k);
    % Increment points for one cycle (after transient)
    Cstart2 = cycles(16,k);
    Cend2 = cycles (18,k);
    % Filtering voltage and current waveforms (cut off at 60 Hz)
    spc = Cend1-Cstart1;             % samples per cycle
    f_samp = 2*spc/(T*10^-9);   % Nyquist sampling frequency (Hz)
    f_cut = 360;              % desired cutoff frequency (Hz)
    Wn = f_cut/f_samp;       % normalized cut-off frequency
    [b,a] = butter(2, Wn);   % butterworth filter coefficients
    Va_filt(:,k) = filter(b,a,Va(:,k));
    Vb_filt(:,k) = filter(b,a,Vb(:,k));
    Vc_filt(:,k) = filter(b,a,Vc(:,k));
    Ia_filt(:,k) = filter(b,a,Ia(:,k));
    Ib_filt(:,k) = filter(b,a,Ib(:,k));
    Ic_filt(:,k) = filter(b,a,Ic(:,k));
    % Determining index locations for peak values
    % Pre transient
    i1 = find(Va_filt(Cstart1:Cend1,k) == max(Va_filt(Cstart1:Cend1,k)));
    i2 = find(Vb_filt(Cstart1:Cend1,k) == max(Vb_filt(Cstart1:Cend1,k)));
    i3 = find(Vc_filt(Cstart1:Cend1,k) == max(Vc_filt(Cstart1:Cend1,k)));
    i4 = find(Ia_filt(Cstart1:Cend1,k) == max(Ia_filt(Cstart1:Cend1,k)));
    i5 = find(Ib_filt(Cstart1:Cend1,k) == max(Ib_filt(Cstart1:Cend1,k)));
    i6 = find(Ic_filt(Cstart1:Cend1,k) == max(Ic_filt(Cstart1:Cend1,k)));
    % Post Transient
    i7 = find(Va_filt(Cstart2:Cend2,k) == max(Va_filt(Cstart2:Cend2,k)));
    i8 = find(Vb_filt(Cstart2:Cend2,k) == max(Vb_filt(Cstart2:Cend2,k)));
    i9 = find(Vc_filt(Cstart2:Cend2,k) == max(Vc_filt(Cstart2:Cend2,k)));
    i10 = find(Ia_filt(Cstart2:Cend2,k) == max(Ia_filt(Cstart2:Cend2,k)));
    i11 = find(Ib_filt(Cstart2:Cend2,k) == max(Ib_filt(Cstart2:Cend2,k)));
    i12 = find(Ic_filt(Cstart2:Cend2,k) == max(Ic_filt(Cstart2:Cend2,k)));
    % Simplifying the indexes into an array
    indexes = [i1(1,1)+Cstart1, i2(1,1)+Cstart1, i3(1,1)+Cstart1, i4(1,1)+Cstart1, i5(1,1)+Cstart1, i6(1,1)+Cstart1;
               i7(1,1)+Cstart2, i8(1,1)+Cstart2, i9(1,1)+Cstart2, i10(1,1)+Cstart2, i11(1,1)+Cstart2, i12(1,1)+Cstart2];
    % Getting time values for maximum values
    for i = 1:2
        t_Vap(i,k) = time(indexes(i,1));
        t_Vbp(i,k) = time(indexes(i,2));
        t_Vcp(i,k) = time(indexes(i,3));
        t_Iap(i,k) = time(indexes(i,4));
        t_Ibp(i,k) = time(indexes(i,5));
        t_Icp(i,k) = time(indexes(i,6));
        % Calculating the phase angles
        Pha(i,k) = (t_Vap(i,k)-t_Iap(i,k))/T*360;      % Phase A (degree)
        Phb(i,k) = (t_Vbp(i,k)-t_Ibp(i,k))/T*360;      % Phase B (degree)
        Phc(i,k) = (t_Vcp(i,k)-t_Icp(i,k))/T*360;      % Phase C (degree)
    end
    % Calculating RMS values for V and I
    % initializing variables for loop
    for i = 1:2
        Va_rms_SQ(i,k) = 0;
        Vb_rms_SQ(i,k) = 0;
        Vc_rms_SQ(i,k) = 0;
        Ia_rms_SQ(i,k) = 0;
        Ib_rms_SQ(i,k) = 0;
        Ic_rms_SQ(i,k) = 0;
    end
    % Pre-transient
    for ii = Cstart1:Cend1
        Va_rms_SQ(1,k) = (Va(ii,k)).^2./(Cend1-Cstart1) + Va_rms_SQ(1,k);
        Vb_rms_SQ(1,k) = (Vb(ii,k)).^2./(Cend1-Cstart1) + Vb_rms_SQ(1,k);
        Vc_rms_SQ(1,k) = (Vc(ii,k)).^2./(Cend1-Cstart1) + Vc_rms_SQ(1,k);
        Ia_rms_SQ(1,k) = (Ia(ii,k)).^2./(Cend1-Cstart1) + Ia_rms_SQ(1,k);
        Ib_rms_SQ(1,k) = (Ib(ii,k)).^2./(Cend1-Cstart1) + Ib_rms_SQ(1,k);
        Ic_rms_SQ(1,k) = (Ic(ii,k)).^2./(Cend1-Cstart1) + Ic_rms_SQ(1,k);
    end
    % Post-transient
    for ii = Cstart2:Cend2
        Va_rms_SQ(2,k) = (Va(ii,k)).^2./(Cend2-Cstart2) + Va_rms_SQ(2,k);
        Vb_rms_SQ(2,k) = (Vb(ii,k)).^2./(Cend2-Cstart2) + Vb_rms_SQ(2,k);
        Vc_rms_SQ(2,k) = (Vc(ii,k)).^2./(Cend2-Cstart2) + Vc_rms_SQ(2,k);
        Ia_rms_SQ(2,k) = (Ia(ii,k)).^2./(Cend2-Cstart2) + Ia_rms_SQ(2,k);
        Ib_rms_SQ(2,k) = (Ib(ii,k)).^2./(Cend2-Cstart2) + Ib_rms_SQ(2,k);
        Ic_rms_SQ(2,k) = (Ic(ii,k)).^2./(Cend2-Cstart2) + Ic_rms_SQ(2,k);
    end
    for i = 1:2
        % Finishing RMS calculation
        Va_rms(i,k) = sqrt(Va_rms_SQ(i,k));
        Vb_rms(i,k) = sqrt(Vb_rms_SQ(i,k));
        Vc_rms(i,k) = sqrt(Vc_rms_SQ(i,k));
        Ia_rms(i,k) = sqrt(Ia_rms_SQ(i,k));
        Ib_rms(i,k) = sqrt(Ib_rms_SQ(i,k));
        Ic_rms(i,k) = sqrt(Ic_rms_SQ(i,k));
        
        % Calculating Real and Reactive Power for each phase
        Pa(i,k) = Va_rms(i,k)*Ia_rms(i,k)*cosd(Pha(i,k));
        Pb(i,k) = Vb_rms(i,k)*Ib_rms(i,k)*cosd(Phb(i,k));
        Pc(i,k) = Vc_rms(i,k)*Ic_rms(i,k)*cosd(Phc(i,k));
        Qa(i,k) = Va_rms(i,k)*Ia_rms(i,k)*sind(Pha(i,k));
        Qb(i,k) = Vb_rms(i,k)*Ib_rms(i,k)*sind(Phb(i,k));
        Qc(i,k) = Vc_rms(i,k)*Ic_rms(i,k)*sind(Phc(i,k));
    end
    % calculating delta P and delta Q for each event
    delt_Pa(1,k) = Pa(1,k) - Pa(2,k);
    delt_Pb(1,k) = Pb(1,k) - Pb(2,k);
    delt_Pc(1,k) = Pc(1,k) - Pc(2,k);
    delt_Qa(1,k) = Qa(1,k) - Qa(2,k);
    delt_Qb(1,k) = Qb(1,k) - Qb(2,k);
    delt_Qc(1,k) = Qc(1,k) - Qc(2,k);
%     % Alternate power calculation (PF = Pavg/VrmsIrms)
%     % Pre-transient
%     Pa_avg(1,k) = mean(Va_filt(Cstart1:Cend1,k).*Ia_filt(Cstart1:Cend1,k));
%     Pb_avg(1,k) = mean(Vb_filt(Cstart1:Cend1,k).*Ib_filt(Cstart1:Cend1,k));
%     Pc_avg(1,k) = mean(Vc_filt(Cstart1:Cend1,k).*Ic_filt(Cstart1:Cend1,k));
%     % Post-transient
%     Pa_avg(2,k) = mean(Va_filt(Cstart2:Cend2,k).*Ia_filt(Cstart2:Cend2,k));
%     Pb_avg(2,k) = mean(Vb_filt(Cstart2:Cend2,k).*Ib_filt(Cstart2:Cend2,k));
%     Pc_avg(2,k) = mean(Vc_filt(Cstart2:Cend2,k).*Ic_filt(Cstart2:Cend2,k));
%     % Reactive power
%     for i = 1:2
%         PF_a(i,k) = Pa_avg(i,k)/(Va_rms(i,k)*Ia_rms(i,k));
%         PF_b(i,k) = Pb_avg(i,k)/(Vb_rms(i,k)*Ib_rms(i,k));
%         PF_c(i,k) = Pc_avg(i,k)/(Vc_rms(i,k)*Ic_rms(i,k));
%         Th_a(i,k) = acos(PF_a(i,k));
%         Th_b(i,k) = acos(PF_b(i,k));
%         Th_c(i,k) = acos(PF_c(i,k));
%         
%         Qa_avg(i,k) = Va_rms(i,k)*Ia_rms(i,k)*sin(Th_a(i,k));
%         Qb_avg(i,k) = Vb_rms(i,k)*Ib_rms(i,k)*sin(Th_b(i,k));
%         Qc_avg(i,k) = Vc_rms(i,k)*Ic_rms(i,k)*sin(Th_c(i,k));
%     end    
    
    % calculating FFT for each V and I waveform
    % Pre-transient
    L1 = Cend1-Cstart1;
    Fs1 = L1*60;
    freq_1(1:L1/2+1,k) = Fs1*(0:(L1/2))/L1;
    
    VaFFT_1(1:L1+1,k) = fft(Va(1:L1+1,k));
    VbFFT_1(1:L1+1,k) = fft(Vb(1:L1+1,k));
    VcFFT_1(1:L1+1,k) = fft(Vc(1:L1+1,k));
    IaFFT_1(1:L1+1,k) = fft(Ia(1:L1+1,k));
    IbFFT_1(1:L1+1,k) = fft(Ib(1:L1+1,k));
    IcFFT_1(1:L1+1,k) = fft(Ic(1:L1+1,k));
    
    % PHASE A
    P2_Va1 = abs(VaFFT_1(1:L1+1,k)/L1);
    P1_Va1 = P2_Va1(1:L1/2+1);
    P1_Va1(2:end-1,k) = 2*P1_Va1(2:end-1); % Plot this variable vs. "freq_1" for amplitude spectrum
    
    P2_Ia1 = abs(IaFFT_1(1:L1+1,k)/L1);
    P1_Ia1 = P2_Ia1(1:L1/2+1);
    P1_Ia1(2:end-1,k) = 2*P1_Ia1(2:end-1); % Plot this variable vs. "freq_1" for amplitude spectrum
    
    % PHASE B
    P2_Vb1 = abs(VbFFT_1(1:L1+1,k)/L1);
    P1_Vb1 = P2_Vb1(1:L1/2+1);
    P1_Vb1(2:end-1,k) = 2*P1_Vb1(2:end-1); % Plot this variable vs. "freq_1" for amplitude spectrum
    
    P2_Ib1 = abs(IbFFT_1(1:L1+1,k)/L1);
    P1_Ib1 = P2_Ib1(1:L1/2+1);
    P1_Ib1(2:end-1,k) = 2*P1_Ib1(2:end-1); % Plot this variable vs. "freq_1" for amplitude spectrum
    
    % PHASE C
    P2_Vc1 = abs(VcFFT_1(1:L1+1,k)/L1);
    P1_Vc1 = P2_Vc1(1:L1/2+1);
    P1_Vc1(2:end-1,k) = 2*P1_Vc1(2:end-1); % Plot this variable vs. "freq_1" for amplitude spectrum
    
    P2_Ic1 = abs(IcFFT_1(1:L1+1,k)/L1);
    P1_Ic1 = P2_Ic1(1:L1/2+1);
    P1_Ic1(2:end-1,k) = 2*P1_Ic1(2:end-1); % Plot this variable vs. "freq_1" for amplitude spectrum
    
    % Post-transient
    L2 = Cend2-Cstart2;
    Fs2 = L2*60;
    freq_2(1:L2/2+1,k) = Fs2*(0:(L2/2))/L2;
    
    VaFFT_2(1:L2+1,k) = fft(Va(1:L2+1,k));
    VbFFT_2(1:L2+1,k) = fft(Vb(1:L2+1,k));
    VcFFT_2(1:L2+1,k) = fft(Vc(1:L2+1,k));
    IaFFT_2(1:L2+1,k) = fft(Ia(1:L2+1,k));
    IbFFT_2(1:L2+1,k) = fft(Ib(1:L2+1,k));
    IcFFT_2(1:L2+1,k) = fft(Ic(1:L2+1,k));
    
    % PHASE A
    P2_Va2 = abs(VaFFT_2(1:L2+1,k)/L2);
    P1_Va2 = P2_Va2(1:L2/2+1);
    P1_Va2(2:end-1,k) = 2*P1_Va2(2:end-1);
    
    P2_Ia2 = abs(IaFFT_2(1:L2+1,k)/L2);
    P1_Ia2 = P2_Ia2(1:L2/2+1);
    P1_Ia2(2:end-1,k) = 2*P1_Ia2(2:end-1);

    % PHASE B
    P2_Vb2 = abs(VbFFT_2(1:L2+1,k)/L2);
    P1_Vb2 = P2_Vb2(1:L2/2+1);
    P1_Vb2(2:end-1,k) = 2*P1_Vb2(2:end-1);
    
    P2_Ib2 = abs(IbFFT_2(1:L2+1,k)/L2);
    P1_Ib2 = P2_Ib2(1:L2/2+1);
    P1_Ib2(2:end-1,k) = 2*P1_Ib2(2:end-1);
    
    % PHASE C
    P2_Vc2 = abs(VcFFT_2(1:L2+1,k)/L2);
    P1_Vc2 = P2_Vc2(1:L2/2+1);
    P1_Vc2(2:end-1,k) = 2*P1_Vc2(2:end-1);
    
    P2_Ic2 = abs(IcFFT_2(1:L2+1,k)/L2);
    P1_Ic2 = P2_Ic2(1:L2/2+1);
    P1_Ic2(2:end-1,k) = 2*P1_Ic2(2:end-1);

end

% removing not needed/temporary variables
clear i1 i2 i3 i4 i5 i6 i7 i8 i9 i10 i11 i12
clear Va_rms_SQ Vb_rms_SQ Vc_rms_SQ Ia_rms_SQ Ib_rms_SQ Ic_rms_SQ

%% MACHINE LEARNING IMPLEMENTATION

% creating matrix of training data for the machine learning algorithm
diff = pre_end(1,1)-pre_start(1,1);
ii = 1;
training = zeros(diff,6*cols);
for i = 1:cols
    training(1:(diff+1),ii)   = Ia(pre_start(1,i):pre_end(1,i),i);
    training(1:(diff+1),ii+1) = Ia(post_start(1,i):post_end(1,i),i);
    training(1:(diff+1),ii+2) = Ib(pre_start(2,i):pre_end(2,i),i);
    training(1:(diff+1),ii+3) = Ib(post_start(2,i):post_end(2,i),i);
    training(1:(diff+1),ii+4) = Ic(pre_start(3,i):pre_end(3,i),i);
    training(1:(diff+1),ii+5) = Ic(post_start(3,i):post_end(3,i),i);
    
    ii = ii+6;
end
training = training'; % transposing the training matrix to work for "classify"

% creating grouping matrix
[r_num,c_num] = size(class);
new_class = zeros(c_num*6,1);
k=1;
for j = 1:c_num
    if(mod(class(1,j),2)==0)
        %turn on
        new_class(k,1) = 0; % everything off
        new_class(k+1,1) = (class(1,j)-mod(class(1,j),10))/10;
    else
        %turn off
        new_class(k,1) = (class(1,j)-mod(class(1,j),10))/10;
        new_class(k+1,1) = 0;
    end
    
    if(mod(class(2,j),2)==0)
        new_class(k+2,1) = 0; % everything off
        new_class(k+3,1) = (class(2,j)-mod(class(2,j),10))/10;
    else
        new_class(k+2,1) = (class(2,j)-mod(class(2,j),10))/10;
        new_class(k+3,1) = 0;
    end
    
    if(mod(class(3,j),2)==0)
        new_class(k+4,1) = 0; % everything off
        new_class(k+5,1) = (class(3,j)-mod(class(3,j),10))/10;
    else
        new_class(k+4,1) = (class(3,j)-mod(class(3,j),10))/10;
        new_class(k+5,1) = 0;
    end
        k = k+6;
end

test = [Ia(pre_start(1,32):pre_end(1,32),32)'; % 0
        Ic(post_start(3,31):post_end(3,31),31)'; % 3
        Ib(post_start(2,20):post_end(2,20),20)'; % 0
        Ic(post_start(3,21):post_end(3,21),21)'; % 2
        Ib(post_start(2,29):post_end(2,29),29)'; % 3
        Ia(post_start(1,35):post_end(1,35),35)']; % 1
     
CLASS = classify(test,training(67:end,:),new_class(67:end,:),'diaglinear');
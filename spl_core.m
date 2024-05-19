%
%  spl_core.m  ver 1.3  by Tom Irvine
%
%  One-third octave format
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Input variables
%
%     amp = segment amplitude (unit)
%
%        mmm = samples per segment
%         mH = floor((mmm/2)-1) - half the number of samples rounded down
%
%     mr_choice - mean removal - 1=yes  2=no
%      h_choice - 1=rectangular  2=Hanning
%
%         Hanning window recommended for stationary vibration.
%         Use rectangular otherwise.
%
%      df = frequency step
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Output variables
%
%       spl - center frequency(Hz) & spl(dB)
%     oaspl - overall sound pressure level(dB)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    External functions
%
%       fix_size.m
%       FFT_core.m
%       one_third_octave_frequencies.m
%       convert_FFT_to_one_third_rms.m            
%       convert_one_third_octave_mag_to_dB.m
%       trim_acoustic_SPL.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[spl,oaspl]=spl_core(mmm,NW,mr_choice,h_choice,amp,df)
%
    ref = 2.9e-09;  % psi equivalent for 20 micro Pa
    
    dB_ref=20*log10(std(amp)/ref);

    [fl,fc,fu,~]=one_third_octave_frequencies();    
    
%%%  begin overlap
%
    mH=floor((mmm/2)-1);
%
    full=zeros(mH,1);
%
    nov=0;
%
    for ijk=1:(2*NW-1)
%
        amp_seg=zeros(mmm,1);
%
        try 
            amp_seg(1:mmm)=amp((1+ nov):(mmm+ nov));
        catch
            fprintf(' ijk=%d  NW=%d  mmm=%d  nov=%d  length(amp)=%d \n',ijk,NW,mmm,nov,length(amp));
            warndlg(' amp_seg error ');
            return;
        end
%
        nov=nov+fix(mmm/2);
%
        [mag_seg]=FFT_core(amp_seg,mmm,mH,mr_choice,h_choice);
%
        mag_seg=fix_size(mag_seg);
%
        full=full+mag_seg(1:mH);
    end
%
    den=(2*NW-1);
    fmax=(mH-1)*df;
    freq=linspace(0,fmax,mH);
    full=full/den;  % average power spectrum
    
    full_rms=full.^(1/2);
    
    freq=fix_size(freq);
    full_rms=fix_size(full_rms);    
%
    [band_rms,band_dB]=convert_FFT_to_one_third_rms(freq,fl,fu,full_rms,ref);
    
    [pf,pspl,oaspl]=trim_acoustic_SPL(fc,band_dB,ref);
%
    delta=dB_ref-oaspl;
    
    fprintf('\n delta=%7.3g dB\n\n',delta);
    
    pspl=pspl+delta;
    
    [oaspl]=oaspl_function(pspl);
    
    fprintf(' oaspl = %8.4g  dB  ref: 20 micro Pa\n',oaspl);
%
    pf=fix_size(pf);
    pspl=fix_size(pspl);
    spl=[pf pspl];
   
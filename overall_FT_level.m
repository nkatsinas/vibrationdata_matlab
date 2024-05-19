
sz=size(Hanning_ft);

num=sz(1);

c=0;

for i=1:num
    
    peak=Hanning_ft(i,2);   % peak G at each frequency
    rms=peak/sqrt(2);
    ms=rms^2;
    
    c=c+ms;  % running sum of mean square
    
end

overall_rms=sqrt(c) % overall RMS from the Fourier transform
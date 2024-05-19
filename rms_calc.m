

sz=size(white_seg_FFT);

n=sz(1);

ms=0;

for i=1:n
    spectral_rms=white_seg_FFT(i,2)/sqrt(2);
    ms=ms+spectral_rms^2;
end

rms=sqrt(ms)
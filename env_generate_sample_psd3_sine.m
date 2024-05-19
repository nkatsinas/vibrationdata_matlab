%
%   env_generate_sample_psd3_sine.m  ver 1.7   by Tom Irvine
%
%
function[f_sam,apsd_sam,max_sss,slopec,fs_samp,sine_samp]=...
    env_generate_sample_psd3_sine(nbreak,npb,xf,xapsd,slopec,f1,f2,plateau,xfs,xsine)
%

num_sine=length(xsine);

sine_samp=zeros(num_sine,1);
fs_samp=xfs;

for i=1:num_sine
    sine_samp(i)=xsine(i)*(0.93+0.14*rand());
    if(rand()>0.5)
        fs_samp(i)=xfs(i)*(0.996+0.008*rand());
    else
        fs_samp(i)=xfs(i)*(0.99+0.02*rand());        
    end    
end

apsd_sam=xapsd;
f_sam=xf;
max_sss=0;




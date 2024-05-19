%
%   env_generate_sample_psd2_via_vrs_alt.m  ver 1.8   by Tom Irvine
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd2_via_vrs_alt(xf,xapsd)


f_sam=xf;

apsd_sam=xapsd;

for i=1:length(xf)
    apsd_sam(i)=xapsd(i)*(0.95+0.1*rand());
end    
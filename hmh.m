rms=zeros(4,1);

[rms(1)]=hpow('pv_psd_1')
[rms(2)]=hpow('pv_psd_2')
[rms(3)]=hpow('pv_psd_3')
[rms(4)]=hpow('pv_psd_4')


sq=sqrt(sum(rms.^2))

2*51.8*sq

A=rms*2*51.8

sq=sqrt(sum(A.^2))


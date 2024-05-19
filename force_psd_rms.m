
sz=size(force_psd_nb);

force_rms_nb=zeros(sz(1),2);
bw=1;

force_rms_nb(:,1)=force_psd_nb(:,1);

for i=1:sz(1)
    force_rms_nb(i,2)= sqrt(bw*force_psd_nb(i,2));
end 

force_rms_nb


accel_psd=force_rms_nb;

for i=1:sz(1)
    accel_psd(i,2)=(accel_ps(i,2))^2/bw;
end    
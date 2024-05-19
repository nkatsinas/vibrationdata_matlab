
clear apa_rms;
clear apa_peak;
clear d;



% d=trial_2_peak_accel;
d=C4_peak_accel;

sz=size(d);

n=sz(1);

k=1;
for i=1:2:n
    
    apa_rms(k)=norm([ d(i) d(i+1) ]);
    apa_peak(k)=max([ d(i) d(i+1) ]);  
    
    k=k+1;
end


% qualification_spl_to_pressure_psd.m  ver 1.0  by Tom Irvine
% 
% qualification spl has stair-step pattern


clear qual_spl;
clear freq;
clear dB;
clear psd;
clear ppp;
clear bandwidth;


qual_spl=[22 131;
44	131;
44	134;
88	134;
88	138.2;
177	138.2;
177	136.6;
355	136.6;
355	133.3;
710	133.3;
710	129;
1420	129;
1420	123;
2840	123;
2840	119;
5680	119];


freq=qual_spl(:,1);

sz=size(qual_spl);

m=sz(1);
n=m/2;


ref=2.90e-09;   % psi rms 

psd=zeros(m,1);
bandwidth=zeros(n,1);

k=1;

for i=1:2:m-1
    bandwidth(k)=freq(i+1)-freq(i);
    dB(k)=qual_spl(i,2);
    k=k+1;
end  

k=1;

for i=1:2:m-1
   
    psd(i)=(ref*10^(dB(k)/20))^2/bandwidth(k);
    psd(i+1)=psd(i);
    
    k=k+1;
    
end



fig_num=1;

x_label='Frequency (Hz)';
y_label='Pressure (psi^2/Hz)';

ppp=[freq psd];

[s,rms] = calculate_PSD_slopes(freq,psd);

oaspl=20*log10(rms/ref);

out1=sprintf(' Qualification Pressure PSD \n Overall Level =  %7.3g psi rms,  OASPL =  %8.4g dB ',rms,oaspl);

fmin=freq(1);
fmax=freq(n);
t_string=out1;

[fig_num]=plot_loglog_function(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

qualification_psd=ppp;

msgbox('Calculation complete.  Output array:  qualification_psd');







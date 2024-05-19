%
%  psd_syn_sine_data_entry.m  ver 1.2  August 16, 2013
%
function [dt,freq,amp,slope,grms] = psd_syn_sine_data_entry(freq,amp,~)
%
n = length(amp);
%
sr=max(freq)*20.;
dt=1./sr;
%
slope=zeros(n-1,1);
%
for i=1:(n-1)
    if(freq(i) > 1.0e-12)
        slope(i)=log( amp(i+1)/amp(i) )/log( freq(i+1)/freq(i) );
    else
        slope(i) = 0.;
    end
end
%
ra=0.;
%
for i=1:(n-1)
	if(slope(i) < -1.0001 ||  slope(i) > -0.9999 )
		ra=ra+ ( amp(i+1)*freq(i+1)- amp(i)*freq(i))/( slope(i)+1.);
	else
		if(freq(i) < 1.0e-12)
            freq(i)=1.0e-12;
        end    
		ra=ra+ amp(i)*freq(i)*log( freq(i+1)/freq(i));
    end
end    
grms=sqrt(ra);
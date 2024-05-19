%
%  psd_syn_data_entry.m    ver 1.2  October 12, 2012
%  by Tom Irvine  Email: tomirvine@aol.com
%
function[dt,slope,grms] = psd_syn_data_entry(freq,amp,~,nsz)
%
n = length(amp);
%
sr=max(freq)*10.;
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
for i=1:nsz-1
%
	if(slope(i) < -1.0001 ||  slope(i) > -0.9999 )
		ra=ra+ ( amp(i+1)*freq(i+1)- amp(i)*freq(i))/( slope(i)+1.);
	else  
		ra=ra+ amp(i)*freq(i)*log( freq(i+1)/freq(i));
    end
end    
grms=sqrt(ra);
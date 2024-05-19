%
%    cumulative_rms.m  ver 1.2  by Tom Irvine
%
function[crms]=cumulative_rms(power_spectral_density)
%
freq=power_spectral_density(:,1);
amp=power_spectral_density(:,2);
%
while(freq(1)<1.0e-10)
    freq(1)=[];
    amp(1)=[];
end    
%
[s,input_rms] = calculate_PSD_slopes_no(freq,amp);
%
oct=2^(1/48);
%   
	fi(1)=freq(1);
	ai(1)=amp(1);
%
    m=length(freq);
%
    MAX = 500000;
%   
    for  i=2:MAX 
%       
		fi(i)=fi(i-1)*oct;
%
        for j=1:(m-1)
%
			if( ( fi(i) >= freq(j) ) && ( fi(i) <= freq(j+1) )  )
				ai(i)=amp(j)*( ( fi(i) / freq(j) )^ s(j) );
				break;
            end
        end
        if( fi(i) >= freq(m) )
            break;
        end                
    end
    nn=length(fi);
    ai(nn)=amp(m);
%
crms(1,1)=fi(1);
crms(1,2)=0;
%
for i=2:length(fi)
    [~,rms] = calculate_PSD_slopes_no(fi(1:i),ai(1:i));
    crms(i,1)=fi(i);
    crms(i,2)=rms;
end 
%
mc=max(crms(:,2));
crms(:,2)=crms(:,2)*input_rms/mc;
%
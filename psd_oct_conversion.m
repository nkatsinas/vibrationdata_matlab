   
% psd_oct_conversion.m  ver 1.0  by Tom Irvine

function[ff,ossum,power_spectral_density,rms]=psd_oct_conversion(f,amp,fl,fc,fu)

    imax=length(fc);

    n=length(f);

%
%%    disp(' ');
%%    disp(' set limits... ');
%
    ssum=zeros(imax,1);
    count=zeros(imax,1);
	
    disp(' ');
	disp('  counts...');
%
    for k=1:n
%        
		for i=1:imax
%		
			if( f(k)>= fl(i) && f(k) < fu(i))
%
				ssum(i)=ssum(i)+ amp(k);
				count(i)=count(i)+1;
			end
		end
	end
%
   disp(' ');
   disp('  calculate output data...');
%
    clear length; 
    
%%    length(count)
%%    f(length(count))

    LC=length(count);
    
    out1=sprintf('\n LC=%d \n',LC);
    disp(out1);
    
    ijk=1;
	for i=1:LC
%	
        iflag=0;
        
		if( fl(i) > f(n))
		   break;
        end
         
	    if(count(i)>=1)
            iflag=1;
        end
        

		if( iflag==1 && ssum(i) > 1.0e-20) 
%		
			ossum(ijk)=ssum(i)/count(i);
            ff(ijk)=fc(i);
            ffl(ijk)=fl(i);
            ffu(ijk)=fu(i);
            ijk=ijk+1;
% 
		end
    end
    
    ms=0;
    for i=1:length(ossum)
        bw=ffu(i)-ffl(i);
        ms=ms+ossum(i)*bw;
    end

    rms=sqrt(ms);
%
    ff=fix_size(ff);
    ossum=fix_size(ossum);
    
   power_spectral_density=[ff ossum];  
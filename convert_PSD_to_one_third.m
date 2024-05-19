%
%  convert_PSD_to_one_third.m  ver 1.0  by Tom Irvine
%
function[ff,psd]=convert_PSD_to_one_third(f,amp)
%

    [fl,fc,fu,imax]=one_third_octave_frequencies();
    
    n=length(f);

%%    disp(' ');
%%	disp('  counts...');
%

    ssum=zeros(n,1);
    count=zeros(n,1);


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
%%   disp(' ');
%%   disp('  calculate output data...');
%

    ijk=1;
    
    for i=1:(length(count)-1)
%	
        iflag=0;
        
        if( fl(i) > f(n))
		   break;
        end
         
        if(iflag==0)
            if(count(i)>=1 && count(i+1)>=2)
				iflag=1;
            end
        end

        if( iflag==1 && ssum(i) > 1.0e-20) 
%		
			ossum(ijk)=ssum(i)/count(i);
            ff(ijk)=fc(i);
            ijk=ijk+1;
% 
        end
    end
    
    psd=ossum;
    
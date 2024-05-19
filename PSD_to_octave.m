

% PSD_to_octave.m  ver 1.0  by Tom Irvine


function[Poct]=PSD_to_octave(fl,fc,fu,imax,PSD)


f=PSD(:,1);
amp=PSD(:,2);

Poct=zeros(imax,1);

ossum=zeros(imax,1);
ssum=zeros(imax,1);
count=zeros(imax,1);


n=length(f);

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
    
    for i=1:imax
       if(count(i)>=1)
           ossum(i)=ssum(i)/count(i);
       end
    end
    
    
 Poct=ossum;   
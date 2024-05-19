%
%  DSS_sintime.m  ver 2.0  October 9, 2012
%
function[amp,phase,delay,dampt,sss,first]=...
DSS_sintime(ns,dt,dur,tpi,ia,iamax,ra,omega,last,syn_error,best_amp,best_phase,best_delay,best_dampt,first)
%
disp(' in sintime ');
%
amp=zeros(last,1);
phase=zeros(last,1);
delay=zeros(last,1);
dampt=zeros(last,1);
sss=zeros(last,ns);
%
if( (ia < 12 ) || rand()<0.5)
%	 
		for(i=1:last)
%		
			amp(i)=(ra(i)/10.);
            if(rand()<0.5)
                amp(i)=-amp(i);
            end
			phase(i)=0;
%
			delay(i) = first + 0.020*dur*rand();
			dampt(i) = 0.003 + 0.035*rand();
        end
%	 
else
%	 
		for(i=1:last)
%
			amp(i)= best_amp(i)*(0.99+0.02*rand());
			phase(i)= best_phase(i)*(0.99+0.02*rand());
			delay(i)= best_delay(i)*(1.0+0.02*rand());
%
            if(delay(i) > 0.015*dur)
                delay(i)=0.015*dur;
            end
			dampt(i)= best_dampt(i)*(0.99+0.02*rand());
%
        end
end
%	 
	 for(k=1:last)
%	 
        for(j=1:ns)
%	    
			tt=dt*j;
%
			if( tt > delay(k))
%			
			    tt=tt-delay(k);
				ft=omega(k)*tt;
%
%%%%				sss(k,j)=exp(-dampt(k)*ft)*sin(ft+phase(k));
                    sss(k,j)=exp(-dampt(k)*ft)*sin(ft);
%
            end
        end
     end
end    
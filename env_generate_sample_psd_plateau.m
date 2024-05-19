%
%  env_generate_sample_psd_plateau.m  ver 1.0  January 10, 2013
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd_plateau(n_ref,nbreak,f_ref,ik,slopec,...
                                                       initial,final,f1,f2)
%    
iflag=99;
%
f_sam=zeros(nbreak,1);
apsd_sam=zeros(nbreak,1);
%
f_sam(1)=f1;
%
% generate some random numbers for frequency
%
for ijk=1:10000
	   
    for i=2:nbreak
%		  
        index = round( n_ref*rand());
		if(index >= n_ref)
            index=n_ref-1;
        end    
		if(index < 1)
            index=1;
        end            
%
        f_sam(i)=f_ref(index);
    end
%    
    f_sam(nbreak)=f2;   
%          
% sort the frequencies
%
    f_sam=sort(f_sam);
%
% check frequencies for adequate spacing
%		  
    ialarm = 0;
    fnum = (f_ref(n_ref)-f_ref(1))/200.;
%
    for i=1:(nbreak-1)
%
        if (  abs( log(f_sam(i+1)/f_sam(i))/log(2) ) < 1 )
            ialarm = 1;
            break;
        end
    end
%    
    if(ialarm == 1 )
%
        df=(f_ref(n_ref)-f_ref(1))/(n_ref-1);
%    
        for i=2:nbreak
            f_sam(i)=f_sam(i-1)+df;
        end
    end
    f_sam(nbreak)=f_ref(n_ref);
    f_sam=sort(f_sam);
%
    if(ialarm==0)
             break; 
    end
%		  
end
%%%%%
%%%%%
    f_sam(nbreak)=f_ref(n_ref);
%%%%%
%%%%%
%
% generate some random numbers for amplitude
%
	   for i=1:nbreak
		    apsd_sam(i)=rand();
       end
%	   
	   amin=1.0e-12;
%
	   for i=1:nbreak
%	 
	      if(apsd_sam(i) < amin)
                apsd_sam(i)=amin;
          end  
	      if(apsd_sam(i) > (1/amin))
              apsd_sam(i)=(1/amin);
          end    
       end
%%
%%
% absolute slopes are limited to slopec
%
for i=1:(nbreak-1)
    fr=f_sam(i+1)/f_sam(i);
    sss=0.;
    sss=log(apsd_sam(i+1)/apsd_sam(i))/log(fr);
    if(sss > slopec)
        apsd_sam(i+1)=apsd_sam(i)*(fr^slopec);
    end
    if(sss < -slopec)
        apsd_sam(i+1)=apsd_sam(i)*(fr^(-slopec));
    end
end
if(initial==1 && apsd_sam(1) > apsd_sam(1))
    apsd_sam(1)=apsd_sam(1);
end
if(final==1 && apsd_sam(nbreak) > apsd_sam(nbreak-1))
    apsd_sam(nbreak)=apsd_sam(nbreak-1);
end
%
f_sam(1)=f1;
f_sam(nbreak)=f2;
%
out1=sprintf(' Phase 1, Trial %ld, PSD Coordinates  ',ik);
disp(out1);
%
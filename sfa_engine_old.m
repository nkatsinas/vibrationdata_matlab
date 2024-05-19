%
%    sfa_engine.m  ver 2.2   January 19, 2015
%
function[a,x1r,x2r,x3r,error_rth,syna,cnew] = ...
              sfa_engine(dur,a,t,~,~,flow,fup,ie,nt,x1r,x2r,x3r,...
                                            original,running_sum,istr,dt)
%
clear ta;
clear error_rth
clear syna;
%
tp=2*pi;
%
%
zcf=0;
fft_freq=0;
freq_est=0;
%
if(istr==2)
    amp=a-mean(a);
    nzc=0;
    pzc=0;
    for i=1:length(a)-1
%
       if(amp(i) <=0 && amp(i+1) > 0)
           pzc=pzc+1;
       end
%       
       if(amp(i) >=0 && amp(i+1) < 0)
           nzc=nzc+1;      
       end 
    end
%    
    zcf=((pzc+nzc)/2)/dur;  
%
    m_choice=1;  % mean removal
    h_choice=1;  % rectangual window
%    
    n=length(a); 
    N=2^floor(log(n)/log(2));
    [freq,full,phase,complex_FFT]=full_FFT_core(m_choice,h_choice,a,N,dt);    
%
    magnitude_FFT=[freq full];
%    
    [~,fft_freq]=find_max(magnitude_FFT);
%
    out1=sprintf(' zero crossing frequency = %8.4g Hz ',zcf);
    disp(out1);    
%
    out1=sprintf(' FFT frequency = %8.4g Hz ',fft_freq);
    disp(out1);
%
end
%
sd=std(a);
%
am=sd;
%
errormax=1.0e+53;
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   Phase(rad)  ');
%
jk=0;
%
Y=a;
Y=fix_size(Y);
%
ta=t;
%
for j=1:nt
%
    if(istr==2)
        if(rand<0.5)
            freq_est=zcf;
        else    
            freq_est=fft_freq;
        end
    end    
%
	jk=jk+1;
%           
    if(jk==10000)
		out4=sprintf('\n %ld ',j);
        disp(out4);
		jk=0;
    end
%
	x1=rand;
	x2=rand;
	x3=rand;
%      
	x1= am*x1^2;
	x2=((fup-flow)*x2+flow)*tp;
	x3=x3*tp;
%
    if(istr==2)
       if(rand<0.8)
          x2=freq_est*tp*(0.98+0.04*rand);
       end
    end
%
    if(rand<0.5 && j>fix(nt/10))
%      
		x1=x1r(ie);
		x2=x2r(ie);
		x3=tp*rand;
%    
    end
%
    if(rand<0.4 && j>fix(nt/10))
%      
		x1=x1r(ie);
		x2=x2r(ie);
		x3=x3r(ie)+tp*(0.05-0.1*rand);
%    
    end
%
    if(rand<0.3 && j>fix(nt/10))
%      
		x1=x1r(ie)*(0.98+0.04*rand);
		x2=x2r(ie);
		x3=x3r(ie);
%    
    end
    if(rand<0.2 && j>fix(nt/10))
%      
		x1=x1r(ie);
		x2=x2r(ie)*(0.98+0.04*rand);
		x3=x3r(ie);
%    
    end    
    if(rand<0.1 && j>fix(nt/10))
%      
		x1=x1r(ie)*(0.98+0.04*rand);
		x2=x2r(ie)*(0.98+0.04*rand);
		x3=x3r(ie)+tp*(0.05-0.1*rand);
%    
    end    
%
	if(x2 > fup*tp )
       x2 = fup*tp;
    end    
%
	if(x2 < flow*tp)
       x2 = flow*tp;
    end    
%
	if(j==1)
        x1=0.;
    else
        if(x1<1.0e-12)
            x1=am*rand;
        end
    end
    x1=abs(x1);
%
    if(j<=2)
        x2=tp*(fft_freq + zcf)/2;
    end
    if(j==3)
        x2=tp*zcf;
    end
    if(j==4)
        x2=tp*fft_freq;
    end    
%%
%%
    if(j==1 && istr==1)
        x1=1.0e-20;
	    x2=((fup-flow)*x2+flow)*tp;        
        x3=0;
    end
%%
%%
	clear error;
    clear y;
%   
	y=x1*sin(x2*ta+x3);
%   
    error=a-y;
%
	if(std(error)<errormax)
%
                syna=-(error-a);
                error_rth=error;
	            errormax=std(error);
				x1r(ie)=x1;
				x2r(ie)=x2;
				x3r(ie)=x3;
                yr=y;
%
                omega=x2r(ie);
                
                [aa,bb,cc,x1,x2,x3,y]=sine_lsf_function(Y,ta,omega);
  
%   
                error=a-y;
%
                if(std(error)<errormax)
%
                    syna=-(error-a);
                    error_rth=error;
                    errormax=std(error);
                    x1r(ie)=x1;
                    x2r(ie)=x2;
                    x3r(ie)=x3;
                    yr=y;
%                    disp('**')
%
                end
%
                out4 = sprintf(' %6ld  %13.4e  %10.4g %9.4f %9.4f  ',j,errormax,x1,x2/tp,x3);
                disp(out4) 
%      
%
           cnew=running_sum+yr;

%%%       figure(2)
%%%
%%%        plot(t,original,t,cnew);
%%%        legend ('Input Data','Synthesis',2);
%%%        xlabel('Time(sec)');
%
    end
%		
end

%   
a=error_rth;
%
ave=mean(a);  
sd=std(a);
%	
out4=sprintf('\n  ave=%12.4g  sd=%12.4g \n',ave,sd);
disp(out4)    
%
%
%  decomposition_wgen.m   version 3.2   by Tom Irvine
%
function[x1r,x2r,x3r,x4r]=...
decomposition_wgen(num2,t,residual,duration,fl,fu,nt,ffmax,first,sr,start_time)
%
tp=2*pi;
%
dt=1/sr;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
m_choice=1;  % mean removal
h_choice=1;  % rectangual window
%
n=length(residual); 
N=2^floor(log(n)/log(2));
[freq,full,phase,complex_FFT]=full_FFT_core(m_choice,h_choice,residual,N,dt);    
%
magnitude_FFT=[freq full];
%    
[~,fft_freq]=find_max(magnitude_FFT);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
min_delay=start_time;
%
ave=mean(residual);   
sd=std(residual);
%
asd=zeros(num2,1);
for i=1:num2
    asd(i)=(residual(i)^2);
end
%
out1=sprintf(' ave=%12.4g  sd=%12.4g  nt=%d',ave,sd,nt);
disp(out1);
%
am=2.*sd;
%
%
errormax=1.0e+53;
%
fl=(1.5/duration);
fu=sr/3;

%
noct=log(fu/fl)/log(2);
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   NHS    delay(sec) ');
%
ntt=ceil(nt/4);
%
for j=1:nt
%
    ran1=rand;
    ran2=rand;	
    ran3=rand;
%				
    x1=rand;
    x33=rand;
    x4=rand;

%
    if(rand()<0.4)
        x2=fft_freq*(0.98+0.04*rand);
    else

        if(rand()<0.5)
            x2=((fu-fl)*rand+fl);	% freq
        else
            x2=fl*2^(noct*rand);
        end         
    end
       
    x2=x2*tp;
%
    x3= 3+(2*round(x33*16));	% nhs
%
    x4=x4*0.9*duration + min_delay;		% delay
%
    if(rand()<0.15)
        x4=x4*0.2*duration + min_delay;
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(ran1>0.4 && ran1<=0.5 && j>ntt)
%						
	    x2=x2r*(0.99+0.02*rand);
	    x4=x4r*(0.99+0.02*rand);
%
	    if(ran2<=0.25)
		    x3=x3r-4;
        end    
		if(ran2>0.25 && ran2<=0.5)
		    x3=x3r-2;
        end
	    if(ran2>0.50 && ran2<=0.75)
			x3=x3r+2;
        end
		if(ran2>0.75 && ran2<=1.0)
		    x3=x3r+4;
        end
%
		if(x3<3)
            x3=3;
        end
%
%%		itype=2;  % mainly NHS
%
    end
%   
	if(ran1>0.5 && ran1<=0.6 && j>ntt)  
%			
				x2=x2r;
				x3=x3r;
				x4=x4r;
%
%				itype=3; % amp  
    end
	if(ran1>0.6 && ran1<=0.7 && j>ntt)
%			
				x2=x2r*(0.99+0.02*rand);	
				x3=x3r;
				x4=x4r;
%				
%				itype=4;  % freq
    end
	if(ran1>0.8 && ran1<=0.9 && j>ntt)
%			
				x2=x2r;
				x3=x3r;
				x4=x4r*(0.99+0.02*rand);
%
%				itype=5;  % delay
    end
	if(ran1>0.9 && ran1<=1. && j>ntt)
%			
				x2=x2r*(0.999+0.002*rand);
				x3=x3r;
				x4=x4r*(0.999+0.002*rand);
%
%				itype=6;  % all but NHS
    end    
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    iflag=0;
    while(1)
    for ij=1:100
%
	    if( tp*x3/(2.*x2) + x4 < duration )
            iflag=1;
			break;
        else
            iflag=2;
            x2=x2*1.01;
			x4=0.95*x4;
        end
    end  
    if(iflag==1)
        break;
    else
        x3=x3-2;
    end
    end
%
%%%%%
%        
	if(x3==1 || iflag==2)
				x1=0;
				x2=fu*tp;
				x3=3;
				x4=0;
%
    end
%
    if(j==1 || x3 < 3 || x4<min_delay)
				x1=0.;
				x2=fu*tp;
				x3=3;
				x4=0.;
    end

%
    error=0.;
%
    t1=x4 + t(1);
    t2=t1 + tp*x3/(2.*x2);
%
    y=zeros(num2,1);

    if(j==1)
            x1=0.;
    else

        for i=1:num2
%		
		    tt=t(i);
%
            if( tt>= t1 && tt <= t2)
%				
			    arg=x2*(tt-t1);  
%
				y(i)=sin(arg/double(x3))*sin(arg);
%
            end
        end
    
        Z=y;
                
        x1=pinv(Z'*Z)*(Z'*residual);  
        y=y*x1;  
    
    end 
    
    error=std(residual(i)-y);
%            
    if(error<errormax )
%
				x1r=x1;
				x2r=x2;
				x3r=x3;
				x4r=x4;
%
				fprintf(' %d  %11.4e  %9.4f  %9.4f  %d  %9.4f \n',j,error,x1r,x2r/tp,x3r,x4r);
%
				errormax=error;
%
    end
%
end
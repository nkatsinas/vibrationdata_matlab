%
%  decomposition_wgen_alt.m   version 3.3   by Tom Irvine
%
function[x1r,x2r,x3r,x4r]=...
decomposition_wgen_alt(num2,t,residual,duration,fl,fu,nt,ffmax,first,sr,start_time,LF,minw,maxw)
%
tp=2*pi;
%
dt=1/sr;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

f = fit(t, residual, 'sin1');
omega=f.b1;
sine_freq=omega/(2*pi);
        

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
wave1=2*floor(minw/2)+1;
wave2=2*floor(maxw/2)+1;
dwave=wave2-wave1;

%
errormax=1.0e+53;
%
if(LF==2)
    fl=(1.5/duration);
    fu=sr/3;
end

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
    x1=2.*am*(x1-0.5);	% amplitude
%
    if(rand()<0.4)
        x2=sine_freq*(0.98+0.04*rand);
    else

        if(rand()<0.5)
            x2=((fu-fl)*rand+fl);	% freq
        else
            x2=fl*2^(noct*rand);
        end         
    end
       
    x2=x2*tp;
%
    x3= wave1+dwave*rand();	 % nhs
    x3=2*floor(x3/2)+1;    
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
		x1=x1r*(0.95+0.10*rand);
%
	    if(ran3>0.5)
			x1=-x1;
        end
%
		if(x3<wave1)
            x3=wave1;
        end
        if(x3>wave2)
            x3=wave2;
        end
%
%%		itype=2;  % mainly NHS
%
    end
%   
	if(ran1>0.5 && ran1<=0.6 && j>ntt)  
%			
				x1=x1r*(0.98+0.04*rand);
				x2=x2r;
				x3=x3r;
				x4=x4r;
%
%				itype=3; % amp  
    end
	if(ran1>0.6 && ran1<=0.7 && j>ntt)
%			
				x1=x1r;
				x2=x2r*(0.99+0.02*rand);	
				x3=x3r;
				x4=x4r;
%				
%				itype=4;  % freq
    end
	if(ran1>0.8 && ran1<=0.9 && j>ntt)
%			
				x1=x1r;
				x2=x2r;
				x3=x3r;
				x4=x4r*(0.99+0.02*rand);
%
%				itype=5;  % delay
    end
	if(ran1>0.9 && ran1<=1. && j>ntt)
%			
				x1=x1r*(0.999+0.002*rand);
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


    if(x2<fl*tp)
        x2=fl*tp;
    end
    if(x2>fu*tp)
        x2=fu*tp;
    end   
    
    
    while(x2<1.001*fl*tp || x2>0.999*fu*tp)
        x2=tp*((fu-fl)*rand+fl);	% freq
    end
    
    
%
    error=0.;
%
    t1=x4 + t(1);
    t2=t1 + tp*x3/(2.*x2);
%
    if(j==1)
            x1=0.;
    end
%
    tmax=max(t);
%
	for i=1:num2
%		
		    tt=t(i);
%
            y=0.;  
%
		    if( tt>= t1 && tt <= t2)
%				
			    arg=x2*(tt-t1);  
%
				y=x1*sin(arg/double(x3))*sin(arg);
%
            end
%
%%			error=error+((residual(i)-y)^2.)*(1 - 0.1*(i/num2) );
            error=error+((residual(i)-y)^2.);
%
    end          
%            
    error=sqrt(error);
%
    if(error<errormax )
%
				x1r=x1;
				x2r=x2;
				x3r=x3;
				x4r=x4;
%
				out1=sprintf(' %d  %11.4e  %9.4f  %9.4f  %d  %9.4f ',j,error,x1r,x2r/tp,x3r,x4r);
                disp(out1);
%
				errormax=error;
                              
%
    end
%
end
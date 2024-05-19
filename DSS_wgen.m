%
%  DSS_wgen.m   version 3.2    by Tom Irvine
%
function[x1r,x2r,x3r,x4r]=...
DSS_wgen(num2,t,~,residual,duration,~,x1r,x2r,x3r,x4r,fl,fu,nt,ie,~,ffmax,first)
%
tp=2*pi;
%
min_delay=0.1*first;
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
errormax=1.0e+53;
%
noct=log(fu/fl)/log(2);
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   NHS    delay(sec) ');
%
for j=1:nt
%
    ran1=rand;
    ran2=rand;	
%				
    x1=rand;
    x33=rand;
    x4=rand;
%
    if(rand()<0.2)
        x2=((fu-fl)*rand+fl);	% freq
    else
        x2=fl*2^(noct*rand);
    end 
    x2=x2*tp;
%
    x3= 3+(2*round(x33*30));	% nhs
%
    x4=x4*0.8*duration + min_delay;		% delay
%
    if(ran1>0.4 && ran1<=0.5 && j>100)
%						
	    x2=x2r(ie)*(0.99+0.02*rand);
	    x4=x4r(ie)*(0.99+0.02*rand);
%
	    if(ran2<=0.25)
		    x3=x3r(ie)-4;
        end    
		if(ran2>0.25 && ran2<=0.5)
		    x3=x3r(ie)-2;
        end
	    if(ran2>0.50 && ran2<=0.75)
			x3=x3r(ie)+2;
        end
		if(ran2>0.75 && ran2<=1.0)
		    x3=x3r(ie)+4;
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
	if(ran1>0.5 && ran1<=0.6 && j>100)  
%			
				x2=x2r(ie);
				x3=x3r(ie);
				x4=x4r(ie);
%
%				itype=3; % amp  
    end
	if(ran1>0.6 && ran1<=0.7 && j>100)
%			
				x2=x2r(ie)*(0.99+0.02*rand);	
				x3=x3r(ie);
				x4=x4r(ie);
%				
%				itype=4;  % freq
    end
	if(ran1>0.8 && ran1<=0.9 && j>100)
%			
				x2=x2r(ie);
				x3=x3r(ie);
				x4=x4r(ie)*(0.99+0.02*rand);
%
%				itype=5;  % delay
    end
	if(ran1>0.9 && ran1<=1. && j>100)
%			
				x2=x2r(ie)*(0.999+0.002*rand);
				x3=x3r(ie);
				x4=x4r(ie)*(0.999+0.002*rand);
%
%				itype=6;  % all but NHS
    end    
%
	while(1)
%
	    if( tp*x3/(2.*x2) + x4 < duration )
			break;
		else
			x3=x3-2;
        end
    end      
%            
	if(x3==1)
				x2=fu*tp;
				x3=3;
				x4=0;
%
    end
%
    if(j==1 || x3 < 3)
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
    if( (x2/tp)<fl || x3 < 3)
        x2=((ffmax-fl)*rand + fl)*tp;
        x3=3;
        x4=0.;
    end
%
    if( (x2/tp)>ffmax)
        x2=((ffmax-fl)*rand + fl)*tp;
        x3=3;
        x4=0.;
    end
%
    if(x4<min_delay)
        x4=min_delay;
    end
%

    y=zeros(num2,1);
    
    [~,index1] = min(abs(t-t1));
    [~,index2] = min(abs(t-t2));
    
 
    for i=index1:index2
        
        arg=x2*(t(i)-t1);  
        y(i)=sin(arg/double(x3))*sin(arg);
        
    end
    
    [x1]=wavelet_lsf_function(residual(index1:index2),y(index1:index2));
    
    y=x1*y;

    error=0;
    
    for i=1:(index1-1)
        error=error+2*asd(i);
    end
    
    for i=index1:index2
        error=error+((residual(i)-y(i))^2);
    end 
    
    for i=(index2+1):num2
        error=error+asd(i);
    end        
    
%            
    error=sqrt(error);
%
    if(error<errormax && x2>=(fl*tp ))
%
				x1r(ie)=x1;
				x2r(ie)=x2;
				x3r(ie)=x3;
				x4r(ie)=x4;
%
				out1=sprintf(' %d  %11.4e  %9.4f  %9.4f  %d  %9.4f ',j,error,x1,x2/tp,x3,x4);
                disp(out1);
%
				errormax=error;
%
    end
%
end
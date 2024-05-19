
%  wgen.m   version 2.1   October 25, 2018

function[error_max,x1r,x2r,x3r,x4r]=...
      wgen_hs(num2,t,residual,duration,sr,x1r,x2r,x3r,x4r,fl,fu,nt,ie,ffmin,ffmax,tt1,tt2,AL,rsum,amp_original)
%
%
tp=2*pi;
ave=0.;
sq=0.;
%
jki=0;
jflag=1;
%
duration=max(t)*0.98;
tmax=max(t)/2.;
ave=mean(residual);   
sd=std(residual);
%
for(i=1:num2)
    asd(i)=(residual(i)^2.);
end
%
am=max(residual);
n=num2;
%	       
error_max=1.0e+53;
%
%%% out1=sprintf(' am=%g ave=%g  sd=%g  nt=%d  num2=%d',am,ave,sd,nt,num2);
%%% disp(out1);
%
%%% disp(' ');
%%% disp('  Trial     Error      Amplitude   Freq(Hz)   NHS    delay(sec) ');
%
%
for(j=1:nt)
%
    ran1=rand;
    ran2=rand;	
%				
    x1=rand;
    x2=rand;
%
    x1=am*x1;
    if(rand<0.5)
        x1=-x1;
    end
%
    x2=( (ffmax-ffmin)*x2 + ffmin )*tp;	% freq    
%
    x3= 3;	% nhs
    x3=rand;
    x3= 3+(2*round(x3*10));  
 
    ddd=( tp*x3/(2.*x2)  )/2;
    t1=tmax-ddd;
    t2=t1 + tp*x3/(2.*x2); 
    x4=t1;
%
    if(j>round(0.2*nt) && rand > 0.5 )
        x1=x1r(ie)*(0.99+0.02*rand);
        x2=x2r(ie)*(0.99+0.02*rand);
        x3=x3r(ie);
        x4=x4r(ie)*(0.99+0.02*rand);
    end
%
    error=0.;
%
  
  
%
	while(1)
%
	    if( t2 < duration )
			break;
		else
			x3=x3-2;
            ddd=( tp*x3/(2.*x2)  )/2;
            t1=tmax-ddd;
            t2=t1 + tp*x3/(2.*x2);   
            x4=t1;
            if(x3<3)
                x2=ffmax;
                x3=3;
                ddd=( tp*x3/(2.*x2)  )/2;
                t1=tmax-ddd;
                t2=t1 + tp*x3/(2.*x2);   
                x4=t1; 
                break;   
            end
        end
    end 
%
    if(j==1)
        x1=0.;
    end
%
    clear yy;
    yy=zeros(num2,1);
	for(i=1:num2)
%		
		    tt=t(i);
%
		    if( tt>= t1 && tt <= t2)
%				
			    arg=x2*(tt-t1);  
%
				yy(i)=x1*sin(arg/double(x3))*sin(arg);
%
            end
    end 
    err=zeros(num2,1);
    err=amp_original - (rsum +yy) ;
    error=0;
	for(i=1:num2)
%		
		    tt=t(i);
%
		    if( tt>= tt1 && tt <= tt2)  
                error=error+abs(err(i));
            else
                rrr=abs(rsum(i) +yy(i));
                if( rrr > AL )
                    error=error+10*abs(AL-rrr);
                end
            end
    end         
%            
    error=sqrt(error);
%
%%	out1=sprintf(' %d  %11.4e  %9.4f  %9.4f  %d  %9.4f ',j,error,x1,x2/tp,x3,x4);
%%    disp(out1);
%%    uuu=input(' ');    
%
    if(error<error_max && x2>=(ffmin*tp))
%
				x1r(ie)=x1;
				x2r(ie)=x2;
				x3r(ie)=x3;
				x4r(ie)=x4;
%
%%%				out1=sprintf(' %d  %11.4e  %9.4f  %9.4f  %d  %9.4f ',j,error,x1,x2/tp,x3,x4);
%%%                disp(out1);
%
				error_max=error;
%
%%                out1=sprintf(' x3r[%d]=%d \n',ie,x3r(ie));
%%                disp(out1);
    end
%
    if(x2r(ie)<ffmin*tp)
        x2r(ie)=ffmin*tp;
        x1r(ie)=1.0e-20;
        x3r(ie)=3;
        x4r(ie)=0;
    end
%
end
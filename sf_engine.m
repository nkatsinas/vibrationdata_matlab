%
%    sf_engine.m  ver 1.4  April 26, 2013
%
function[a,x1r,x2r,x3r,x4r,x5r,cnew] = ...
    sf_engine(a,t,num2,flow,fup,ie,nt,dur,x1r,x2r,x3r,x4r,...
                                                  x5r,running_sum,original)
%
rand('state',0)
tp=2*pi;
%
ave=mean(a);
sd=std(a);
%
am=2.*sd;
n=num2;
pu=1.;
pl=0.;
%
errormax=1.0e+53;
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   Phase(rad)  damp   delay(sec) ');
%
jk=0;
%
delta=0.001;
nnn=fix(0.1*nt);
%
for j=1:nt
%
    if(j>nnn)
%
      fr=(x2r(ie)/tp);
%
      if( (fup-fr)/fup < delta)
          fup=fup*(1+delta);
      end
 %
      if(flow>1.0e-06)
        if( (fr-flow)/flow < delta)
            flow=flow*(1-delta);
        end  
      end
%      
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
	x4=rand;
	x5=rand;
%
    n1=fix(2.*nt/3.);
    n2=fix(4.*nt/5.);
	if( j < n1 )
				x1=2.*am*x1;
				x2=((fup-flow)*x2+flow)*tp;
				x3=((pu-pl)*x3+pl)*tp;
				x4=(x4^2.5);
				x5=dur*(x5^2.);
    end
    if( j >= n1 & j < n2)
				x1=x1r(ie)*(0.98+0.04*x1);
				x2=x2r(ie)*(0.98+0.04*x2);
				x3=x3r(ie)*(0.98+0.04*x3);
%				x4=x4r(ie)*(0.80+0.40*x4);
				x5=x5r(ie)*(0.98+0.04*x5);
    end
    if( j >= n2 )
				x1=x1r(ie)*(0.99+0.02*x1);
				x2=x2r(ie)*(0.99+0.02*x2);
				x3=x3r(ie)*(0.99+0.02*x3);
				x4=x4r(ie)*(0.90+0.20*x4);
				x5=x5r(ie)*(0.99+0.02*x5);
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
	if(x4 >= 0.85 )
                x4=0.05;
    end    
%		
	if(j==1)
                x1=0.;
    else
        if(x1<1.0e-12)
            x1=am*rand;
        end
    end
%
	error=0.;
%        
    domegan=x4*x2;
    omegad=x2*sqrt(1.-x4^2);
%	
    yr=zeros(n,1);
    for i=1:n
%
		tt=t(i)-t(1);
		y=0.;      
%
		if(tt>x5)
            ta=tt-x5;
			y=x1*exp(-domegan*ta)*sin(omegad*ta-x3);
            yr(i)=y;
        end
%				
		error=error+((a(i)-y)^2.);
%   
    end
	error=sqrt(error);
%
	if(error<errormax)
%
				x1r(ie)=x1;
				x2r(ie)=x2;
				x3r(ie)=x3;
				x4r(ie)=x4;
				x5r(ie)=x5;
%
       out4 = sprintf(' %6ld  %13.4e  %10.4g %9.4f %9.4f %10.5f %9.4f ',j,error,x1,x2/tp,x3,x4,x5);
       disp(out4)    
%
	   errormax=error;
%
       figure(2)
       cnew=running_sum+yr';
       plot(t,original,t,cnew);
       legend ('Input Data','Synthesis');
       xlabel('Time(sec)');
%			
     end
%				
end
%
ave=0.;
sq=0.;
%   
for i=1:n
%
    tt=t(i)-t(1);
%		 
    domegan=x4r(ie)*x2r(ie);
    omegad=x2r(ie)*sqrt(1.-x4r(ie)^2);
%	
    if(tt>x5r(ie))
        ttt=tt-x5r(ie);
        a(i)=a(i)-x1r(ie)*exp( -domegan*ttt )*sin( omegad*ttt - x3r(ie) );
        ave=ave+a(i);
	    sq= sq+(a(i)^2.);
    end
end
%
ave=ave/n;   
sd=sqrt( (sq/n) -(ave^2.));
%	
out4=sprintf('\n  ave=%12.4g  sd=%12.4g \n',ave,sd);
disp(out4)    
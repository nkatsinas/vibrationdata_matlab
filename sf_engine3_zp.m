%
%    sf_engine3_zp.m  ver 2.2  by Tom Irvine
%
function[a,x1r,x2r,x3r,x4r,x5r,cnew,errormax] = ...
    sf_engine3_zp(a,t,num2,flow,fup,ie,nt,dur,x1r,x2r,x3r,x4r,...
                  x5r,running_sum,original,istr,max_damp,min_damp,errormax)
%
tpi=2*pi;
%

fmin=flow;

Y=a;
Y=fix_size(Y);
%
rand('state',0)
tp=2*pi;
%
ave=mean(a);
sd=std(a);

amax=0;
tmax=0;

%
for i=1:length(a)
    if(abs(a(i))>amax)
        amax=abs(a(i));
        tmax=t(i);
    end    
end    
    
%
am=2.*sd;
n=num2;
%
dt=(t(n)-t(1))/(n-1);
sr=1/dt;
%
jk=0;
%
delta=0.001;
nnn=fix(0.1*nt);
%
zcf=0;
fft_freq=0;
freq_est=0;
%
if(istr==2)
    a=a-mean(a);
%
%%    iband=1;
%%    fl=sr/8;
%%    fh=0.;
%%    iphase=1;
%%    [a,mu,sd,rms]=...
%%                  Butterworth_filter_function_alt(a,dt,iband,fl,fh,iphase);
%
    nzc=0;
    pzc=0;
    for i=1:length(a)-1
%
       if(a(i) <=0 && a(i+1) > 0)
           pzc=pzc+1;
       end
%       
       if(a(i) >=0 && a(i+1) < 0)
           nzc=nzc+1;      
       end 
    end
%
    zcf=((pzc+nzc)/2)/dur;  
%
    m_choice=1;  % mean removal
    h_choice=1;  % rectangual window
%    
    N=2^floor(log(n)/log(2));
    [freq,full,phase,complex_FFT]=full_FFT_core(m_choice,h_choice,a,N,dt);    
%
    magnitude_FFT=[freq full];
%    
    [~,fft_freq]=find_max(magnitude_FFT);
%
    out1=sprintf('\n zero crossing frequency = %8.4g Hz ',zcf);
    disp(out1);
%    
    out1=sprintf(' FFT frequency = %8.4g Hz ',fft_freq);
    disp(out1);
%
end
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   Phase(rad)  damp   delay(sec) ');
%
progressbar;
for j=1:nt
%
    progressbar(j/nt);
%
    if(istr==2)
        if(rand<0.5)
            freq_est=zcf;
        else    
            freq_est=fft_freq;
        end    
    end
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
    x1=amax*rand;
	x2=((fup-flow)*rand+flow)*tp;
    x3=tpi*rand;
	x4=(max_damp-min_damp)*rand+min_damp;
	x5=dur*rand;
%
    if(rand<0.4)
        x5=(tmax-t(1))*(0.95+0.10*rand);
    end
%
    n1=fix(2.*nt/3.);
    n2=fix(4.*nt/5.);
    
    if( j >= n1 )
        
        qr=rand;
        
        if(qr>0.5 && qr<0.75)
        
				x1=x1r(ie)*(0.98+0.04*rand());        
				x2=x2r(ie)*(0.98+0.04*rand());
				x3=x3r(ie)*(0.98+0.04*rand());                
				x4=x4r(ie)*(0.98+0.04*rand());
				x5=x5r(ie)*(0.98+0.04*rand());
        end
        if(qr>0.75)
   				x1=x1r(ie)*(0.99+0.02*rand());     
				x2=x2r(ie)*(0.99+0.02*rand());
				x3=x3r(ie)*(0.99+0.02*rand());                
				x4=x4r(ie)*(0.99+0.02*rand());
				x5=x5r(ie)*(0.99+0.02*rand());
        end         
    end
%
    if(istr==2 && freq_est < sr/6)
        if(rand<0.3)
            x2=freq_est*(0.98+0.04*rand());
        else
            if(rand<0.5)
                x2=freq_est*(0.95+0.10*rand());
            else
                x2=freq_est*(0.90+0.20*rand()); 
            end    
        end
        x2=x2*tp;
%
        if(j>nnn && rand<0.3 )
            if(rand<0.5)
                x2=x2r(ie)*(0.99+0.02*x2);
            else
                x2=x2r(ie)*(0.995+0.01*x2);                
            end
        end    
%
    end
%
%%%
	if(x2 > fup*tp || freq_est > sr/6 )
                x2 = fup*tp;
    end    
%
	if(x2 < flow*tp)
                x2 = flow*tp;
    end 
%
	while(x4 >= max_damp )
                x4=(max_damp-min_damp)*rand+min_damp;
    end    
%		
%%
    if(j<=40)
        
        if(rand()<0.33)
            x2=tp*(fft_freq + zcf)/2;
        else
           if(rand()<0.5)
               x2=tp*zcf;
           else
               x2=tp*fft_freq;
           end
        end    
            
    end
%%
    if( (x2/tp)<fmin )
        x2=fmin*tp;
    end
%%
	error=0.;
%        
    domegan=x4*x2;
    omegad=x2*sqrt(1.-x4^2);
%
    if(istr==2) 
        [aa,bb,cc,x1,x3,y]=damped_sine_lsf_function(Y,t,domegan,omegad,x5);
    end
%
    if(rand()<0.5)
        x3=0;
    else
        x3=pi;
    end    

    yr=zeros(n,1);
    for i=1:n
%
		tt=t(i)-t(1);
		y=0.;      
%
		if(tt>x5)
            ta=tt-x5;
			y=x1*exp(-domegan*ta)*sin(omegad*ta+x3);
            yr(i)=y;
        end
%				
		error=error+(abs(a(i)-y));
%   
    end
	error=sqrt(error);
                
	if(( error<errormax && (x2/tp)> (1.01*flow) ) || (ie==1 && j==1) )
%
				x1r(ie)=x1;
				x2r(ie)=x2;
				x3r(ie)=x3;
				x4r(ie)=x4;
				x5r(ie)=x5;
%%%
                out4 = sprintf('* %6ld  %13.4e  %10.4g %9.4f %9.4f %10.5f %9.4f ',j,errormax,x1,x2/tp,x3,x4,x5);
                disp(out4) 
%%%
                errormax=error;
%
       running_sum=fix_size(running_sum);
       yr=fix_size(yr);
       
%%%       figure(2)
       cnew=running_sum+yr;
%%%       plot(t,original,t,cnew);
%%%       legend ('Input Data','Synthesis',1);
%%%       xlabel('Time(sec)');
%			
     end
%				
end
%
pause(0.2);
progressbar(1);
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
        a(i)=a(i)-x1r(ie)*exp( -domegan*ttt )*sin( omegad*ttt + x3r(ie) );
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
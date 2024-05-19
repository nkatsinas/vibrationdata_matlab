%
%   quake_srs_synth_phase_3c.m  ver 1.7  by Tom Irvine
%
function[raccel,ramp,last_wavelet,f,amp,NHS,td,...
           wavelet_low,wavelet_up,alpha,beta]=...
           quake_srs_synth_phase_3c(f,dt,amp,NHS,td,t,last_wavelet,...
              srs_spec_12,dlimit,fn,raccel,a1,a2,b1,b2,b3,nsec,...
                   error_limit,wavelet_low,wavelet_up,alpha,beta)
%


num=length(fn);     

tpi=2*pi;

num2=length(t);

duration=t(num2)-t(1);
%
sr=1/dt;

fl=3/duration;
fu=sr/10;

if(fu>max(fn))
    fu=max(fn);
end

fh=(fu+fl)/2;
omegau=fu*tpi;

out1=sprintf(' fl = %10.4g Hz  fh = %10.4g Hz  fu = %10.4g Hz \n',fl,fh,fu);
disp(out1);

x1r=zeros(num2,1);
x2r=zeros(num2,1);
x3r=zeros(num2,1);
x4r=zeros(num2,1);

A=max(amp)*0.3;

fm1=(fu-fl)*rand()+fl;
fm2=(fu-fl)*rand()+fl;

error_max=1.0e+90;
error_peaks=1.0e+90;

progressbar;
for ie=1:nsec
    
        iar=1;
        ibr=2;
    
        ferr1=fm1;
        ferr2=fm2;
    
        progressbar(ie/nsec);
%
        out1=sprintf(' frequency case %d ',ie);
        disp(out1);
%
        for ij=1:3000
%            
            x1=A*(-0.5+1*rand());
            
            if(ij<10 || rand()<0.5)
                x2=(fu-fl)*rand()+fl;
            end
            
            x3=3 + 2*round(20.*rand()*rand());
            x4=duration*0.2*rand();
            
            x2=x2*tpi;
            
            
            if(ij>20 && rand()>0.7)
                x1=x1r(ie)*(0.98+0.04*rand());
                x2=x2r(ie)*(0.98+0.04*rand());
                x3=x3r(ie);
                x4=x4r(ie)*(0.98+0.04*rand());  
                               
            end
            
            if(rand()<0.15)
                if(rand()<0.5)
                    x2=tpi*ferr1*(0.98+0.04*rand());
                else
                    x2=tpi*ferr2*(0.98+0.04*rand());
                end
            end
            
            while( x2 > omegau)
                x2=tpi*((fu-fl)*rand()+fl);                
            end
            

            
%            out1=sprintf('* %d %8.4g %8.4g rec=%8.4g',ij,x2/tpi,omegau/tpi,x2r(ie));
%            disp(out1);             
            
            iflag=0;
            while(1)
                for iv=1:100
%
                    if( tpi*x3/(2.*x2) + x4 < duration )
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
            
%                out1=sprintf('** %8.4g %8.4g',x2/tpi,omegau/tpi);
%                disp(out1);  
            
            if(x3<3)
                x2=omegau;
                x3=3;
                x4=0;
            end   
            
 %%                out1=sprintf('*** %8.4g %8.4g',x2/tpi,omegau/tpi);
 %%               disp(out1); 
                
            if( x2 > omegau)
                disp(out1);                    
                x2=tpi*((fu-fl)*rand()+fl);                 
 %%               uuu=input;
            end    
                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
            
            if(ij==1)
                x1=0;
            end
           

            
            aa=raccel;
            
            if(x4<0.005)
                x4=0.005;
            end

            t1=x4 + t(1);
            t2=t1 + tpi*x3/(2.*x2);
                
            ia=ceil(t1/dt);
            ib=ia+floor((t2-t1)/dt);
            
            if(ia==0)
                ia=1;
            end
            
            if(ib>num2)
                ib=num2;
            end
                       
            
            for iq=ia:ib

                arg=x2*(t(iq)-t1);  
                aa(iq)=aa(iq)+x1*sin(arg/double(x3))*sin(arg);    
  
            end
            
 
            error=0;
            
            lerr=0;
            
            merr=0;
            
            ierr=0;
            
                               
            for j=1:num
       
                forward=[ b1(j),  b2(j),  b3(j) ];    
                back   =[     1, -a1(j), -a2(j) ];    
%    
                resp=filter(forward,back,aa);
%
                xmax=max(resp);
                xmin=abs(min(resp));
                
                e1=(20*log10(xmax/srs_spec_12(j)));
                e2=(20*log10(xmin/srs_spec_12(j)));
                  
                e1a=abs(e1);
                e2a=abs(e2);
                
%%%                
                   
                if(e1a>merr)
                    merr=e1a;
                    fm1=fn(j);
                end
                if(e2a>merr)
                    merr=e2a;
                    fm2=fn(j);
                end                
                
%%%                
                if(e1<lerr)
                    lerr=e1;
                end
                if(e2<lerr)
                    lerr=e2;
                end                 
%%%                



                if(abs(e1)>ierr)
                    ierr=e1a;
                end
                if(abs(e2)>ierr)
                    ierr=e2a;
                end                
                
                error=error+e1a;
                error=error+e2a;          
                
            end
            
%            error
%            lerr
%            merr
            
            error=error+num*(abs(lerr)+abs(merr));
            error_p=abs(lerr)+abs(merr);
            
            
%                    out1=sprintf('%d %8.4g %6.3g %6.3g %6.3g %6.3g %6.3g %6.3g',...
%                              ij,error_max,merr,abs(lerr),x1,x2/tpi,x3,x4);
%                          disp(out1);
%                          uuu=input(' ');
            
        
            if( (error<error_max || error_p<error_peaks) && x2<omegau)
                
                x1r(ie)=x1;
                x2r(ie)=x2;
                x3r(ie)=x3;
                x4r(ie)=x4;
                iar=ia;
                ibr=ib;
                               
                if(error<error_max)
                    error_max=error;
                    out1=sprintf('%d %9.5g %6.4g %6.4g %6.3g %6.3g %6.3g %6.3g',...
                              ij,error_max,merr,abs(lerr),x1,x2/tpi,x3,x4);                    
                end
                if(error_p<error_peaks)
                    error_peaks=error_p;
                    out1=sprintf('%d %9.5g %6.4g %6.4g %6.3g %6.3g %6.3g %6.3g *',...
                               ij,error_max,merr,abs(lerr),x1,x2/tpi,x3,x4);
                end             
               
                disp(out1);
                
                if(merr<error_limit && abs(lerr)<error_limit)
                    break;
                end                
            end          
        end
        
        last_wavelet=last_wavelet+1;
        f(last_wavelet)=x2r(ie)/tpi;
        amp(last_wavelet)=x1r(ie);
        NHS(last_wavelet)=x3r(ie);
        td(last_wavelet)=x4r(ie);
        
        beta(last_wavelet)=tpi*f(last_wavelet);
        alpha(last_wavelet)=beta(last_wavelet)/double(NHS(last_wavelet));
        
        wavelet_low(last_wavelet)=iar;
        wavelet_up(last_wavelet)=ibr;
        
        [raccel]=generate_time_history_wavelet_table_q(f,amp,NHS,td,t,...
                                        wavelet_low,wavelet_up,alpha,beta);

        out1=sprintf('**  %8.4g %8.4g %8.4g ',merr,abs(lerr),error_limit);
        disp(out1);
        
        if(merr<error_limit && abs(lerr)<error_limit)
            progressbar(1);
            pause(0.5);
            break;
        end
end

progressbar(1)
pause(0.6);

ramp=amp;
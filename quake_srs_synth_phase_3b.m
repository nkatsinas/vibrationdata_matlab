%
%   quake_srs_synth_phase_3b.m  ver 1.7  by Tom Irvine
%
function[raccel,ramp,last_wavelet,f,amp,NHS,td,...
           wavelet_low,wavelet_up,alpha,beta]=...
           quake_srs_synth_phase_3b(f,dt,amp,NHS,td,t,last_wavelet,...
              srs_spec_12,dlimit,fn,raccel,a1,a2,b1,b2,b3,nsec,...
                   error_limit,wavelet_low,wavelet_up,alpha,beta,delay_max)
%

wdamp=[    -0.6467      97.819   7      0.0046; 
            0.8065     100.041    3      0.0000; 
            -0.1842      99.517   13      0.0249; 
            -0.1222      80.299   7      0.0066; 
            0.1827     138.044   3      0.0060];

sz=size(wdamp);

wavenum=sz(1);

out1=sprintf(' wavenum=%d \n',wavenum);
disp(out1);

tpi=2*pi;
num2=length(t);

tdmin=0;
maxa=0;

for i=1:num2
    x=abs(raccel(i));
    if(x>maxa)
        maxa=x;
        tdmin=t(i);
    end    
end    

num=length(fn);     


duration=t(num2)-t(1);
%

fl=1.6/duration;
fu=max(fn);

fh=(fu+fl)/2;

out1=sprintf(' fl = %10.4g Hz  fh = %10.4g Hz  fu = %10.4g Hz \n',fl,fh,fu);
disp(out1);


x1=zeros(wavenum,1);
x2=zeros(wavenum,1);
x3=zeros(wavenum,1);
x4=zeros(wavenum,1);
x1r=zeros(wavenum,1);
x2r=zeros(wavenum,1);
x3r=zeros(wavenum,1);
x4r=zeros(wavenum,1);

ia=zeros(wavenum,1); 
ib=zeros(wavenum,1);   
iar=zeros(wavenum,1); 
ibr=zeros(wavenum,1);  
t1=zeros(wavenum,1);  

fm1=(fu-fl)*rand()+fl;
fm2=(fu-fl)*rand()+fl;

ferr1=fm1;
ferr2=fm2;

error_max=1.0e+90;
error_peaks=1.0e+90;

%
noct=log(fu/fl)/log(2);

sx=(-1+length(srs_spec_12));

s=zeros(sx,1);

for i=1:sx
    s(i)=log(srs_spec_12(i+1)/srs_spec_12(i))/log(fn(i+1)/fn(i));
end


progressbar;
for ie=1:nsec

        iflag=0; 
        
        ic=1;
   
        
        progressbar(ie/nsec);
%
        out1=sprintf(' frequency case %d ',ie);
        disp(out1);
       
%
        for ij=1:2000
%            
            kflag=0;
            
            if(ij>20 && rand()>0.5)
                if(rand()<0.5)
                    x2a=x2ar*(0.98+0.04*rand());
                    ic=2;
                else
                    if(rand()<0.5)
                        x2a=ferr1*(0.98+0.04*rand());
                        ic=3;
                    else
                        x2a=ferr2*(0.98+0.04*rand());
                        ic=4;
                    end
                end
                kflag=1;
            else
                x2a=fl*2^(noct*rand());
                ic=5;
            end  
                
            AA=0;
            
            for iv=1:sx

                if(x2a>=fn(iv) && x2a<=fn(iv+1))
                    AA=srs_spec_12(iv)*(x2a/fn(iv))^s(iv);
                    AA=AA/4;
                    break;
                end
            end
                       
            x1a=AA*(-0.5+1*rand());
            
            if(kflag==1)
                x1a=x1ar*(0.98+0.04*rand());
            end    
            
                
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
            
            if(ij==1)
                x1a=0;
            end
           
                      
            if(ij>20 && kflag==1)
                x4a=x4ar*(0.98+0.04*rand());
            else    
                x4a=delay_max*rand();
            end
            
            tstart=tdmin+x4a;
            
            while(1)
                
                qflag=0;                
            
                for iw=1:wavenum
                    
                    scale=(x2a/100.);
                    
                    x1(iw)=x1a*wdamp(iw,1);
                    x2(iw)=tpi*scale*wdamp(iw,2);
                    x3(iw)=wdamp(iw,3);                
                    x4(iw)=wdamp(iw,4)/scale+tstart;  
                 
                    t1(iw)=x4(iw) + t(1);
                    t2=t1(iw) + tpi*x3(iw)/(2.*x2(iw));
                    
                    if(t2>=duration)
                        
                         x1(iw)=0;
                         x4(iw)=0;
                         
                         t1(iw)=x4(iw) + t(1);
                         t2=t1(iw) + tpi*x3(iw)/(2.*x2(iw));                        
                        
 %                       x2a=x2a*1.1;
 %                       qflag=1;
                    
                    end
                    
                
                    ia(iw)=ceil(t1(iw)/dt);
                    ib(iw)=ia(iw)+floor((t2-t1(iw))/dt);
            
                    if(ia(iw)==0)
                        ia(iw)=1;
                    end
                    if(ib(iw)==ia(iw))
                        ib(iw)=ia(iw)+1;
                    end
            
                    if(ib(iw)>num2)
                        ib(iw)=num2;
                    end      
                    
                end
                
                if(max(abs(x1))>1.0e-06 || ij==1)
                    break;
                else
%%                    out1=sprintf('e:  %8.4g %8.4g',max(abs(x1)),x2(1));
%%                    disp(out1);
                    x2a=fl*2^(noct*rand());
                    
                    AA=0;
            
                    for iv=1:sx

                        if(x2a>=fn(iv) && x2a<=fn(iv+1))
                            AA=srs_spec_12(iv)*(x2a/fn(iv))^s(iv);
                            AA=AA/4;
                            break;
                        end
                    end
                       
                    x1a=AA*(-0.5+1*rand());
                    x4a=delay_max*rand();
                    tstart=tdmin+x4a;
                    
 %%                   out1=sprintf('f:  %8.4g %8.4g %8.4g',x1a,x2a,x4a);
 %%                   disp(out1);
                    
                end    
                
            end   
    
           aa=raccel;  
           
           if(ij>1)
                for iw=1:wavenum
                    try
                                               
                        for iq=ia(iw):ib(iw)
                        
                            arg=x2(iw)*(t(iq)-t1(iw));
                        
                            aa(iq)=aa(iq)+x1(iw)*sin(arg/double(x3(iw)))*sin(arg);    
  
                        end
                    catch
                        length(aa)
                        out1=sprintf('error %d %d %d num2=%d t1=%8.4g t2=%8.4g \n f=%8.4g nhs=%8.4g',iw,ia(iw),ib(iw),num2,t1,t2,x2(iw),x3(iw));
                        disp(out1);  
                    end
                end % iw
            end
            
            [error,error_p,lerr,merr,ierr,fm1,fm2]=...
                  quake_srs_function(b1,b2,b3,a1,a2,fn,num,aa,srs_spec_12);
            
%                    out1=sprintf('%d %8.4g %6.3g %6.3g %6.3g %6.3g %6.3g %6.3g',...
%                              ij,error_max,merr,abs(lerr),x1,x2/tpi,x3,x4);
%                          disp(out1);
%                          uuu=input(' ');
            
 
                if( error<error_max || ij==1)
                 
                    error_max=error;
                    x1ar=x1a;                    
                    x2ar=x2a;
                    x4ar=x4a;
                    
                    iflag=1; 
                 
                    for iw=1:wavenum
                        x1r(iw)=x1(iw);
                        x2r(iw)=x2(iw);
                        x3r(iw)=x3(iw);
                        x4r(iw)=x4(iw);
                        iar(iw)=ia(iw);
                        ibr(iw)=ib(iw);
                    end  % iw              
               
                    out1=sprintf('%d %10.6g %7.4g %7.4g %6.3g %6.3g %6.3g %6.3g * %6.3g %6.3g %d',...
                               ij,error,merr,abs(lerr),x1(1),x2(1)/tpi,x3(1),x4(1),ferr1,ferr2,ic);
                             
                    disp(out1);
                
                    ferr1=fm1; % here
                    ferr2=fm2;
          
                end % check
                
                if(merr<error_limit && abs(lerr)<error_limit && iflag==1)
                    break;
                end % check                
                
        end  % ij  
        
        for iw=1:wavenum
            
            out1=sprintf('%6.3g %6.3g %6.3g %6.3g ***',...
                               x1r(iw),x2r(iw)/tpi,x3r(iw),x4r(iw));
            disp(out1);
            
            last_wavelet=last_wavelet+1;
            f(last_wavelet)=x2r(iw)/tpi;
            amp(last_wavelet)=x1r(iw);
            NHS(last_wavelet)=x3r(iw);
            td(last_wavelet)=x4r(iw);
        
            beta(last_wavelet)=tpi*f(last_wavelet);
            alpha(last_wavelet)=beta(last_wavelet)/double(NHS(last_wavelet));
        
            wavelet_low(last_wavelet)=iar(iw);
            wavelet_up(last_wavelet)=ibr(iw);
                                           
        end % iw                           
       
        [raccel]=generate_time_history_wavelet_table_q(f,amp,NHS,td,t,...
                                        wavelet_low,wavelet_up,alpha,beta);        
        
        if(merr<error_limit && abs(lerr)<error_limit)
            progressbar(1);
            pause(0.5);
            break;
        end  % if check  
        
end  % ie

progressbar(1);
pause(0.6);

ramp=amp;
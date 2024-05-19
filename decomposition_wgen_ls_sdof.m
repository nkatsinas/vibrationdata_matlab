%
%  decomposition_wgen_ls_sdof.m   version 3.3   by Tom Irvine
%
function[x1r,x2r,x3r,x4r,ar]=decomposition_wgen_ls_sdof(t,a,minw,maxw,start_time,ffmin,ffmax,ijk)

    jflag=0;

    x1r=0;
    x2r=0;
    x3r=3;
    x4r=0;
    ar=a;

%
    tp=2*pi;

try

    if(isempty(t))
        warndlg('error 5');
        return;
    end
    if(isempty(a))
        warndlg('error 6');
        return;
    end

    if(length(t)~=length(a))
        warndlg('error 7');
        return;
    end
%
    disp(' ');

    dt=mean(diff(t));
    sr=1/dt;

    ns=length(t);

    error_max=std(a);

%    T=t(end)-t(1);
    

catch
    warndlg('Error 8');
    return;
end

try
    [freq,omega]=frequency(t,a,sr,ffmin,ffmax,ijk);
catch
    warndlg('ref 1  Freq failed');
    return;
end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    

    for i=1:200
  
        try
            N=minw+2*(i-1);
            
            if(N>maxw)
                break;
            end
    
            dur=N/(2*freq);
    
            k=floor(dur/dt);
    
            W=zeros(ns,1);
      
            tt=(0:k-1)*dt;
       
            omegat=omega*tt;
        catch
            warndlg('Loop pre failure');
            return;
        end

        try
            W(1:k,1)=sin(omegat/N).*sin(omegat);
        catch
            warndlg('Wavelet sine failed');
            return;
        end
            
        try 
            [~,~,tmax]=cross_correlation_function(a,W,ns,dt);
            imax=round(tmax/dt);
        catch
            warndlg('cross_correlation_function failed');
            return;
        end
      
    
        if((1+imax)>=1 && (k+imax)<=ns)
        
            try
                WW=zeros(ns,1);
 
                WW(1+imax:k+imax)=W(1:k,1);
            
                Z=WW;
                Y=a;

                A=pinv(Z'*Z)*(Z'*Y);  
            
                Q=A*WW;
            catch
                warndlg('Q & WW failed');
                return;
            end
                
            try
                aQ=a-Q;
                error=std(aQ);
            catch
                warndlg('error failed');
                return;
            end
            
            try
                tdelay=imax*dt;
                ttd=t(1)+tdelay;
            catch
                warndlg('ttd failed');
                return;
            end
                
            try
                if(error<error_max && ttd>=start_time)
                    
                    if(jflag==0)
                        disp(' ');
                        disp(' Trial   Error      Amplitude   Freq(Hz)   NHS    delay(sec) ');
                        jflag=1;
                    end
                    
                    
                    error_max=error;
                    ar=aQ;                  
                    x1r=A;
                    x2r=omega;
                    x3r=N;
                    x4r=ttd;
                    imaxr=imax;
                    fprintf(' %d  %11.4e  %9.4f  %9.4f  %d  %9.4f \n',i,error_max,x1r,x2r/tp,x3r,x4r);           
                end
            catch
                warndlg('error_max failed');
                return;
            end
     
        else
            break;
        end
    
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   if(x1r==0)
       return;
   end

    try
        N=x3r;
        imax=imaxr;
    catch
        warndlg('ref 2 failed');
        return;
    end
        
    for i=1:400
        
        try

            try
                omega=x2r*(0.995+0.01*rand());
                freq=omega/tp;
                
                q=randi([1 5]);

                if(q==1)
                    imax=imaxr-2;
                end
                if(q==2)
                    imax=imaxr-1;
                end
                if(q==3)
                    imax=imaxr;
                end
                if(q==4)
                    imax=imaxr+1;
                end
                if(q==5)
                    imax=imaxr+2;
                end                
            catch
                warndlg('@ freq failure');
                return;
            end
    
            try
                dur=N/(2*freq);
    
                k=floor(dur/dt);
            catch
                warndlg('@ dur failure');
                return;
            end
            
            try
                W=zeros(ns,1);
      
                tt=(0:k-1)*dt;
       
                omegat=omega*tt;
            catch
                warndlg('@ type 3 failure');
                return;
            end
    
        catch
            warndlg('@ Loop pre failure');
            return;
        end
        
        try
            W(1:k,1)=sin(omegat/N).*sin(omegat);
        catch
            warndlg('Wavelet sine failed');
            return;
        end
            
      

        if((1+imax)>=1 && (k+imax)<=ns)
        
            try
                WW=zeros(ns,1);
 
                WW(1+imax:k+imax)=W(1:k,1);
            
                Z=WW;
                Y=a;

                A=pinv(Z'*Z)*(Z'*Y);  
            
                Q=A*WW;
            catch
                warndlg('@ Q & WW failed');
                return;
            end
                
            try
                aQ=a-Q;
                error=std(aQ);
            catch
                warndlg('@ error failed');
                return;
            end
            
            try
                tdelay=imax*dt;
                ttd=t(1)+tdelay;
            catch
                warndlg('@ ttd failure');
                return;
            end
                
            try
                if(error<error_max && ttd>=start_time)
                    error_max=error;
                    ar=aQ;                  
                    x1r=A;
                    x2r=omega;
                    x3r=N;
                    x4r=ttd;
                    imaxr=imax;
                    fprintf('@ %d  %11.4e  %9.4f  %9.4f  %d  %9.5f \n',i,error_max,x1r,x2r/tp,x3r,x4r);           
                end
            catch
                warndlg('@ error_max failure');
                return;                
            end
     
        else
            break;
        end
    
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    disp(' ');
   

end
  
%%%%%%%%%

function[freq,omega]=frequency(t,a,sr,ffmin,ffmax,ijk)

    jj=0;

    try
        
        if(rand()>0.5 || ijk <=10)
    
            try
                f = fit(t, a, 'sin1');
                omega=f.b1;
                freq=omega/(2*pi);
                jj=1;
            catch
            end
           
        end
        if(jj==0 || freq<ffmin || freq>ffmax )
 
            freq=ffmin+rand()*(ffmax-ffmin);
            jj=2;
        end
   
        omega=(2*pi)*freq;
    
    catch
        warndlg('Frequency failed');
        return;
    end
    
    fprintf('%d  freq=%8.4g \n',jj,freq);
end
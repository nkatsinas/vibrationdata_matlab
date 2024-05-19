%
%    sf_engine3_ndel_alt.m  ver 2.5  by Tom Irvine
%
function[av,Ar,Br,omeganr,dampr]=sf_engine3_ndel_alt(dur,av,t,dt,md1,md2,fmax)


Ar=0;
Br=0;
omeganr=0;
dampr=0;

error_rth=av;

t=t-t(1);

%
tp=2*pi;
tpi=tp;
%
%

fft_freq=0;

%
    amp=av-mean(av);

    [zcf,~,~]=zero_crossing_function(amp,dur);
    
%
    m_choice=1;  % mean removal
    h_choice=1;  % rectangual window
%    
    n=length(amp); 
    N=2^floor(log(n)/log(2));
    [freq,full,~,~]=full_FFT_core(m_choice,h_choice,amp,N,dt);    
%
    magnitude_FFT=[freq full];
%    
    try
        [~,fft_freq]=find_max(magnitude_FFT);
%
        fprintf(' zero crossing frequency = %8.4g Hz \n',zcf);
%
        fprintf(' FFT frequency = %8.4g Hz \b',fft_freq);
    
    catch
        
        warndlg('FFT Error');
        
    end

%
errormax=std(amp);
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   Phase(rad)   damp');
%
%
Y=amp;
Y=fix_size(Y);
%
%
%  f(t)=A*cos(omegan*t) + B*sin(omegan*t) + C;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dmin=min([md1 md2]);
dmax=max([md1 md2]);

nt=60;

nh=round(nt/4);

progressbar;

for ijk=1:nt

    progressbar(ijk/nt);

    damp=(dmax-dmin)*rand()+dmin;
    
    if(ijk>nh && rand()>0.5)
       
        damp=dampr*(0.98+0.04*rand());
        
    end

    if(damp<dmin)
        damp=dmin;
    end
    if(damp>dmax)
        damp=dmax;
    end
    
    for j=1:2
    
        if(j==1)
            freq_est=zcf;
        else
            freq_est=fft_freq;
        end
        
        if(freq_est>fmax)
            freq_est=(0.1+0.9*rand())*fmax;
        end
    
        omegan=tp*freq_est;
   
        [A,B]=damped_sine_lsf_function_alt_3(Y,t,omegan,damp);
         
  %      y=exp(-damp*omegan*t).*(A*cos(omegan*t) + B*sin(omegan*t));
         
         p0(1)=damp;
         p0(2)=omegan;
         p0(3)=A;
         p0(4)=B;
  
         f=@(pq)exp(-pq(1)*pq(2)*t).*(pq(3)*cos(pq(2)*t) + pq(4)*sin(pq(2)*t));
         
         options = optimset('MaxFunEvals',10000);
         pq = fminsearch(@(pq) norm(f(pq) - amp), p0,options);

         y=f(pq);
         damp=pq(1);
         omegan=pq(2);
         A=pq(3);
         B=pq(4);
         
         if(omegan>tp*fmax)
            omegan=0;
            A=0;
            B=0;
         end

       [errormax,error_rth,Ar,Br,omeganr,dampr]=...
            sfe3_error_core(omegan,damp,errormax,error_rth,amp,A,B,j,Ar,Br,omeganr,dampr,y,fmax);

    end
   


    
end

pause(0.2);
progressbar(1);


%%%

 
%   
av=error_rth;
%
ave=mean(av);  
sd=std(av);
%	
out4=sprintf('\n  ave=%12.4g  sd=%12.4g \n',ave,sd);
disp(out4)    
%

%%    out1=sprintf('** length(av)=%g  ',length(av)); 
%%    disp(out1);  



function[errormax,error_rth,Ar,Br,omeganr,dampr]=...
          sfe3_error_core(omegan,damp,errormax,error_rth,amp,A,B,j,Ar,Br,omeganr,dampr,y,fmax)

    tp=2*pi;
    

        error=amp-y;
%
        if(std(error)<errormax)
%
            error_rth=error;
            errormax=std(error);

            Ar=A;
            Br=B;
            omeganr=omegan;
            dampr=damp;
%

            x1=sqrt(A^2+B^2);
            x2=omegan;
            x3=atan2(A,B);
            x4=damp;
        
%        out1=sprintf('ABC %8.4g %8.4g %8.4g ',A,B,C);
%        disp(out1);

            fprintf(' %6ld  %13.5e  %10.4g %9.4f %9.4f %9.4f %7.3g \n',j,errormax,x1,x2/tp,x3,x4,fmax);
          
            
            if(x2/tp>fmax)
                disp(' fmax error 1');
                uuu=input(' ');
            end
          
        end








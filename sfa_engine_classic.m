%
%    sfa_engine_classic.m  ver 2.2   January 19, 2015
%
function[a,x1r,x2r,x3r,error_rth,syna,cnew] = ...
              sfa_engine_classic(dur,a,t,~,~,flow,fup,ie,nt,x1r,x2r,x3r,...
                                            original,running_sum,istr,dt)
%
clear ta;
clear error_rth
clear syna;


t=t-t(1);

%
tp=2*pi;
%
%
zcf=0;
fft_freq=0;
freq_est=0;
%
if(istr==2)
    amp=a-mean(a);
    nzc=0;
    pzc=0;
    for i=1:length(a)-1
%
       if(amp(i) <=0 && amp(i+1) > 0)
           pzc=pzc+1;
       end
%       
       if(amp(i) >=0 && amp(i+1) < 0)
           nzc=nzc+1;      
       end 
    end
%    
    zcf=((pzc+nzc)/2)/dur;  
%
    m_choice=1;  % mean removal
    h_choice=1;  % rectangual window
%    
    n=length(a); 
    N=2^floor(log(n)/log(2));
    [freq,full,phase,complex_FFT]=full_FFT_core(m_choice,h_choice,a,N,dt);    
%
    magnitude_FFT=[freq full];
%    
    [~,fft_freq]=find_max(magnitude_FFT);
%
    out1=sprintf(' zero crossing frequency = %8.4g Hz ',zcf);
    disp(out1);    
%
    out1=sprintf(' FFT frequency = %8.4g Hz ',fft_freq);
    disp(out1);
%
end
%
sd=std(a);
%
am=sd;
%
errormax=1.0e+53;
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   Phase(rad)  ');
%
jk=0;
%
Y=a;
Y=fix_size(Y);
%
ta=t;

%
%  f(t)=A*cos(omega*t) + B*sin(omega*t) + C;

fig_num=100;

for j=1:2
    
    if(j==1)
        freq_est=zcf;
    else
        freq_est=fft_freq;
    end
    
    omega=tp*freq_est;
    
    
    [A,B,C]=sine_lsf_function_alt(Y,ta,omega);
    
    y=A*cos(omega*t) + B*sin(omega*t) + C;
    
    
    error=a-y;
%
    if(std(error)<errormax)
%
        syna=-(error-a);
        error_rth=error;
        errormax=std(error);

        yr=y;
        
        Ar=A;
        Br=B;
        Cr=C;
        omegar=omega;
%

        x1=sqrt(A^2+B^2);
        x2=omega;
        x3=atan2(A,B);
        
%        out1=sprintf('ABC %8.4g %8.4g %8.4g ',A,B,C);
%        disp(out1);

        out4 = sprintf(' %6ld  %13.4e  %10.4g %9.4f %9.4f  ',j,errormax,x1,x2/tp,x3);
        disp(out4);
    
        cnew=running_sum+yr;
          
        
    end

end
   

%
%  IEEE-STD-1057 four parameter least squares fit to sine wave data
%
%  f(t)=A*cos(omega*t) + B*sin(omega*t) + C;


A=Ar;
B=Br;
C=Cr;

omega=omegar;

for j=1:nt
        
    na=length(Y);
%
    Z=ones(na,4);
%
    for i=1:na
            omt=omega*t(i);
            
            cc=cos(omt);
            ss=sin(omt);
            
            Z(i,1)=cc;
            Z(i,2)=ss;            
 
            Z(i,4)=(-A*ss +B*cc)*t(i);            
    end
        
    V=pinv(Z'*Z)*(Z'*Y);
    
    A=V(1);
    B=V(2);
    C=V(3);
    delta_omega=V(4);
    
    omega=omega+delta_omega;
                
%
    y=A*cos(omega*t)+B*sin(omega*t)+C;
    

    error=a-y;
    
%%    out1=sprintf('%d  %8.4g  A=%8.4g  B=%8.4g  C=%8.4g  f=%9.5g',j,std(error),A,B,C,omega/tp);
%%    disp(out1);
%
    if(std(error)<errormax)
%
        syna=-(error-a);
        error_rth=error;
        errormax=std(error);

        yr=y;
        
        Ar=A;
        Br=B;
        Cr=C;
        omegar=omega;
%

        x1=sqrt(A^2+B^2);
        x2=omega;
        x3=atan2(A,B);

        out4 = sprintf(' %6ld  %13.5e  %10.4g %9.4f %9.4f  ',j,errormax,x1,x2/tp,x3);
        disp(out4);
    
        cnew=running_sum+yr;
        
    end 
    
end
    

%%%

x1r(ie)=sqrt(Ar^2+Br^2);
x2r(ie)=omegar;
x3r(ie)=atan2(A,B);
 
%   
a=error_rth;
%
ave=mean(a);  
sd=std(a);
%	
out4=sprintf('\n  ave=%12.4g  sd=%12.4g \n',ave,sd);
disp(out4)    
%

 

%
%    sfa_engine_manul.m  ver 2.3   by Tom Irvine
%
function[a,Ar,Br,omeganr,nstartr]=sfa_engine_delay(dur,a,t,dt,flow,fup)

error_rth=a;

Ar=0;
Br=0;
omeganr=0;

t=t-t(1);

%
tp=2*pi;
%


%
    amp=a-mean(a);
   
%

%
%
errormax=std(amp);
%
disp(' ');
disp('  Trial     Error      Amplitude   Freq(Hz)   Phase(rad)  ');
%
%
Y=a;
Y=fix_size(Y);
%
ta=t;

%
%  f(t)=A*cos(omega*t) + B*sin(omega*t) + C;


num=length(t);

y=zeros(num,1);

for j=1:4
    
    freq_est=(fup-flow)*rand()+flow;
    
    omega=tp*freq_est;
    
    
    [A,B,C]=sine_lsf_function_alt(Y,ta,omega);
    
    y(nstart:num)=A*cos(omega*t(nstart:num)) + B*sin(omega*t(nstart:num)) + C;
    
    
    [errormax,error_rth,Ar,Br,omeganr,nstartr]=sfa_error_core(a,y,errormax,error_rth,A,B,Ar,Br,omega,omeganr,nstartr);
       
end
   

%
%  IEEE-STD-1057 four parameter least squares fit to sine wave data
%
%  f(t)=A*cos(omega*t) + B*sin(omega*t) + C;


A=Ar;
B=Br;


omega=omeganr;

for j=1:50
        
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
    
    [errormax,error_rth,Ar,Br,omeganr]=sfa_error_core(a,y,errormax,error_rth,A,B,Ar,Br,omega,omeganr);

    
end
    

%%%

 
%   
a=error_rth;
%
ave=mean(a);  
sd=std(a);
%	
out4=sprintf('\n  ave=%12.4g  sd=%12.4g \n',ave,sd);
disp(out4)    
%

 
function[errormax,error_rth,Ar,Br,omeganr]=sfa_error_core(a,y,errormax,error_rth,A,B,Ar,Br,omega,omeganr)

    tp=2*pi; 

    error=a-y;

    if(std(error)<errormax)
%
        error_rth=error;
        errormax=std(error);

        Ar=A;
        Br=B;
        omeganr=omega;
%

        x1=sqrt(A^2+B^2);
        x2=omega;
        x3=atan2(A,B);

        out4 = sprintf(' %6ld  %13.5e  %10.4g %9.4f %9.4f  ',j,errormax,x1,x2/tp,x3);
        disp(out4);
    
        
    end 
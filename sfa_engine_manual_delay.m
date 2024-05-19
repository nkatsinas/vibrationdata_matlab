%
%    sfa_engine_manul.m  ver 2.3   by Tom Irvine
%
function[a,Ar,Br,omeganr,nstartr]=sfa_engine_delay(dur,a,t,dt,flow,fup)

error_rth=a;

Ar=0;
Br=0;
omeganr=0;
nstartr=0;

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

for j=1:10
    
    freq_est=(fup-flow)*rand()+flow;
    
    omega=tp*freq_est;
    
    nstart=ceil(num*rand);
    if(nstart>num-10)
        nstart=num-10;
    end
    
    
%
    na=length(Y);
%
    Z=ones(na,3);
%
    for k=nstart:na
            omt=omega*t(k);
            Z(k,1)=cos(omt);
            Z(k,2)=sin(omt);
    end
%
    V=pinv(Z'*Z)*(Z'*Y);
    
    A=V(1);
    B=V(2);
    C=V(3);         
%
    
    
    y(nstart:num)=A*cos(omega*t(nstart:num)) + B*sin(omega*t(nstart:num)) + C;
    
    
    [errormax,error_rth,Ar,Br,omeganr,nstartr]=sfa_error_core_delay(a,y,errormax,error_rth,A,B,Ar,Br,omega,omeganr,nstart,nstartr);
       
end

%
%  IEEE-STD-1057 four parameter least squares fit to sine wave data
%
%  f(t)=A*cos(omega*t) + B*sin(omega*t) + C;


A=Ar;
B=Br;
nstart=nstartr;

omega=omeganr;

for j=1:50
        
    na=length(Y);
%
    Z=ones(na,4);
%
    for i=nstart:na
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
    y=zeros(na,1);
    y(nstart:na)=A*cos(omega*t(nstart:na))+B*sin(omega*t(nstart:na))+C;
    
    [errormax,error_rth,Ar,Br,omeganr,nstartr]=sfa_error_core_delay(a,y,errormax,error_rth,A,B,Ar,Br,omega,omeganr,nstart,nstartr);

    
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

 
function[errormax,error_rth,Ar,Br,omeganr,nstartr]=sfa_error_core_delay(a,y,errormax,error_rth,A,B,Ar,Br,omega,omeganr,nstart,nstartr)



    tp=2*pi; 

    a=fix_size(a);
    y=fix_size(y);
    
    error=a-y;

    
    if(std(error)<errormax)
%
        error_rth=error;
        errormax=std(error);

        Ar=A;
        Br=B;
        omeganr=omega;
        nstartr=nstart;
%

        x1=sqrt(A^2+B^2);
        x2=omega;
        x3=atan2(A,B);

        out4 = sprintf('   %13.5e  %10.4g %9.4f %9.4f  ',errormax,x1,x2/tp,x3);
        disp(out4);
    
        
    end 
    
   
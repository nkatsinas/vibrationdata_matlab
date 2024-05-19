

% damped_sine_find_function_delay.m  ver 1.0  by Tom Irvine

function[syn,residual,Ar,Br,omeganr,dampr,delayr]=damped_sine_find_function_delay(dur,av,amp_orig,t,dt,nfr,md1,md2)

%
Ar=zeros(nfr,1);
Br=zeros(nfr,1);
omeganr=zeros(nfr,1);
dampr=zeros(nfr,1);
delayr=zeros(nfr,1);

n=length(t);


for ie=1:nfr
%
    out4 = sprintf('\n frequency case %d \n',ie);
    disp(out4)    
%
    [av,Ar(ie),Br(ie),omeganr(ie),dampr(ie),delayr(ie)]=sf_engine3_ndel_alt_delay(dur,av,t,dt,md1,md2);

%
end

%
syn=zeros(n,1);
y=zeros(n,1);
%    
for ie=1:nfr

    tt=t-t(1);
    
    for i=1:n
        
        if(tt(i)>=delayr(ie))
            
            tq=tt(i)-delayr(ie);
    
            y(i)=exp(-dampr(ie)*omeganr(ie)*tq)*(Ar(ie)*cos(omeganr(ie)*tq) + Br(ie)*sin(omeganr(ie)*tq));    
            syn(i)=syn(i)+y(i);
        
        end
    
    end
    
%
end

residual=zeros(n,1);
 
for i=1:n
   residual(i)=amp_orig(i)-syn(i); 
end

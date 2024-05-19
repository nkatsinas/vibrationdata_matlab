

% damped_sine_find_function_delay_nt.m  ver 1.0  by Tom Irvine

function[syn,residual,Ar,Br,omeganr,dampr,delayr]=damped_sine_find_function_delay_nt(dur,av,amp_orig,t,dt,nfr,md1,md2,nt)

%
Ar=zeros(nfr,1);
Br=zeros(nfr,1);
omeganr=zeros(nfr,1);
dampr=zeros(nfr,1);
delayr=zeros(nfr,1);

n=length(t);

sr=1/dt;
fmax=sr/10;

for ie=1:nfr
%
    fprintf('\n frequency case %d \n\n',ie);   
%
    [av,Ar(ie),Br(ie),omeganr(ie),dampr(ie),delayr(ie)]=sf_engine3_ndel_alt_delay_nt(dur,av,t,dt,md1,md2,fmax,nt);
                                                                                    
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

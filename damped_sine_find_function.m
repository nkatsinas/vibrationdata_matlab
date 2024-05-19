

% damped_sine_find_function.m  ver 1.0  by Tom Irvine

function[syn,residual,Ar,Br,omeganr,dampr]=damped_sine_find_function(dur,av,amp_orig,t,dt,nfr,md1,md2)

%
Ar=zeros(nfr,1);
Br=zeros(nfr,1);
omeganr=zeros(nfr,1);
dampr=zeros(nfr,1);

n=length(t);


for ie=1:nfr
%
    out4 = sprintf('\n frequency case %d \n',ie);
    disp(out4)    
%
    [av,Ar(ie),Br(ie),omeganr(ie),dampr(ie)]=sf_engine3_ndel_alt(dur,av,t,dt,md1,md2);

%
end

%
syn=zeros(1,n);
%    
for ie=1:nfr

    tt=t-t(1);
    
    y=exp(-dampr(ie)*omeganr(ie)*tt).*(Ar(ie)*cos(omeganr(ie)*tt) + Br(ie)*sin(omeganr(ie)*tt));    
    
    syn=syn+y;
    
%
end

residual=zeros(n,1);
 
for i=1:n
   residual(i)=amp_orig(i)-syn(i); 
end

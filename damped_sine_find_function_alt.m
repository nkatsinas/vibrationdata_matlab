

% damped_sine_find_function_alt.m  ver 1.1  by Tom Irvine

function[syn,residual,Ar,Br,omeganr,dampr]=damped_sine_find_function_alt(dur,av,amp_orig,t,dt,nfr,md1,md2,fmax)

Ar=zeros(nfr,1);
Br=zeros(nfr,1);
omeganr=zeros(nfr,1);
dampr=zeros(nfr,1);

n=length(t);

for ie=1:nfr
%
    fprintf('\n frequency case %d \n\n',ie);  
%
    [av,Ar(ie),Br(ie),omeganr(ie),dampr(ie)]=sf_engine3_ndel_alt(dur,av,t,dt,md1,md2,fmax);

end

%
syn=zeros(n,1);
%    
for ie=1:nfr

    tt=t-t(1);
    
    y=exp(-dampr(ie)*omeganr(ie)*tt).*(Ar(ie)*cos(omeganr(ie)*tt) + Br(ie)*sin(omeganr(ie)*tt));    

    syn=syn+y;
end

residual=zeros(n,1);
 
for i=1:n
   residual(i)=amp_orig(i)-syn(i); 
end


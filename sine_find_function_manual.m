

%   sine_find_function_manual.m  ver 1.0  by Tom Irvine

function[syn,residual,Ar,Br,omeganr]=sine_find_function_manual(dur,a,amp_orig,t,dt,nfr,flow,fup)

n=length(t);

%   
%
Ar=zeros(nfr,1);
Br=zeros(nfr,1);
omeganr=zeros(nfr,1);
%
for ie=1:nfr
%
    out4 = sprintf('\n frequency case %d \n',ie);
    disp(out4)    
%
    [a,Ar(ie),Br(ie),omeganr(ie)]=sfa_engine_manual(dur,a,t,dt,flow(ie),fup(ie));
%
end

%
syn=zeros(n,1);
%    
for ie=1:nfr

    tt=t-t(1);  
    
    for i=1:n
        y=Ar(ie)*cos(omeganr(ie)*tt(i)) + Br(ie)*sin(omeganr(ie)*tt(i));   
        syn(i)=syn(i)+y;
    end    
     
%
end


residual=zeros(n,1);

for i=1:n
   residual(i)=amp_orig(i)-syn(i); 
end
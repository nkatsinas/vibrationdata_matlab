

%   sine_find_function_flag.m  ver 1.0  by Tom Irvine

function[syn,residual,Ar,Br,omeganr,iflag]=sine_find_function_flag(dur,a,amp_orig,t,dt,nfr)

syn=0;
residual=0;


n=length(t);

t=fix_size(t);
a=fix_size(a);

%   
%
Ar=zeros(nfr,1);
Br=zeros(nfr,1);
omeganr=zeros(nfr,1);

tt=t-t(1);

%
for ie=1:nfr
%
    fprintf('\n frequency case %d \n\n',ie); 
    
    iflag=0;
%
    try
        f = fit(tt, a, 'sin1');
        omeganr(ie)=f.b1;
        Ar(ie)=f.a1*sin(f.c1);
        Br(ie)=f.a1*cos(f.c1);
        y=Ar(ie)*cos(omeganr(ie)*tt) + Br(ie)*sin(omeganr(ie)*tt);
        a=a-y;
    catch    
        [a,Ar(ie),Br(ie),omeganr(ie),iflag]=sfa_engine_flag(dur,a,t,dt);
    end    
%

    if(iflag==1)
        return;
    end

end




%
syn=zeros(n,1);
%    
for ie=1:nfr
    
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
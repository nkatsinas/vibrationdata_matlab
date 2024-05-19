

%   sine_find_function.m  ver 1.0  by Tom Irvine

function[syn,residual,Ar,Br,omeganr]=sine_find_function(dur,a,amp_orig,t,dt,nfr)

syn=0;
residual=0;


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
    [a,Ar(ie),Br(ie),omeganr(ie),iflag]=sfa_engine_flag(dur,a,t,dt);
%

    if(iflag==1)
        break;
    end

end


if(iflag==1)
   warndlg('sfa error.  Check segment duratio.n '); 
   return;
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
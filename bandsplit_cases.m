%
%  bandsplit_cases.m  ver 1.1  by Tom Irvine
%
function[bpsd,numb]=bandsplit_cases(f,a,fi,ai,n,ni,df,nb)
%
bpsd=zeros(20,100,2);
numb=zeros(20,1);
%
[s,grms]=calculate_PSD_slopes_no(f,a);
%
goal=grms/sqrt(nb);
%
m1=1;
%
for j=1:nb
%
    for i=m1:ni
%       
        ms=0.5*df*ai(m1);
        if(i>m1)
            ms=ms+0.5*df*ai(i);
        end    
        if(i>(m1+1))
            ms=ms+df*sum(ai(m1+1:i-1));
        end    
%
        rms=sqrt(ms);
%
        if(rms>=goal || i==ni)
%
            bpsd(j,1,1)=fi(m1);
            bpsd(j,1,2)=ai(m1);
%
            k=1;
%
            for p=1:n
                if(f(p)>fi(m1) && f(p)<fi(i))
                    bpsd(j,k+1,1)=f(p);
                    bpsd(j,k+1,2)=a(p);                    
                    k=k+1;
                end
            end
%       
            bpsd(j,k+1,1)=fi(i);
            bpsd(j,k+1,2)=ai(i);             
%            
            numb(j)=k+1;
            m1=i;
            break;
        end
%
    end
%    
end
%
bpsd(nb,k+1,1)=f(n);
bpsd(nb,k+1,2)=a(n);
%
if(bpsd(nb,k+1,1)==bpsd(nb,k,1))
    numb(nb)=numb(nb)-1;
end        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
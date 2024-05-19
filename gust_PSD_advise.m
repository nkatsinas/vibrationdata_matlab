%
%    gust_PSD_advise.m  ver 1.1  November 15, 2012
%
function[df,mmm,NW]=gust_PSD_advise(dt,n,fstart)
%
NC=0;
for i=1:1000
%    
    nmp = 2^(i-1);
%   
    if(nmp <= n )
        ss(i) = 2^(i-1);
        seg(i) =n/ss(i);
        i_seg(i) = fix(seg(i));
        NC=NC+1;
    else
        break;
    end
end
%
dt
n
fstart
NC
nseg=length(i_seg)
%
for i=1:nseg
    out1=sprintf('%g',i_seg(i));
    disp(out1);
end
%
disp(' ')
out4 = sprintf(' Number of   Samples per   Time per        df               ');
out5 = sprintf(' Segments     Segment      Segment(sec)   (Hz)     dof     ');
%
disp(out4)
disp(out5)
%        
for i=1:NC
    j=NC+1-i;
    if j>0
        if( i_seg(j)>0)
%           str = int2str(i_seg(j));
            tseg=dt*ss(j);
            ddf=1./tseg;
%
            out1=sprintf('j=%d i_seg=%d fstart=%g tseg=%g',j,i_seg(j),fstart,tseg);
            disp(out1);
%           
%%             if(ddf<=fstart)
                out4 = sprintf(' %8d  %8d    %11.5f    %9.4f   %d',i_seg(j),ss(j),tseg,ddf,2*i_seg(j));
                disp(out4)
%%            end
        end
    end
    if(i==12)
        break;
    end
end
%
kflag=0;
while(kflag==0)
    disp(' ')
    NW = input(' Choose the Number of Segments from the first column:  ');
    disp(' ')
    for j=1:length(i_seg)
        if(NW==i_seg(j))
            kflag=1;
            break;
        end
    end
end
%
mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);
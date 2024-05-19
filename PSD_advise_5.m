%
%    PSD_advise_5.m  ver 1.1   by Tom Irvine
%
function[df,mmm,NW]=PSD_advise_5(dt,n)
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
%% disp(' ')
%% out4 = sprintf(' Number of   Samples per   Time per        df               ');
%% out5 = sprintf(' Segments     Segment      Segment(sec)   (Hz)     dof     ');
%
%% disp(out4)
%% disp(out5)
%        
for i=1:NC
    j=NC+1-i;
    if j>0
        if( i_seg(j)>0 )
%           str = int2str(i_seg(j));
            tseg=dt*ss(j);
            ddf=1./tseg;
%%            out4 = sprintf(' %8d  %8d    %11.5f    %9.4f   %d',i_seg(j),ss(j),tseg,ddf,2*i_seg(j));
%%            disp(out4)
            
            if(ddf<=5)
                NW=i_seg(j);
            end
            
        end
    end
    if(i==12)
        break;
    end
end
%
mmm = 2^fix(log(n/NW)/log(2));
%
df=1./(mmm*dt);
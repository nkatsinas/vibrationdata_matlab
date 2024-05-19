%
%   advise_syn.m  ver 1.0  by Tom Irvine
%
function[data,dt,sr,n,max_num_rows]=advise_syn(maxf,dur)
%
    n=1;

    while(1)
        n=n*2;
        nf=floor(log(n)/log(2));
        n=2^nf;
    
        dt=dur/(n-1);
        sr=1/dt;
        
        if(sr>=10*maxf)
            break
        end
    end    

  
    
    NC=0;
    for i=1:1000
%    
        nmp = 2^(i-1);
%   
        if(nmp <= n )
            ss(i) = 2^(i-1);
            seg(i) =n/ss(i);
            i_seg(i) = floor(seg(i));
            NC=NC+1;
        else
            break;
        end
    end

    disp(' ')
    out4 = sprintf(' Number of   Samples per   Time per        df               ');
    out5 = sprintf(' Segments     Segment      Segment(sec)   (Hz)     dof     ');
%
    disp(out4)
    disp(out5)
%
    k=1;
    for i=1:NC
        j=NC+1-i;
        if j>0
            if( i_seg(j)>0 )
%               str = int2str(i_seg(j));
                tseg=dt*ss(j);
                ddf=1./tseg;
                out4 = sprintf(' %8d  %8d    %11.5f    %9.4f   %d',i_seg(j),ss(j),tseg,ddf,2*i_seg(j));
                disp(out4)
                data(k,:)=[i_seg(j),ss(j),tseg,ddf,2*i_seg(j)];
                k=k+1;
            end
        end
        if(i==12)
            break;
        end
    end
%

    max_num_rows=k-1;
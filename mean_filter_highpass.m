%
%   mean_filter_highpass.m  ver 1.0  by Tom Irvine
%
%   One pass
%
function[yy]=mean_filter_highpass(y,sr,fc)

    n=length(y);
    a=y;
    
    a=a-mean(a);

    maxw=round(double(n)/2);    
    
    q=0.728*(sr/fc);
            
    w= 2*floor(q/2)+1;
    
    if(w>maxw)
        w= 2*floor(q/2)-1; 
    end
    if(w<3)
        w=3;
    end            

    k=fix(double(w-1)/2.);

    last=n;

    for i=1:last

        ave=0.;
        n=0;

        for j=(i-k):(i+k)

            if(j>=1 && j<=last )

                ave=ave+a(j);
                n=n+1;
            end 
        end
        if(n>1)
            a(i)=ave/double(n);
        end
    end

    yy=y-a;
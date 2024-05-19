%
%   zero_crossing_function_alt.m  ver 1.1 by Tom Irvine
%
function[pszcr,peak_rate,tpa,pa]=zero_crossing_function_alt(t,amp,T)

    np=0;
    pp=0;
    pszcr=0;
    j=1;
    n=length(amp);
%
%  do not initialize pa with zeros because do not know final size
%
    for i=2:(n-1)
        if( amp(i)>=amp(i-1) && amp(i)>=amp(i+1) )
            pa(j)=abs(amp(i));
            tpa(j)=t(i);
            j=j+1;
            pp=pp+1;
        end
        if( amp(i)<=amp(i-1) && amp(i)<=amp(i+1) )
            pa(j)=abs(amp(i));
            tpa(j)=t(i);            
            j=j+1;
            np=np+1;
        end
        
        if(amp(i-1)<0 && amp(i)>0)
            pszcr=pszcr+1;
        end    
        
    end
%

pszcr=pszcr/T;
peak_rate=((pp+np)/2)/T;

tpa=fix_size(tpa);
pa=fix_size(pa);

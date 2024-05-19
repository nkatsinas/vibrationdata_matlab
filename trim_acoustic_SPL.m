%
%  trim_acoustic_SPL.m  ver 1.2  by Tom Irvine
%
function[pf,pspl,oaspl]=trim_acoustic_SPL(fc,splevel,ref)
%
k=1;
%
imax=length(splevel);
%
    for i=1:imax
        if(splevel(i)>0.0001 && fc(i)>=1)
            pf(k)=fc(i);
            pspl(k)=splevel(i);
%
            k=k+1;
        end
    end
%
[oaspl]=oaspl_function(pspl);
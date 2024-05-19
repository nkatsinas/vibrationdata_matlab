

% max_min_between_limits.m  ver 1.0  by Tom Irvine

function[min_amp,max_amp]=max_min_between_limits(fa,a,fmin,fmax)

min_amp=1.0+90;
max_amp=-min_amp;

for i=1:length(fa)
    if(fa(i)>=fmin && fa(i)<=fmax)
        if(a(i)>max_amp)
            max_amp=a(i);
        end
        if(a(i)<min_amp)
            min_amp=a(i);
        end        
    end
end
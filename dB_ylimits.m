
%   dB_ylimits.m  ver 1.0  by Tom Irvine

function[ymin,ymax]=dB_ylimits(dB)

ymin=0.99*min(dB);
ymax=1.02*max(dB);

for i=-100:5:250
    if(ymax<i)
        ymax=i;
        break;
    end
end
for i=-100:5:200
    if(ymin<i)
        ymin=i-5;
        break;
    end
end


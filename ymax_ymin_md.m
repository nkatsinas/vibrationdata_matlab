%
%   ymax_ymin_md.m  ver 1.3   by Tom Irvine
%
function[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md)
%
try
    sz=size(max_amp);
catch
    warndlg(' max_amp error ');
    return;
end
    
if(sz(1)~=1 || sz(2)~=1)
   
    ymax=0;
    ymin=0;
    warndlg(' max_amp size error ');
    return;
    
end

ymax= 10^ceil(log10(max_amp*1.3));
%
if(min_amp<1.0e-20)
    min_amp=1.0e-20;
end
ymin= 10^floor(log10(min_amp*0.999));


if(ymin<ymax/10^md)
    ymin=ymax/10^md;
end

%
if(ymin==ymax)
    ymin=ymin/10;
    ymax=ymax*10;
end   
%
if(ymin>(ymax/10))
    ymin=ymin/10;
end    
%



%
%  find_log_plot_limits.m  ver 1.0  February 7, 2013
%
function[y1,y2,RMS]=find_log_plot_limits(fmin,fmax,A)
%
n=length(A);
%
maxA=0.;
minA=1e+90;
y1=0;
y2=0;
%
ms=0;
%
for i=1:n
%
    if(A(i,1)>=fmin && A(i,1)<=fmax)
%
        ms=ms+((A(i,2))^2)/2;  
%
        if(A(i,2)>maxA)
            maxA=A(i,2);
            y2=maxA;
        end    
%
        if(A(i,2)<minA)
            minA=A(i,2);
            y1=minA;
        end   
%
    end
%
end
%
RMS=sqrt(ms);
%
y1=10^(floor(log10(y1)));
y2=10^(ceil(log10(y2)));
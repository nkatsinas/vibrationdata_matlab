%
%   Hanning_function.m  ver 1.1  by Tom Irvine
%
function[y]=Hanning_function(y)
%

y=fix_size(y);

n=length(y);
        
ae=sqrt(8/3);
hw=zeros(n,1); 
        
for i=0:(n-1)  
    hw(i+1) =sin( (i*pi/n) )^2 ;
end

y=(y.*hw)*ae;
        

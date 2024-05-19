%
%   exponential_window_function.m  ver 1.1  by Tom Irvine
%
function[y]=exponential_window_function(y,dur,sigma)
%

y=fix_size(y);

n=length(y);
mu=mean(y);
%

dt=dur/n;

y=y-mu;
        
ew=zeros(n,1); 
        
for i=0:(n-1)  
    t=dt*i;
    ew(i+1) = exp(-sigma*t);
end

y=(y.*ew);
   
sigma
dt
dur
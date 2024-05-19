


f1=90
f2=95

% N = number of octaves 

N=log(f2/f1)/log(2)

% R = log sweep rate (octaves/sec)

R = 1/60

% assume start time is zero at f1
% tend = end time (sec)

t2=N/R

% C = number of accumulated cycles between f1 and f2

C = f1*(-1+2^(R*t2))/(R*log(2))




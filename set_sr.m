

% set_sr.m  ver 1.0  by Tom Irvine

function[sr,dt]=set_sr(dt)

sr=1/dt;
%
srr(1)=5000000;
srr(2)=2000000;
srr(3)=1000000;
srr(4)= 500000;
srr(5)= 200000;
srr(6)= 100000;
srr(7)=  50000;
srr(8)=  20000;
srr(9)=  10000;
srr(10)=   5000;
srr(11)=   2000;
srr(12)=  1000;
srr(13)=   5000;
srr(14)=   2000;
srr(15)=   1000;
srr(16)=    500;
srr(17)=    200;
srr(18)=    100;
srr(19)=     50;
srr(20)=     20;
srr(21)=     10;
srr(22)=      5;
srr(23)=      2;
srr(24)=      1;
%
N=length(srr);

for i=2:N
   if(sr>srr(i-1))
       sr=srr(i);
       break;
   end
end

dt=1/sr;
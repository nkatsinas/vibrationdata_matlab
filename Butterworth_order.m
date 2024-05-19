%
%  Butterworth_order.m  ver 1.0  by Tom Irvine
%

function[sc]=Butterworth_order(L_order)

L=L_order;
LL=2*L;

sr=zeros(LL,1);
si=zeros(LL,1);
%
disp(' ');
for k=1:LL  
    arg  = (2*k+L-1)*pi/LL;
    sr(k)= cos(arg);
    si(k)= sin(arg);
end
disp(' ');
sc=complex(sr,si)';
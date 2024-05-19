%
%  LDLT_alt.m  ver 1.1 by Tom Irvine
%
function [num,nz,jflag] = LDLT_alt(A)
%
jflag=0;
num=0;
nz=0;
nnn=size(A);
n=nnn(1,1);
%
[~,D] = ldl(A);
%
for i=1:n
        if(D(i,i)<0)
            num=num+1;
        end
        if(D(i,i)==0)
            nz=nz+1;
        end    
end
%
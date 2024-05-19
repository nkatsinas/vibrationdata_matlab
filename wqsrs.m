%
%   wqsrs.m  ver 1.0  by Tom Irvine
%
function[xabs,xmax,xmin]=wqsrs(a1,a2,b1,b2,last_srs,iflag,accel,fn,dt)    
%
    jnum=last_srs; 
%
    nt=max(size(accel));
%
    xmax=zeros(jnum,1);
    xmin=zeros(jnum,1);
%
    for j=1:jnum
%        
        T=1/fn(j);
        ntt=round(nt+0.8*round(T/dt));
        yy=zeros(ntt,1);        % add trailing zeros
        yy(1:nt)=accel(1:nt);
%
%
        forward=[ b1(j),  b2(j),  0. ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,yy);
%
        xmax(j)= max(resp);
        xmin(j)= min(resp);
    end
%
%
    xabs=xmax;
	for i=1:jnum
		if(xmax(i)<abs(xmin(i)))
			xabs(i)=abs(xmin(i));
        end
    end
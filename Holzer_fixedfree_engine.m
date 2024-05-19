%
%   Holzer_fixedfree_engine.m  ver 1.0  by Tom Irvine
%
function[T,x]=Holzer_fixedfree_engine(i_disks,j,k,omega)
%

num=i_disks+1;

x=zeros(num,1);

x(1) = 1.;

for i=2:num
		
    sum=0.;
    
	for nk=1:(i-1)
		sum=sum+j(nk)*x(nk);
	end

	x(i) = x(i-1) - ((omega^2)/k(i-1))*sum;
end

T=x(num);  % T represents angular displacement rather than torque


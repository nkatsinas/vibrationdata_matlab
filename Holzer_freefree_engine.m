%
%   Holzer_freefree_engine.m  ver 1.0  by Tom Irvine
%
function[T,x]=Holzer_freefree_engine(i_disks,j,k,omega)

x=zeros(i_disks,1);

x(1) = 1.;

for i=2:i_disks
		
    sum=0.;
    
	for nk=1:(i_disks-1)
		sum=sum+j(nk)*x(nk);
	end

	x(i) = x(i-1) - ((omega^2)/k(i-1))*sum;
end

T=0.;

for i=1:length(x)
		
    T=T+j(i)*(omega^2)*x(i);

end
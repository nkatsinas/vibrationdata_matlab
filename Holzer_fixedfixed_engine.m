%
%   Holzer_fixedfixed_engine.m  ver 1.0  by Tom Irvine
%
function[T,x]=Holzer_fixedfixed_engine(i_disks,j,k,omega)
%

num=i_disks+1;

x=zeros(num,1);

x(1) = 1.;

for i=1:i_disks
		
    sum=0.;
    
	for nk=1:i
		sum=sum+j(nk)*x(nk);
	end

    x(i+1) = x(i) + (1./k(i+1)) * ( k(1)*x(1) - (omega^2.)*sum );

end

T=x(num);  % T represents angular displacement rather than torque


 

	   

%
%  vibrationdata_local_stiffness_rotating.m  ver 1.0  August 3, 2015
%
function[klocal]=...
              vibrationdata_local_stiffness_rotating(E,I,ne,dx,omega,L,rho)
%
jflag=0;
%
h=L/ne;   % assume constant length elements
%
for k=1:ne
%
    klocal(k,1,1)=12.;
    klocal(k,1,2)=6.;
    klocal(k,1,3)=-12.;
    klocal(k,1,4)=6.;
    klocal(k,2,2)=4.;
    klocal(k,2,3)=-6.;
    klocal(k,2,4)=2.;
    klocal(k,3,3)=12.;
    klocal(k,3,4)=-6.;
	klocal(k,4,4)=4.;
%
	klocal(k,1,1)=klocal(k,1,1)*1.;
	klocal(k,1,2)=klocal(k,1,2)*dx(k);
	klocal(k,1,3)=klocal(k,1,3)*1.;
	klocal(k,1,4)=klocal(k,1,4)*dx(k);
	klocal(k,2,2)=klocal(k,2,2)*dx(k)^2;
	klocal(k,2,3)=klocal(k,2,3)*dx(k);
	klocal(k,2,4)=klocal(k,2,4)*dx(k)^2;
	klocal(k,3,3)=klocal(k,3,3)*1.;
	klocal(k,3,4)=klocal(k,3,4)*dx(k);
	klocal(k,4,4)=klocal(k,4,4)*dx(k)^2;
%
% symmetry
%
	for i=1:4
		for j=i:4
            if( dx(k) < 1.0e-10 )
                disp(' dx error ');
                jflag=1;
                break;
            end
			klocal(k,i,j)=klocal(k,i,j)*E*I/dx(k)^3;            
        end
        if(jflag==1)
            break;
        end
    end
    if(jflag==1)
        break;
    end   
%
    j=k;
%
    kr(1,1)= (42*L^2-42*h^2*j^2+42*h^2*j-12*h^2)/(35*L^2);
    kr(1,2)= (7*L^2-7*h^2*j^2+2*h^2)/(70*L^2);
    kr(1,3)=-(42*L^2-42*h^2*j^2+42*h^2*j-12*h^2)/(35*L^2);
    kr(1,4)= (7*L^2-7*h^2*j^2+14*h^2*j-5*h^2)/(70*L^2);
%
    kr(2,2)= (14*L^2-14*h^2*j^2+21*h^2*j-9*h^2)/(105*L^2);
    kr(2,3)=-kr(1,2);
    kr(2,4)=-(7*L^2-7*h^2*j^2+7*h^2*j-3*h^2)/(210*L^2);
%
    kr(3,3)= kr(1,1);
    kr(3,4)=-kr(1,4);
%
    kr(4,4)= (14*L^2-14*h^2*j^2+7*h^2*j-2*h^2)/(105*L^2);
%
%%%
%
    kr=(0.5*(rho/h)*omega^2*L^2)*kr;
%
	for i=1:4
		for j=1:4
            klocal(k,i,j)=klocal(k,i,j)+kr(i,j);
        end
    end
%
	for i=1:4
		for j=i:4
			klocal(k,j,i)=klocal(k,i,j);
        end
    end    
 %
end
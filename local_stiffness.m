function [klocal] = local_stiffness(E,I,ne,dx)
%

jflag=0;
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
			klocal(k,j,i)=klocal(k,i,j);
        end
        if(jflag==1)
            break;
        end
    end
    if(jflag==1)
        break;
    end   
%
end

%  beam_column_local_stiffness.m  ver 1.0  by Tom Irvine


function [klocal] = beam_column_local_stiffness(E,I,area,ne,dx)
%

jflag=0;
%
for k=1:ne
    
    klocal(k,:,:)=0;

%
    klocal(k,1,1)=1.;
    klocal(k,1,4)=-1.;    
        
%
    klocal(k,2,2)=12.;
    klocal(k,2,3)=6.;
    klocal(k,2,5)=-12.;
    klocal(k,2,6)=6.;
%    
    klocal(k,3,3)=4.;
    klocal(k,3,5)=-6.;
    klocal(k,3,6)=2.;
%    
    klocal(k,4,4)=1;
%
    klocal(k,5,5)=12.;
    klocal(k,5,6)=-6.;
%    
	klocal(k,6,6)=4.;
%


	klocal(k,1,1)=klocal(k,1,1)*area*dx(k)^2;  
	klocal(k,1,4)=klocal(k,1,4)*area*dx(k)^2;      

	klocal(k,2,2)=klocal(k,2,2)*I;
	klocal(k,2,3)=klocal(k,2,3)*I*dx(k);
	klocal(k,2,5)=klocal(k,2,5)*I;
	klocal(k,2,6)=klocal(k,2,6)*I*dx(k);
    
	klocal(k,3,3)=klocal(k,3,3)*I*dx(k)^2;
	klocal(k,3,5)=klocal(k,3,5)*I*dx(k);
	klocal(k,3,6)=klocal(k,3,6)*I*dx(k)^2;
	
    klocal(k,4,4)=klocal(k,4,4)*area*dx(k)^2;    
    
    klocal(k,5,5)=klocal(k,5,5)*I;
	klocal(k,5,6)=klocal(k,5,6)*I*dx(k);
	
    klocal(k,6,6)=klocal(k,6,6)*I*dx(k)^2;
%
% symmetry
%
	for i=1:6
		for j=i:6
            if( dx(k) < 1.0e-10 )
                disp(' dx error ');
                jflag=1;
                break;
            end
			klocal(k,i,j)=klocal(k,i,j)*E/dx(k)^3;            
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
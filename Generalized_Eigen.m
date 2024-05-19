
%  Generalized_Eigen.m  ver 2.4   November 15, 2019
%  by Tom Irvine

function[fn,omega,ModeShapes,MST]=Generalized_Eigen(S2,M2,ijk)
%
[ModeShapes,Eigenvalues]=eig(S2,M2);
%
szz=max(size(Eigenvalues));
dof=szz(1);

EEE=zeros(dof,dof+1);
omega=zeros(dof,1);


for i=1:dof
    EEE(i,1)=Eigenvalues(i,i);
end
    
EEE(:,2:szz+1)=transpose(ModeShapes);
EEE=sortrows(EEE,1);
ModeShapes=transpose(EEE(:,2:szz+1));
%

for i=1:dof
    omega(i) = sqrt(EEE(i,1));
end

fn=omega/(2*pi); 

%
if(ijk==1 || ijk==3)
	disp(' Natural Frequencies ');
    disp(' No.      f(Hz)');

    
    
    for i=1:dof
        if(ijk==1 || ijk==3)
            
            if(imag(fn)==0)
                out1=sprintf('%d.  %10.5g ',i,fn(i));
            else
                out1=sprintf('%d.  %10.5g +%10.5gi ',i,real(fn(i)),imag(fn(i)));                
            end
            
            disp(out1);
        end
    end    

end
%
%
MST=transpose(ModeShapes);
temp=M2*ModeShapes;
QTMQ=MST*temp;
%   

scale=zeros(dof,1);

for i=1:dof 
    scale(i)=1./sqrt(QTMQ(i,i));
    if(sum(ModeShapes(:,i))<0)
        scale=-scale;
    end
    ModeShapes(:,i) = ModeShapes(:,i)*scale(i);    
end
%
MST=transpose(ModeShapes);
%
if(ijk==1)
   disp(' ');
   disp('  Modes Shapes (column format)');
   ModeShapes
end
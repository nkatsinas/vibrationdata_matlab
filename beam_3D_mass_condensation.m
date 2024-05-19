function[fn,omega,ModeShapes,MST]=beam_3D_mass_condensation(stiff,mass,nr) 
n=max(size(stiff));
m=mass;
%
clear ngw;
ngw=1:n;
%
% Diagonal Pivot
%
for i=1:n-1
    maxA=abs(mass(i,i)/stiff(i,i));
%
    for k=i+1:n
        if( abs(mass(k,k)/stiff(k,k))>maxA)
            maxA=abs(mass(k,k)/stiff(k,k));
%
            temp=ngw(i);
            ngw(i)=ngw(k);
            ngw(k)=temp;
%
% Row switch
            for j=1:n
                temp=mass(i,j);
                mass(i,j)=mass(k,j);
                mass(k,j)=temp;
%
                temp=stiff(i,j);
                stiff(i,j)=stiff(k,j);
                stiff(k,j)=temp;
            end
% Column switch
            for j=1:n
                temp=mass(j,i);
                mass(j,i)=mass(j,k);
                mass(j,k)=temp;
%
                temp=stiff(j,i);
                stiff(j,i)=stiff(j,k);
                stiff(j,k)=temp;
            end
        end
   end
end
%
%% disp(' Matrices with rows and columns switched');
mass;
stiff;
%
if(nr>n)
    nr=n;
end
d2=nr;
nmds=n-d2;
%
for i=1:d2
    for j=1:d2
        M11(i,j)=mass(i,j);
        K11(i,j)=stiff(i,j);
    end
end
%
for i=1:nmds
    for j=1:d2
        M21(i,j)=mass(i+d2,j);
        K21(i,j)=stiff(i+d2,j);
    end
end
%
for i=1:nmds
    for j=1:nmds
        M22(i,j)=mass(d2+i,d2+j);
        K22(i,j)=stiff(d2+i,d2+j);
    end
end
%
for i=1:n
    for j=1:nmds
        M12(i,j)=mass(i,j+d2);
        K12(i,j)=stiff(i,j+d2);
    end
end
size(K22);
size(K21);
%
clear invK22;
clear QQQ;
disp(' ');
disp(' Select submatrix inverse method ');
disp(' 1=inv   2=pinv  3=backslash ');
im=input(' ');
if(im==1)
    invK22=inv(K22);
end
if(im==2)
    invK22=pinv(K22);
end
if(im==3)
    QQQ=eye(nmds,nmds);
    invK22=K22\QQQ;
end
%
CC=-invK22*K21;
for i=1:d2
    for j=1:d2
         C(i,j)=0.;
    end
    C(i,i)=1.;
end
for i=1:nmds
    for j=1:d2
         C(i+d2,j)=CC(i,j);
     end
end
%
M11;
M12;
M21;
M22;
%
K11;
K12;
K21;
K22;
%
%% disp(' ');
%% disp(' inverse of K22 ');
inv(K22);
%
C;
%
%% disp(' ');
%% disp(' Reduced Matrices ');
%
size(C);
size(stiff);
S2=C'*stiff*C;
M2=C'*mass*C;
dof=d2;
%
%  Calculate eigenvalues and eigenvectors
%
[fn,omega,ModeShapes,MST]=Generalized_Eigen(S2,M2,3);
%
%% disp(' ');
%% disp(' node switch vector ');
ngw';
%
clear MS_switched
MS_switched=C*ModeShapes;
%
clear MS_ordered;
num=n;
MS_ordered=zeros(num,dof);
%
for(i=1:num)
    for(j=1:dof)
        MS_ordered(ngw(i),j)=MS_switched(i,j);
    end    
end
%% disp(' ');
%% disp(' Modeshapes with original dof order ');
MS_ordered;
%
%% disp(' Mass Normalized Modeshapes with original dof order ');
%
clear MSTT;
clear temp;
clear QTMQ;
clear MN_MS_ordered;
%
MSTT=MS_ordered';
temp=zeros(dof,dof);
temp=m*MS_ordered;
QTMQ=MSTT*temp;
%   
clear scale;
for(i=1:dof)
    scale(i)=1./sqrt(QTMQ(i,i));
    MN_MS_ordered(:,i) = MS_ordered(:,i)*scale(i);    
end
%
ModeShapes=MN_MS_ordered;
MST=ModeShapes';
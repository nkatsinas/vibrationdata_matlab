%
%   calibrate_flow_coefficients.m  ver 1.0  by Tom Irvine
%
function[a1,a2]=calibrate_flow_coefficients(Uc,md,Ap,thick,fcross)

tpi=2*pi;

a1=1;
a2=1;

num=1;

% ratio=Uc/cp;

% find the frequency at which Uc=cp

ratio=1;


den1=(pi^2)*fcross*md*thick;
P1=ratio*(num/den1);

den2=2*pi*fcross*md*thick;    
Ls=sqrt(Ap);
    

nt=81;

nt2=nt^2;

clear cm
cm=zeros(nt2,3);

ijk=1;

for i=1:nt
    
    a1=1+0.05*(i-1);
    
    for j=1:nt
        
        a2=1+0.05*(j-1);        
        
        Y1=(a1/6);
        Y2=a2*( Uc/(tpi*fcross*Ls) )^2;
        Y=Y1+Y2;
        P2=ratio^3*(num/den2)*Y;    
    
        error=abs(P2-P1);
    
        cm(ijk,1)=a1;
        cm(ijk,2)=a2;
        cm(ijk,3)=error; 
    
        ijk=ijk+1;
    
    end
end

% find index of minimum error

[~,I] = min(cm(:,3));
a1=cm(I,1);
a2=cm(I,2);



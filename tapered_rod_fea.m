L=24;
diameter1=2;
diameter2=1;
A0=pi*(diameter1)^2/4;
AL=pi*(diameter2)^2/4;
alpha=(AL/A0)-1;
E=10e+06;
rho=0.1/386;


NE=100;
num=NE+1;

h=L/NE;

stiff=zeros(num,num);
mass=zeros(num,num);

KK=(alpha*h)/(2*L);
MM=(alpha*h/L);

for j=1:NE
   
    sL=(1+KK*(2*j-1))*[1 -1; -1  1 ];

    m1=[4 2; 2 4];
    m2=[4*j-1 2*j-1; 2*j-1 4*j-3];
    mL=m1+MM*m2;
    ir1=j;
    ir2=ir1+1;
    ic1=ir1;
    ic2=ir2;

    stiff(ir1,ic1)=stiff(ir1,ic1)+sL(1,1);
    stiff(ir1,ic2)=stiff(ir1,ic2)+sL(1,2);    
    stiff(ir2,ic1)=stiff(ir1,ic2);
    stiff(ir2,ic2)=stiff(ir2,ic2)+sL(2,2); 

    mass(ir1,ic1)=mass(ir1,ic1)+mL(1,1);
    mass(ir1,ic2)=mass(ir1,ic2)+mL(1,2);    
    mass(ir2,ic1)=mass(ir1,ic2);
    mass(ir2,ic2)=mass(ir2,ic2)+mL(2,2);     

end

stiff=stiff*(E*A0/h);
mass=mass*(rho*A0*h/12);


stiff(1,:)=[];
stiff(:,1)=[];

mass(1,:)=[];
mass(:,1)=[];

ijk=3;

[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,ijk);

MM=[0; ModeShapes(:,1)];

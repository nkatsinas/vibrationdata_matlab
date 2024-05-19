disp('  ');
disp(' * * * * * * * ');
disp('  ');

iu=2;

mass=eye(3,3);

stiffness=[1 -1 0; -1 2 -1 ; 0 -1 1];

[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);

rbm=ModeShapes(:,1)

    
cn=1;


force=[1 0 0];

force

%

ndof=3;
sys_dof=ndof;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
    id=eye(3,3);
    


%%%%    
    
    nn=2;
    cdof=cn
    
    num_cdof=length(cdof);
    
    kee=stiffness;
    
    
    for i=1:num_cdof
        
        j=cdof(i);
        
        kee(j,:)=0;
        kee(:,j)=0;
        
    end
    
    disp(' kee');
    
        kee
    
    force=fix_size(force);
    

    disp(' ');
    disp(' Inertia Relief Matrix');

    R=id-mass*rbm*rbm'


    
    Gc=pinv(kee);
    
    
    disp(' ');
    disp(' Constrained Flexibility Matrix ');    
        
    Gc
    
    disp(' System Flexibility for Elastic Modes ');

    Ge=R'*Gc*R
    
    x=Ge*force

    rd=x(2)-x(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
if(iu==1)
    out1=sprintf(' Relative Displacement = %8.4g in \n',rd);
else
    out1=sprintf(' Relative Displacement = %8.4g mm \n',rd*1000);
end
    
disp(out1);

sf=rd*stiffness(1,1);

if(iu==1)
    out1=sprintf(' Spring Force = %8.4g lbf \n',sf);
else
    out1=sprintf(' Spring Force = %8.4g N \n',sf);
end

disp(out1);

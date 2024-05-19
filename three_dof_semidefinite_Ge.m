
%  three_dof_semidefinite_Ge.m  ver 1.0  by Tom Irvine

function[Ge]=three_dof_semidefinite_Ge(mass,stiffness,cdof)   

    nn=3;

    id=eye(nn,nn);

    
    [~,~,ModeShape,~]=Generalized_Eigen(stiffness,mass,2);
        
    rbm=ModeShape(:,1);
    
    disp('  ');
    disp(' Rigid-body Mass-Normalized Eigenvector ');
    
    rbm

    
    num_cdof=length(cdof);
    
    kee=stiffness;
    
    for i=1:num_cdof
        
        j=cdof(i);
        
        kee(j,:)=0;
        kee(:,j)=0;
        
    end
    
    disp(' ');
    disp(' Inertia Relief Matrix');
    
    R=id-mass*rbm*rbm'
    
    Gc=pinv(kee);
    
    
    disp(' ');
    disp(' Constrained Flexibility Matrix ');    
        
    Gc
    
    disp(' System Flexibility for Elastic Modes ');

    Ge=R'*Gc*R
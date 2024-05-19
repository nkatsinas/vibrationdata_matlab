%
%   pipe_bending.m  ver 1.0  by Tom Irvine
%
%   This script calculates the natural frequencies and mode shapes
%   for a pipe
%
%   LBC left boundary condition
%     1 fixed
%     2 pinned
%     3 free
%
%   RBC right boundary condition
%     1 fixed
%     2 pinned
%     3 free
%
%     E = elastic modulus (lb/in^2)
%   rho = mass density (lbm/in^3)
%     L = length (in)
%     D = diameter (in)
%     t = wall thickness (in)
%
%  Output variables
%
%           fn = natural frequencies
%       omegan = angular natural frequencies
%   ModeShapes = mass normalized eigenvectors
% ModeShape_dd = mass normalized eigenvectors, second derivative
%            C = mode shape parameter
%         part = participation factors
%         beta = mode shape factor
%          cna = distance from neutral axis to outer fiber
%          MOI = area moment of inertia (in^4) 
%         mass = mass (lbf sec^2/in)
%      EI_term = sqrt(E*MOI/rho);

function[fn,omegan,ModeShape,ModeShape_dd,C,part,beta,cna,L,MOI,mass,EI_term]=...
                                                   pipe_bending(LBC,RBC,E,rho,L,D,t)

    if((LBC==2 && RBC==3) || (LBC==3 && RBC==2)) % pinned-free
        warndlg('case unavailable');
        return;
    end    

    if((LBC==2 && RBC==3) || (LBC==3 && RBC==2)) % pinned-free
        warndlg('pinned-free case unavailable');
        return;
    end

    diameter=D;
    wall_thick=t;

    [area,MOI,cna]=pipe_geometry_wall(diameter,wall_thick);

 
    rho=rho/386;
    rho=rho*area;   % mass per unit length
    
    mass=rho*L;

%
    EI_term = sqrt(E*MOI/rho);
    
    [root]=beam_bending_roots(LBC,RBC);    
    n=length(root);
    
    fn=zeros(n,1);
    beta=zeros(n,1);
    
    for i=1:n
        beta(i)=root(i)/L;
        omegan=beta(i)^2*EI_term;
        fn(i)=omegan/(2*pi);
    end
                                 
    C=zeros(n,1);
    
    part=zeros(n,1);
    emm=zeros(n,1);
%   
    if(LBC==1 && RBC==1) % fixed-fixed
        for i=1:n
            bL=root(i);
            C(i)=(sinh(bL)+sin(bL))/(cosh(bL)-cos(bL));
            arg=root(i);
            p2=(sinh(arg)-sin(arg))-C(i)*(cosh(arg)+cos(arg));
            arg=0;
            p1=(sinh(arg)-sin(arg))-C(i)*(cosh(arg)+cos(arg));
            part(i)=(p2-p1)/beta(i);
        end
        ModeShape=@(arg,Co)((cosh(arg)-cos(arg))-Co*(sinh(arg)-sin(arg)));
        part=part*sqrt(mass/L^2);
    end
%
    if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-pinned

        for i=1:n
           C(i)=-(sinh(root(i))+sin(root(i)))/(cosh(root(i))+cos(root(i)));
           arg=root(i);
           p2=(cosh(arg)+cos(arg))-C(i)*(sinh(arg)-sin(arg));
           arg=0;
           p1=(cosh(arg)+cos(arg))-C(i)*(sinh(arg)-sin(arg));
           part(i)=(p2-p1)/beta(i);
        end      
        ModeShape=@(arg,Co)((sinh(arg)-sin(arg))+Co*(cosh(arg)-cos(arg)));
        part=part*sqrt(mass/L^2);       
    end
%   
    if((LBC==1 && RBC==3) || (LBC==3 && RBC==1)) % fixed-free

        for i=1:n
           C(i)=-(cos(root(i))+cosh(root(i)))/(sin(root(i))+sinh(root(i)));
           arg=root(i);
           p2=(sinh(arg)-sin(arg))+C(i)*(cosh(arg)+cos(arg));
           arg=0;
           p1=(sinh(arg)-sin(arg))+C(i)*(cosh(arg)+cos(arg));
           part(i)=(p2-p1)/beta(i);           
        end
        
        ModeShape=@(arg,Co)((cosh(arg)-cos(arg))+Co*(sinh(arg)-sin(arg)));
        part=part*sqrt(mass/L^2);
    end
%    
    if(LBC==2 && RBC==2) % pinned-pinned
        C=sqrt(2)*ones(n,1);
        ModeShape=@(arg,Co)(Co*sin(arg));
%      
        for i=1:n
           part(i)=(-1/(i*pi))*sqrt(2*mass)*(cos(i*pi)-1);
        end
%       
    end 
%    
    if(LBC==3 && RBC==3) % free-free
        for i=1:n
            bL=root(i);
            C(i)=(-cosh(bL)+cos(bL))/(sinh(bL)+sin(bL));
        end
        ModeShape=@(arg,Co)((sinh(arg)+sin(arg))+Co*(cosh(arg)+cos(arg)));
    end     
%%

    for i=1:n
        if(abs(part(i))<1.0e-09)
            part(i)=0;
        end
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% do not put in separate function

    if(LBC==1 && RBC==1) % fixed-fixed
        ModeShape=@(arg,Co,sq_mass)(((cosh(arg)-cos(arg))+Co*(sinh(arg)-sin(arg)))/sq_mass);
        ModeShape_dd=@(arg,Co,beta,sq_mass)...
        (((cosh(arg)+cos(arg))-Co*(sinh(arg)+sin(arg)))*(beta^2/sq_mass));      
    end
    if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-pinned  
        ModeShape=@(arg,Co,sq_mass)(((sinh(arg)-sin(arg))+Co*(cosh(arg)-cos(arg)))/sq_mass);
        ModeShape_dd=@(arg,Co,beta,sq_mass)...
        (((sinh(arg)+sin(arg))+Co*(cosh(arg)+cos(arg)))*(beta^2/sq_mass));         
    end
    if((LBC==1 && RBC==3) || (LBC==3 && RBC==1)) % fixed-free
        ModeShape=@(arg,Co,sq_mass)(((cosh(arg)-cos(arg))+Co*(sinh(arg)-sin(arg)))/sq_mass);
        ModeShape_dd=@(arg,Co,beta,sq_mass)...
        ((beta^2*((cosh(arg)+cos(arg))+Co*(sinh(arg)+sin(arg))))/sq_mass);
    end
    if(LBC==2 && RBC==2) % pinned-pinned
        ModeShape=@(arg,Co,sq_mass)((Co*sin(arg))/sq_mass);
        ModeShape_dd=@(arg,Co,beta,sq_mass)(beta^2*(-sqrt(2)*sin(arg))/sq_mass);        
    end  
    if(LBC==3 && RBC==3) % free-free
        ModeShape=@(arg,Co,sq_mass)(((sinh(arg)+sin(arg))+Co*(cosh(arg)+cos(arg)))/sq_mass);
    end  

end
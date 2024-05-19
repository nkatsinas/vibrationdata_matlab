
%  beam_bending_modes_shapes_C_part.m  ver 1.2  by Tom Irvine

function[ModeShape,C,part]=beam_bending_modes_shapes_C_part(LBC,RBC,root,mass,L)

n=length(root);

C=zeros(n,1);
    
part=zeros(n,1);


%%%%%%%%%  fixed-fixed

    if(LBC==1 && RBC==1)  
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
    
%%%%%%%%%  fixed-pinned    
    
   if((LBC==1 && RBC==2) || (LBC==2 && RBC==1))
 
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

%%%%%%%%%  fixed-free    

    if((LBC==1 && RBC==3) || (LBC==3 && RBC==1))
 
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

%%%%%%%%%  pinned-pinned

    if(LBC==2 && RBC==2) 
        C=sqrt(2)*ones(n,1);
        ModeShape=@(arg,Co)(Co*sin(arg));
%      
        for i=1:n
           part(i)=(-1/(i*pi))*sqrt(2*mass)*(cos(i*pi)-1);
        end
%       
    end 

%%%%%%%%%  free-free

    if(LBC==3 && RBC==3) 
        for i=1:n
            bL=root(i);
            C(i)=(-cosh(bL)+cos(bL))/(sinh(bL)+sin(bL));
        end
        ModeShape=@(arg,Co)((sinh(arg)+sin(arg))+Co*(cosh(arg)+cos(arg)));
    end     
%%
 
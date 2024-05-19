
%  beam_bending_modes_shapes.m  ver 1.4  by Tom Irvine

function[ModeShape,ModeShape_dd]=beam_bending_modes_shapes(LBC,RBC)

    
    out1=sprintf(' LBC=%d   RBC=%d',LBC,RBC);
    disp(out1);

    if(LBC==1 && RBC==1) % fixed-fixed
        ModeShape=@(arg,Co,sq_mass)(((cosh(arg)-cos(arg))-Co*(sinh(arg)-sin(arg)))/sq_mass);
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
        ModeShape_dd=@(arg,Co,beta,sq_mass)...
        (((sinh(arg)-sin(arg))-Co*(cosh(arg)-cos(arg)))*(beta^2/sq_mass));        
    end     
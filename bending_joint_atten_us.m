%
%  bending_joint_atten_us.m  ver 1.0  by Tom Irvine
%
function [rr]=bending_joint_atten_us(f,fc,slope)
%
    tpi=2*pi;

    omega=tpi*f;
         
    slope=-abs(slope);
    
    rr=1;
    
    if(f>fc)
       
        aa=(slope/20)/log10(2);
        rr=(f/fc)^aa;
        
    end

       
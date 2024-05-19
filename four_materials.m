%
%  four_materials.m  ver 1.0  by Tom Irvine
%
function[elastic_modulus,mass_density,poisson]=four_materials(iu,imat)
%
    if(iu==1)  % English
        if(imat==1) % aluminum
            elastic_modulus=1e+007;
            mass_density=0.1;  
        end  
        if(imat==2)  % steel
            elastic_modulus=3e+007;
            mass_density= 0.28;         
        end
        if(imat==3)  % copper
            elastic_modulus=1.6e+007;
            mass_density=  0.322;
        end
        if(imat==4)  % G10
            elastic_modulus=2.7e+006;
            mass_density=  0.065;
        end
    else                 % metric
        if(imat==1)  % aluminum
            elastic_modulus=70;
            mass_density=  2700;
        end
        if(imat==2)  % steel
            elastic_modulus=205;
            mass_density=  7700;        
        end
        if(imat==3)   % copper
            elastic_modulus=110;
            mass_density=  8900;
        end
        if(imat==4)  % G10
            elastic_modulus=18.6;
            mass_density=  1800;
        end
    end
    
    
%%%%%%%%%%%%%%    
    
    if(imat==1) % aluminum
        poisson=0.33;  
    end  
    if(imat==2)  % steel
        poisson= 0.30;         
    end
    if(imat==3)  % copper
        poisson=  0.33;
    end
    if(imat==4)  % G10
        poisson=  0.12;
    end    
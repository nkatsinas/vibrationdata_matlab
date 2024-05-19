%
%  materials.m  ver 1.0  March 1, 2012
%
function[E,rho,mu]=materials(iu)
%
disp(' ');
disp(' Select material '); 
disp(' 1=aluminum  2=steel  3=G10  4=other '); 
imat = input(' '); 
% 
mu=0.33;
if(imat==1)      % aluminum 
    if(iu==1)
        E=1.0e+07; 
        rho=0.1;
    else
        E=6.891e+010; 
        rho=2768;        
    end
end  
% 
if(imat==2)      % steel 
    if(iu==1)
        E=3.0e+07; 
        rho=0.285; 
    else
        E=2.067e+011;
        rho=7887;
    end
end
%
if(imat==3)   % G10
    if(iu==1)
       E=2.7e+006;  
       rho=0.065 ;
    else
       E=1.8606e+010; 
       rho=1799.;
    end
    mu=0.12;
end
% 
if(imat~=1 && imat ~=2 && imat ~=3) 
    disp(' ');
    if(iu==1)
        disp(' Enter elastic modulus (lbf/in^2)');
    else
        disp(' Enter elastic modulus (N/m^2)');        
    end
    E=input(' '); 
%
    disp(' '); 
    if(iu==1)
        disp(' Enter mass density (lbm/in^3)');
    else
        disp(' Enter mass density (kg/m^3)');      
    end
    rho=input(' '); 
%
    disp(' '); 
    disp(' Enter Poisson Ratio '); 
    mu=input(' ');     
end 
% 
if(iu==1)
    rho=rho/386.;
end
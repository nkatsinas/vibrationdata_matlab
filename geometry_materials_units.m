%
%   geometry_materials_units.m  ver 1.0  April 11, 2013
%
function[E,I,rho,c,L,A]=geometry_materials_units(iu)
%
icross=input(' Enter the cross-section: \n 1=rectangle  2=solid cylinder  3=other ');
disp(' ');
%
if(iu==1)
    if(icross==1)
			width=input(' Enter the width (inch) ');
			thick=input(' Enter the thickness (inch) ');
			A=width*thick;
			I=(1./12.)*width*(thick^3.);
    end
    if(icross==2)
			diam=input(' Enter the diameter (inch) ');
			A=(pi/4.)*(diam^2.);
			I=(pi/64.)*(diam^4.);
    end
    if(icross ~=1 && icross ~=2)
            disp(' ');
            I = input(' Enter the area moment of inertia (in^4) ');
            %
            disp(' ');
            A = input(' Enter the cross-section area (in^2) ');
    end
%
    L = input(' Enter the length (inch) ');
else
    if(icross==1)
			width=input(' Enter the width (mm) ');
			thick=input(' Enter the thickness (mm) ');
			A=width*thick;
			I=(1./12.)*width*(thick^3.);
    end
    if(icross==2)
			diam=input(' Enter the diameter (mm) ');
			A=(pi/4.)*(diam^2.);
			I=(pi/64.)*(diam^4.);
    end
    if(icross ~=1 && icross ~=2)
            disp(' ');
            I = input(' Enter the area moment of inertia (mm^4) ');
            %
            disp(' ');
            A = input(' Enter the cross-section area (mm^2) ');
    end
% 
    A=A/1000^2;
    I=I/1000^4;
%
    L = input(' Enter the length (m) ');    
end
%
%
[E,rho,mu]=materials(iu);
%
c=sqrt(E/rho);
%
%
%  multispan_fea_function.m  ver 1.0  by Tom Irvine
%
%  This script calculates the natural frequencies & mass-normalized 
%  mode shapes for a multispan beam via the finite element method
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables:
%
%   num_elem=number of elements
%          E=elastic modulus psi
%        rho=mass density (lbm/in^3)
%          L=length
%        nsm=nonstructural mass (lbm);
%       area=cross section area (in^2)
%          I=area moment of inertia (in^4)
%     
%     LBC,RBC=left & right boundary conditions:
%             1=free
%             2=pinned
%             3=fixed
%
%    int_pinned_loc=array with x-axis coordinates (inch) of interior
%                   pinned locations
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Reference equations by cross-section not included in the script
%
%    Rectangular
%       area=thick*width;
%       I=(1/12)*width*thick^3;
%
%    Pipe
%       area=pi*(diameter^2-ID^2)/4;
%       I=pi*(diameter^4-ID^4)/64;
%  
%    Solid Cylinder
%       area=pi*diameter^2/4;
%       I=pi*diameter^4/64; 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Output arrays:
%         
%                     fn=natural frequencies (Hz)
%             ModeShapes=mass-normalized eigenvectors in column format
%                     xx=nodal coordinates (in)
%                    dof=total degrees-of-freedom for constrained system
%             mass,stiff=constrained global mass & stiffness matrices
%     mass_unc,stiff_unc=unconstrained global mass & stiffness matrices
%
%            dof status = 1D constraint array.  
%                         Index is the dof number.
%                         Value=0 for fixed
%                               1 for free
%
%                         Row 1 is node 1 translation
%                         Row 2 is node 1 rotation
%                         Then repeat pattern for each pair
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    External functions called:
%
%        local stiffness = elemental stiffness
%        local mass = elemental mass
%
%   mspan_beam_assembly_unc = assemble global mass & stiffness matrices
%         Generalized_Eigen = generalized eigenvalue problem solver
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[fn,ModeShapes,xx,stiff,mass,stiff_unc,mass_unc,dof,dof_status]=...
   multispan_fea_function(num_elem,int_pinned_loc,E,rho,L,nsm,area,I,LBC,RBC)

                    
% convert lbm to lbf sec^2/in                    
                    
rho=rho/386;
nsm=nsm/386;

rho=rho*area+(nsm/L);   % mass per unit length

ne=num_elem;

% Establish node locations.  Start with constant element length.
% The vector will be adjusted later to accomodate interior point locations.

deltax=L/ne;
    
xx=zeros((ne+1),1);

for i=2:(ne+1)
    xx(i)=xx(i-1)+deltax; 
end 

%%%

numi=length(int_pinned_loc); % number of interior pinned locations

% int_index stores the node index of each interior pinned location

if(numi==0)   
    int_index=0;
else
    
    N=numi;   
    
    int_index=zeros(N,1);
    
    for i=1:numi
        
        if(int_pinned_loc(i)>=L)
            warndlg('Intermediate location >= length ');
            return;
        end
       
        [~,index] = min(abs(xx-int_pinned_loc(i)));
        
        xx(index)=int_pinned_loc(i);   % adjust node location vector
        
        int_index(i)=index;
        
    end
    
    int_index=sort(int_index);
        
end

dx=diff(xx);  % Element length array

% number of unconstrained dof.  Change later to number of constraied dof

dof=2*ne+2;  

% Calculate local mass and stiffness matrices

[klocal] = local_stiffness(E,I,ne,dx);
[mlocal] = local_mass(rho,ne,dx);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Form global mass & stiffness matrices

[stiff,mass,stiff_unc,mass_unc,dof,dof_status,~]=...
            mspan_beam_assembly_unc(ne,klocal,mlocal,LBC,RBC,dof,numi,int_index);           

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Solve the generalized eigenvalue problem

[fn,~,ModeShapes,~]=Generalized_Eigen(stiff,mass,2);
%
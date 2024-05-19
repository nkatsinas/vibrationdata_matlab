
%  multispan_beam_bends_FEA_function_main.m  ver 1.1  by Tom Irvine
%
%  Sample multispan beam with bends
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables:
%
%          E=elastic modulus psi
%         mu=Possion ratio
%        rho=mass density (lbm/in^3)
%        nsm=nonstructural mass (lbm);
%       area=cross section area (in^2)
%          I=area moment of inertia (in^4)
%     
%     LBC,RBC=left & right boundary conditions:
%             1=free
%             2=pinned
%             3=fixed
%
%%%%%%%%%%%%%
%
%    straight_sections - 2D array
%
%       number of rows = number of straight sections
%       five columns with x & y locations (inch)
%
%       col 1= x1 
%       col 2= y1 
%       col 3= x2
%       col 4= y2
%       col 5= number of elements per each straight section
%
%   Reference beam configurations per number of rows: 
%
%        1=Straight
%        2=Straight-Bend-Straight
%        3=Straight-Bend-Straight-Bend-Straight
%        4=Straight-Bend-Straight-Bend-Straight-Bend-Straight
%
%   nb_elem - 1D array with number of rows equal to number of bends
%        The number of rows must be equal to the number of straight
%        sections minus one
%        The values in thew rows are the number of elements in each bend   
%
%    base_psd=base input psd, two columns:  freq(Hz) & Accel(G^2/Hz)
%
%   num_modes_include = number of modes to include in response analysis
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

E=   2.94e+07;  % modulus of elasticity (psi)
mu= 0.29;       % Poisson ratio
rho= 0.297;     % mass density (lbm/in^3)
nsm= 0;         % nonstructual mass (lbm)
LBC=3;          % left boundary condition, fixed
RBC=2;          % right boundary condition, pinned

area= 0.04602;  % cross seciton area (in^2) 
I= 0.00127;     % area moment of intertia (in^4)
cna=0.25;       % distance from neutral axis to outer fiber

% straight_sections 
straight_sections=...
[  0  0  4 14 20;
   5 16 10 23 12;
  16 26 28 26 24;
  33 29 33 45 16];
  
% nb_elem - Number of elements per bend section
nb_elem=[6; 12; 12];

% intermediate_pinned x & y (inch)
intermediate_pinned=...
[ 4 14;
 15 26;
 26 26;
 33 34];

Q=20;   % amplification factor

% base input psd
base_psd=[  20      0.33443 
            150     2.524 
            800 	2.524 
            2000 	0.40384  ];
  
num_modes_include=24;  % number of modes to include in response analysis

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
% normal modes calculation

try
   [fn,ModeShapes,xx,Stiff,Mass,stiff_unc,mass_unc,cdof,nodex,nodey,nodez,node1,node2,LEN,theta]=...
      multispan_beam_bends_FEA_function(E,mu,rho,nsm,area,I,LBC,RBC,straight_sections,nb_elem,intermediate_pinned);
catch
    disp(' normal modes calculation failed');
    return;
end

% response calculation

try
   [max_rd_psd,max_pv_psd,max_accel_psd,max_stress_psd]=...
       mspan_bends_base_input_psd_function(E,rho,cna,LEN,theta,Q,xx,base_psd,num_modes_include,cdof,mass_unc,stiff_unc);
catch
   disp(' response calculation failed');
   return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dirlik damage

% scf=stress scale factor
scf=1.4;

% duration (sec)
duration= 10000; 

% sample Nasgro coefficients for stainless steel 15-5PH 1025
A=9.959;
B=2.665;
C=48.54;
P=0.507;

% stress ratio.  R=-1 for fully reversed stress with zero mean
R=-1; 

stress_psd=max_stress_psd;

[damage,damage_rate]=stress_psd_fatigue_nasgro(scf,duration,A,B,C,P,R,stress_psd);

fprintf('\n Dirlik damage = %7.3g \n',damage);
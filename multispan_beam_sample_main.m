
% multi_span_beam_sample_main.m  ver 1.1  by Tom Irvine

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
%    base_psd=base input psd, two columns:  freq(Hz) & Accel(G^2/Hz)
%
%    cross_section:  1=rectangular
%                    2=pipe
%                    3=solid cylinder
%                    4=other
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

E=   3e+07;  % modulus of elasticity (psi)
rho= 0.28;   % mass density (lbm/in^3)
L=   30;     % beam length (inch)
nsm= 0;      % nonstructual mass (lbm)
LBC=3;       % left boundary condition, fixed
RBC=2;       % right boundary condition, pinned
int_pinned_loc = [12];  % location (in) of interior pinned

area= 0.04602;  % cross seciton area (in^2) 
I= 0.00127;     % area moment of intertia (in^4)
cna=0.25;       % distance from neutral axis to outer fiber

cross_section=2;  % for pipe

Q=20;   % amplification factor

num_elem=100;   % number of elements

% base input psd
base_psd=[ 20 	  0.084 
       150 	   0.634 
       800 	   0.634 
      2000 	   0.101 ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
  
% normal modes calcuation

[fn,ModeShapes,xx,stiff,mass,stiff_unc,mass_unc,dof,dof_status]=...
   multispan_fea_function(num_elem,int_pinned_loc,E,rho,L,nsm,area,I,LBC,RBC);
    
nf=min([10 length(fn)]);

fprintf('\n Mode  Natural Frequency (Hz) \n');
for i=1:nf
    fprintf(' %d   %8.4g\n',i,fn(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% response to psd base input

[max_stress_psd,max_pv_psd,max_rd_psd,max_accel_psd,xstress,xaccel,xpv,xrd,...
		   max_accel_rms,max_pv_rms,max_rd_rms,max_stress_rms,pv_max_stress_estimate]=...
           mspan_base_psd_function(num_elem,Q,E,rho,cna,xx,base_psd,cross_section,...
           dof_status,stiff_unc,mass_unc);
       
fprintf('\n Maximum Acceleration = %8.4g GRMS at x=%8.4g inch\n\n',max_accel_rms,xaccel);
fprintf(' Maximum Stress = %8.4g psi RMS at x=%8.4g inch\n',max_stress_rms,xstress);
       
fprintf(' Maximum Stress estimate from Pseudo Velocity = %8.4g psi RMS  \n',pv_max_stress_estimate)       

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Dirlik damage

% scf=stress concentration factor to be applied if not already included
scf=3;

% duration (sec)
duration= 3600; 

% sample Nasgro coefficients for stainless steel 15-5PH 1025
A=19.69;
B=9.14;
C=18.16;
P=0.595;

% stress ratio.  R=-1 for fully reversed stress with zero mean
R=-1; 

stress_psd=max_stress_psd;

[damage,damage_rate]=stress_psd_fatigue_nasgro(scf,duration,A,B,C,P,R,stress_psd);

fprintf('\n Dirlik damage = %7.3g \n',damage);
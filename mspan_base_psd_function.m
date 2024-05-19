
%
%  mspan_base_psd_function.m  ver 1.1  by Tom Irvine
%
%  This script calculates the response of multispan beam FEA model
%  to a PSD base inputtrack
%
%   Input Variables
%
%    num_elem=number of elements
%           Q=uniform amplification factor
%           E=modulus of elasticity (psi)
%         rho=mass density (lbm/in^3_
%         cna=distance from neutral axis to outer fiber
%          xx=nodal coordinates (in)
%    base_psd=base input psd, two columns:  freq(Hz) & Accel(G^2/Hz)
%
%    cross_section:  1=rectangular
%                    2=pipe
%                    3=solid cylinder
%                    4=other
%
%    dof status = 1D constraint array.  
%                 Index is the dof number.
%                    Value=0 for fixed
%                          1 for free
%
%                  Row 1 is node 1 translation
%                  Row 2 is node 1 rotation
%                  Then repeat pattern for each pair
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output arrays, maxima for all locations
%
%     max_stress_psd - freq(Hz) & stress(psi^2/Hz)
%     max_pv_psd     - freq(Hz) & pseudo velocity((in/sec)^2/Hz)
%     max_rd_psd     - freq(Hz) & relative displacement(in^2/Hz)
%     max_accel_psd  - freq(Hz) & acceleration(G^2/Hz)
%
%     max_stress_rms - max overall stress (psi rms)
%     max_pv_rms     - max overall pseudo velocity (in/sec) RMS
%     max_rd_rms     - max overall relative displacement (inch RMS)
%     max_accel_rms  - max overall acceleration (GRMS)
% 
%     pv_max_stress_estimate = estimate max stress (psi rms) from 
%                              stress-velocity sanity check
%                              for rectangular, pipe or solid cylinder only
%
%     xstress = x location for max stress
%     xaccel =  x location for max accel
%     xpv =     x location for max pseudo velocity (same as xrd)
%     xrd =     x location for max relative displacement
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%
%   External functions:
%
%     interp_psd_oct
%     step_partition_function
%     fix_size
%     calculate_PSD_slopes
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%
%   Internal variables:
%
%      TT=transformation matrix from partitioning step
%      Mwd,Mww=partitioned mass matrices from Reference 1.
%
%      num_Tz=length of TZ_tracking array
%      TZ_tracking_array=reordered displacement vector Ur index referenced 
%                        to all translational dof
%
%      R_tracking_array with total length equal to number of total nodes
%           Index is node number.
%           Value is zero for constrained rotation 
%                    and Ur index for unconstrained rotation
%
%      constraint_matrix:
%                column 1:  node
%                column 2:  translation 0=free 1=fixed
%                column 3:  rotation:   0=free 1=fixed
%
%      omegan=angular natural frequencies
%      ModeShapes=mass-normalized mode shapes
%
%      ngw=array with displacement U row for: 
%          each driven translation dof in order
%          followed by each remaining dof in order omitting constrained 
%          rotational dof
%
%      nem=number of enforced acceleration dof
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Reference 1:
%  \\blueorigin\fs\Systems\Loads-Dynamics\Vibroacoustics\Tools\tutorials\FRF_enforced_motion.pdf
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[max_stress_psd,max_pv_psd,max_rd_psd,max_accel_psd,xstress,xaccel,xpv,xrd,...
		   max_accel_rms,max_pv_rms,max_rd_rms,max_stress_rms,pv_max_stress_estimate]=...
           mspan_base_psd_function(num_elem,Q,E,rho,cna,xx,base_psd,cross_section,...
           dof_status,stiff_unc,mass_unc)

% calculate modal damping coefficient from amplification factor

damp=1/(2*Q);

% set excitation frequencies at 1/48 octave spacing

num=length(base_psd(:,1));
 
fmin=base_psd(1,1);
fmax=base_psd(num,1);

f(1)=fmin;
oct=2^(1/48);

k=2;
while(1)
    f(k)=f(k-1)*oct;
    
    if(f(k)>fmax)
        f(k)=fmax;
        break;
    end
    
    k=k+1;
end

freq=f;

np=length(f);  % number of excitation frequencies

% interpolate base input psd

[base_psd]=interp_psd_oct(base_psd(:,1),base_psd(:,2),freq);

%%%%%

% partition mass & stiffness matrices for enforced excitation

[TT,~,~,Mwd,Mww,~,~,num_Tz,TZ_tracking_array,~,...
   constraint_matrix,omegan,ModeShapes,ngw,nem]=step_partition_function(dof_status,mass_unc,stiff_unc);

MST=ModeShapes';

sz=size(Mww);
nff=sz(1);   % nff = number of unconstrained or free dof

omn2=omegan.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
omega=2*pi*f;    % omega = excitation frequencies from interpolated base input psd
om2=omega.^2;

N=zeros(nff,1);  % modal coordinate displacements

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nff>12)   % limit response calculation to first 12 modes
    nff=12;
end    

%
y=ones(nem,1); % enforced acceleration vector set at unity magnitude

A=-MST*Mwd*y;  % excitation array
%
%       np = number of excitation frequencies 
%   num_Tz = number of translation dof, one per node
%
acc=zeros(np,num_Tz);    % acceleration
rd=zeros(np,num_Tz);     % relative displacement
stress=zeros(np,num_Tz); % stress

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% calculate response amplitude transmissibility magnitudes
% (frequency response functions)


for k=1:np  % for each excitation frequency
    
%   calculate modal displacement for dof included in response analysis	
    for i=1:nff  
        N(i)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp*omegan(i)*omega(k));
    end
    
    Ud=zeros(nem,1);  % Ud = displacement at driven node
    for i=1:nem  % convert acceleration input to driven displacement
        Ud(i)=1/(-om2(k));
    end
%
    Uw=ModeShapes*N;  % transform from modal to physical displacement 

    Udw=[Ud; Uw];   % total partitioned displacement vector prior to final transformation 
%
    U=TT*Udw;       % final transformed total displacement vector accounting for partitioning
    
    nu=length(U);
   
% Reorder dof in displacement vector to correct order
% Ur has all translational dof plus all unconstrained rotational dof 
%
    Ur=zeros(nu,1);

    for i=1:nu      
       Ur(ngw(i))=U(i);   
    end    
    
%  Need to account for all rotational displacements regardless of constraint
%  and assign zero rotation to constained rotational dof
	
    if(k==1)  
	
        num_nodes=num_elem+1;
    
        R_tracking_array=zeros(num_nodes,1);  % rotation tracking array
    
        num_Ur=length(Ur);
    
        rot_constraint_matrix=constraint_matrix;
    
        for i=length(constraint_matrix(:,1)):-1:1
            if(constraint_matrix(i,3)==0)
                rot_constraint_matrix(i,:)=[];
            end
        end
    
        bbb=(1:num_Ur);
    
        for i=1:num_Tz
            [Lia,Locb] =ismember(TZ_tracking_array,bbb);  % translational tracking array
            if(Lia==1)
                bbb(Locb)=[];
            end
        end
    
        ccc=rot_constraint_matrix(:,1);
        
        kv=1;
        for jj=1:num_nodes    
            if(ismember(jj,ccc))
            else    
                R_tracking_array(jj)=bbb(kv);  % rotational tracking array
                kv=kv+1;
            end
        end
    end
    
    for jk=1:num_Tz     % k=excitation frequency index, ij=node index
        node=jk;    
        ij=TZ_tracking_array(node);   % translation tracking array
        acc(k,jk)=om2(k)*abs(Ur(ij)); % acceleration 
         rd(k,jk)=abs(Ur(ij)-Ud(1));  % relative displacement     
    end
    
    for nk=1:num_nodes-1   % calculate stress on left end of each beam element
    
        left_node=nk;
        right_node=nk+1;
        
        LL=xx(right_node)-xx(left_node); % elemental length
        [B]=beam_stress_B(0,LL);         % interpolation function for given beam element
        
        TL=TZ_tracking_array(left_node);  % translation left
        TR=TZ_tracking_array(right_node); % translation right
        
        URL=0;
        URR=0;
        
        if(R_tracking_array(left_node)~=0)
            RL=R_tracking_array(left_node);
            URL=Ur(RL);   % rotation left
        end
        if(R_tracking_array(right_node)~=0)
            RR=R_tracking_array(right_node);
            URR=Ur(RR);   % rotation right         
        end
        
		% d=[right translation, right rotation, left translation, left rotation]
        d=transpose([Ur(TL) URL Ur(TR) URR]);   

        stress(k,nk)=abs(cna*E*B*d);   % stress magnitude
        
    end
    
% stress at right end of last element  

    stress(k,end)=stress(k,end-1);
    
end


% convert relative displacement transmissibility magnitude to inch
% convert stress transmissibility magnitude to psi

rd=rd*386;
stress=stress*386;

% calculate psd response from power transmissibility & base input psd

f=fix_size(f);

% power transmissibility functions
   acc_power=zeros(np,num_Tz);
    rd_power=zeros(np,num_Tz);
stress_power=zeros(np,num_Tz);
 
% response psd 
     acc_psd=zeros(np,num_Tz);
      rd_psd=zeros(np,num_Tz); 
  stress_psd=zeros(np,num_Tz);
 
% index i is excitation frequency, j=translational dof index  
for i=1:np
    for j=1:num_Tz
            acc_power(i,j)=acc(i,j)^2;
             rd_power(i,j)=rd(i,j)^2;
         stress_power(i,j)=stress(i,j)^2;
         
              acc_psd(i,j)=acc_power(i,j)*base_psd(i);
               rd_psd(i,j)= rd_power(i,j)*base_psd(i);
           stress_psd(i,j)=stress_power(i,j)*base_psd(i);        
    end
end    


% find maximum PSD for each of four amplitude metrics from overall levels

 accel_rms=zeros(num_Tz,1);
    rd_rms=zeros(num_Tz,1);
stress_rms=zeros(num_Tz,1);

for i=1:num_Tz
    [~,accel_rms(i)]=calculate_PSD_slopes(f,acc_psd(:,i));
    [~,rd_rms(i)]=calculate_PSD_slopes(f,rd_psd(:,i));
    [~,stress_rms(i)]=calculate_PSD_slopes(f,stress_psd(:,i));   
end

% find index of maxima 

[C,I]=max(accel_rms);
[Crd,Ird]=max(rd_rms);
[Cst,Ist]=max(stress_rms);

max_accel_psd=[ f acc_psd(:,I)];
max_rd_psd=[ f rd_psd(:,Ird)];
max_stress_psd=[ f stress_psd(:,Ist)];

max_accel_rms=C;
max_rd_rms=Crd;
max_stress_rms=Cst;

% calculate pseudo velocity from relative displacement

pv_psd=zeros(np,1);

for i=1:np
    pv_psd(i)=(2*pi*f(i))^2*rd_psd(i,Ird);
end
max_pv_psd= [ f max_stress_psd ];

[~,max_pv_rms]=calculate_PSD_slopes(f,pv_psd);

xstress = xx(Ist);
xaccel =  xx(I);
xpv =     xx(Ird);
xrd =     xx(Ird);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  maximum estimated stress from stress-velocity relationship (good sanity check)

pv_max_stress_estimate=0;

if(cross_section<=3)

    rho=rho/386;
    
    c=sqrt(E/rho);

    if(cross_section==1)  % rectangle
        scale=sqrt(3);
    end
    if(cross_section==2)  % pipe
        scale=sqrt(2);
    end
    if(cross_section==3)  % solid
        scale=2;
    end    
    
    pv_max_stress_estimate=scale*rho*c*max_pv_rms;

end

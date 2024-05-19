
%  mspan_bends_base_input_psd_function.m  ver 1.1  by Tom Irvine

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%           Q=uniform amplification factor
%           E=modulus of elasticity (psi)
%         rho=mass density (lbm/in^3)
%         cna=distance from neutral axis to outer fiber
%      
%    base_psd=base input psd, two columns:  freq(Hz) & Accel(G^2/Hz)
%
%   num_modes_include= number of modes to include in analysis
%                      Recommend >=12 since highest stress may occur
%                      at a higher mode number
%
%          xx= 2D array - X & Y coordinates (inch) with each
%              row representing a node number
%
%         LEN= 1D array with length (inch) for each element
%
%        cdof= 1D array containing constrained dof numbers
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output arrays, maximum psd for each node
%
%        max_rd_psd - freq(Hz) & relative displacement (in^2/Hz)
%        max_pv_psd - freq(Hz) & pseudo velocity ((in/sec)^2/Hz)
%     max_accel_psd - freq(Hz) & acceleration (G^2/Hz)
%    max_stress_psd - freq(Hz) & stress (psi^2/Hz)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External functions
%
%     interp_psd_oct
%     enforced_partition_matrices
%     fix_size
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[max_rd_psd,max_pv_psd,max_accel_psd,max_stress_psd]=...
                mspan_bends_base_input_psd_function(E,rho,cna,LEN,theta,...
                Q,xx,base_psd,num_modes_include,cdof,mass_unc,stiff_unc)

Lx=length(xx);

num_Tz=Lx;
num_nodes=Lx;
num_elem=Lx-1;

damp=1/(2*Q);

[TT,Mwd,Mww,part_omega,part_ModeShapes,ngw,nem]=...
                                   step_partition(cdof,mass_unc,stiff_unc);

omega=part_omega;
ModeShapes=part_ModeShapes;
MST=ModeShapes';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num=length(base_psd(:,1));
 
fmin=base_psd(1,1);
fmax=base_psd(num,1);
  
sz=size(Mww);
nff=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=omega;
omn2=omegan.^2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

np=length(f);

% 
omega=2*pi*f;
om2=omega.^2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[base_psd]=interp_psd_oct(base_psd(:,1),base_psd(:,2),freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nff> num_modes_include)
    nff=num_modes_include;
end    

%
y=ones(nem,1);

A=-MST*Mwd*y;
%
acc=zeros(np,num_Tz);
rd=zeros(np,num_Tz);
stress=zeros(np,num_Tz);

N=zeros(length(ModeShapes(:,1)),1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

for k=1:np  % for each excitation frequency
    
    for i=1:nff  % dof
        N(i)=A(i)/(omn2(i)-om2(k) + (1i)*2*damp*omegan(i)*omega(k));
    end
    
    Ud=zeros(nem,1); 
    for i=1:nem  % convert acceleration input to displacement
        Ud(i)=1/(-om2(k));
    end
%
    Uw=ModeShapes*N;   

    Udw=[Ud; Uw];  
%
    U=TT*Udw;   
   
    nu=length(U);
    
    Ur=zeros(6*num_nodes,1);
    
    for i=1:nu
       Ur(ngw(i))=U(i);   
    end    
    
    for jk=1:num_Tz
        iv=6*jk-3;    
        acc(k,jk)=om2(k)*abs(Ur(iv));
         rd(k,jk)=abs(Ur(iv)-Ud(1));        
    end

    for nk=1:num_elem
        
        LL=LEN(nk);
        [B]=beam_stress_B(0,LL);
        
%   transform displacement to local coordinate system

        ia=6*nk-5;
        d=Ur(ia:(ia+11))';        

        R=rotz(-theta(nk)*180/pi);

        T=zeros(12,12);
        T(1:3,1:3)=R;
        T(4:6,4:6)=R;
        T(7:9,7:9)=R;
        T(10:12,10:12)=R;     
        
        dt=T*transpose(d);  % use transpose because d is complex
        
        dzL=dt(3);
        ryL=dt(5);
        dzR=dt(9);
        ryR=dt(11);
            
        dyL=dt(2); 
        rzL=dt(6); 
        dyR=dt(8); 
        rzR=dt(12);

        sstt=transpose([dzL ryL dzR ryR ])+transpose([dyL rzL dyR rzR ]);
            
        stress(k,nk)=abs(cna*E*B*sstt);
    end

% stress at right end  
    stress(k,end)=stress(k,end-1);
    
end


rd=rd*386;
stress=stress*386;

f=fix_size(f);

   acc_power=zeros(np,num_Tz);
    rd_power=zeros(np,num_Tz);
stress_power=zeros(np,num_Tz);
 
     acc_psd=zeros(np,num_Tz);
      rd_psd=zeros(np,num_Tz); 
  stress_psd=zeros(np,num_Tz);
 
  
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

 accel_rms=zeros(num_Tz,1);
    rd_rms=zeros(num_Tz,1);
stress_rms=zeros(num_Tz,1);


disp(' ');
disp(' Overall Levels ');
disp(' Node   Accel   Rel Disp    Stress ');
disp('       (GRMS)   (in RMS)    (psi)');

for i=1:num_Tz
    [~,accel_rms(i)]=calculate_PSD_slopes(f,acc_psd(:,i));
    [~,rd_rms(i)]=calculate_PSD_slopes(f,rd_psd(:,i));
    [~,stress_rms(i)]=calculate_PSD_slopes(f,stress_psd(:,i));   
    fprintf(' %d \t %8.4g \t %8.4g \t %8.4g   \n',i,accel_rms(i),rd_rms(i),stress_rms(i));
end

[C,I]=max(accel_rms);
[Crd,Ird]=max(rd_rms);
[Cst,Ist]=max(stress_rms);

% fprintf('\n Ist=%d \n',Ist);

[~,input_rms]=calculate_PSD_slopes(f,base_psd);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Plot PSD resultss
%

fig_num=100;

md=5;
fmin=f(1);
fmax=f(end);

leg_a=sprintf('Input %5.3g GRMS',input_rms);
leg_b=sprintf('Response %5.3g GRMS',C);

ppp=[ f base_psd];
max_accel_psd=[f acc_psd(:,I)];

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';

t_string_a=sprintf(' Accel PSD  Max at Node %d   Location (%5.3g, %5.3g) in',I,xx(I,1),xx(I,2));

[fig_num,~]=plot_PSD_two_h2(fig_num,x_label,y_label,t_string_a,ppp,max_accel_psd,leg_a,leg_b);

%%

max_rd_psd=[f rd_psd(:,Ird)];

y_label='Rel Disp (inch^2/Hz)';
t_string=sprintf(' Rel Disp PSD  Max at Node %d   Location (%5.3g, %5.3g) in   \n Overall Level %7.3g inch RMS',Ird,xx(Ird,1),xx(Ird,2),Crd);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,max_rd_psd,fmin,fmax,md);

%%

pv_psd=zeros(np,1);

for i=1:np
    pv_psd(i)=(2*pi*f(i))^2*rd_psd(i,Ird);
end

[~,PV_rms]=calculate_PSD_slopes(f,pv_psd);

max_pv_psd=[f pv_psd];

y_label='PV ((in/sec)^2/Hz)';
t_string=sprintf(' Pseudo Velocity PSD  Max at Node %d   Location (%5.3g, %5.3g) in  \n Overall Level %7.3g in/sec RMS',Ird,xx(Ird,1),xx(Ird,2),PV_rms);

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,max_pv_psd,fmin,fmax,md);

%%

max_stress_psd=[ f stress_psd(:,Ist)];

y_label='Stress (psi^2/Hz)';
t_string=sprintf(' Stress PSD  Max at Node %d   Location (%5.3g, %5.3g) in  \n Overall Level %7.4g psi RMS',Ist,xx(Ist,1),xx(Ist,2),Cst);

try
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,max_stress_psd,fmin,fmax,md);
catch
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rho=rho/386;
c=sqrt(E/rho);
scale2=Cst/(  rho*c*PV_rms );

fprintf('\n Maximum Stress estimate from Pseudo Velocity \n');
fprintf('       = %8.4g psi RMS for k=%4.2f \n',Cst,scale2)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[TT,Mwd,Mww,part_omega,part_ModeShapes,ngw,nem]=step_partition(cdof,mass_unc,stiff_unc)

%  ea= dof with enforced acceleration
% nem= number of dof with enforced acceleration

cdof=sort(unique(cdof),'descend');

Mass=mass_unc;
Stiff=stiff_unc;

sz=size(Mass);
dof=sz(1);   % unconstrained dof

num_nodes=round(dof/6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=1;
    
for i=3:6:6*num_nodes
    
    if(ismember(i,cdof))
        ea(k)=i;
        k=k+1;
    end
        
end

ibc=length(ea);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ea=unique(ea);
nem=length(ea);

ea=fix_size(ea);

TZ_tracking_array=(3:6:6*num_nodes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_con=length(cdof);

cdof=sort(cdof,'descend');

% ea = TZ dof enforced acceleration

%  Track changes
%
num=num_nodes*6;
ngw=zeros(num,1);

ngw(1:nem)=ea;
for i=1:num
    if(~ismember(i,cdof))
        ngw(nem+i)=i;
    end
end
ngw=ngw(ngw~=0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ea_orig=ea;

kk=0;

for i=1:num_con
    if(~ismember(cdof(i),ea_orig))
        Stiff(cdof(i),:)=[];
        Stiff(:,cdof(i))=[];
        Mass(cdof(i),:)=[];
        Mass(:,cdof(i))=[];
     
        kk=kk+1;
        
        for k=1:nem
            if(cdof(i)<ea(k) )
                ea(k)=ea(k)-1;
            end
        end
        for k=1:num_nodes
            if(cdof(i)<TZ_tracking_array(k))
                TZ_tracking_array(k)=TZ_tracking_array(k)-1;
            end
        end        

    end    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nem==0)
    warndlg('No drive dofs');
    return;    
end

etype=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
dtype=2; % display partitioned matrices

fprintf(' ibc=%d \n',ibc);

disp(' Enforced Partition Matrices '); 

num=length(Mass(:,1));

[TT,~,~,Mwd,Mww,~,Kww]=...
                enforced_partition_matrices(num,ea,Mass,Stiff,etype,dtype);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Generalized Eigen ');            
            
[part_fn,part_omega,part_ModeShapes,~]=Generalized_Eigen(Kww,Mww,2);            
       
disp(' n    fn(Hz) ');

for i=1:min([length(part_fn) 12])
    fprintf('%d.  %8.4g \n',i,part_fn(i));
end

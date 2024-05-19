%
%  arbit_force_function.m  ver 1.1  by Tom Irvine
%
function[acceleration,velocity,displacement,trans_force]=...
                arbit_force_function(t,f,dt,mass,fn,damp,n_force_mass_unit)
%
fig_num=1;
%
n=length(t);
%
if(n_force_mass_unit==1)
    mass=mass/386;
end
%
out1=sprintf('mass=%g',mass);
disp(out1);
%
%  Initialize coefficients
%
disp(' ')
disp(' Initialize coefficients')
%
    omegan=2.*pi*fn;
    omegad=omegan*sqrt(1.-(damp^2));
%
    out5 = sprintf(' omegan=%g   omegad=%g ',omegan,omegad);
    disp(out5);    
%    
    cosd=cos(omegad*dt);
    sind=sin(omegad*dt);
%
    out5 = sprintf(' cosd=%g   sind=%g ',cosd,sind);
    disp(out5);    
%
    domegadt=damp*omegan*dt;
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    eee1=exp(-domegadt);
    eee2=exp(-2.*domegadt);
%
    ecosd=eee1*cosd;
    esind=eee1*sind; 
%
    a1= 2.*ecosd;
    a2=-eee2;
%
    out5 = sprintf(' a1=%g  a2=%g ',a1(1),a2(1));
    disp(out5);     
%
    omeganT=omegan*dt;
%
    phi=2*(damp)^2-1;
    DD1=(omegan/omegad)*phi;
    DD2=2*DD1;
%    
    df1=2*damp*(ecosd-1) +DD1*esind +omeganT;
    df2=-2*omeganT*ecosd +2*damp*(1-eee2) -DD2*esind;
    df3=(2*damp+omeganT)*eee2 +(DD1*esind-2*damp*ecosd);
%     
    VV1=-(damp*omegan/omegad);
%    
    vf1=(-ecosd+VV1*esind)+1;
    vf2=eee2-2*VV1*esind-1;
    vf3=ecosd+VV1*esind-eee2;
%
    MD=(mass*omegan^3*dt);
    df1=df1/MD;
    df2=df2/MD;
    df3=df3/MD;
%
    VD=(mass*omegan^2*dt);
    vf1=vf1/VD;
    vf2=vf2/VD;
    vf3=vf3/VD;
%
    af1=esind/(mass*omegad*dt);
    af2=-2*af1;
    af3=af1;
%
% disp(' ');
% disp(' Include residual? ');
% disp('  1=yes  2=no ')
% ire=input(' ');
%
ire=2;
%
if(ire==1)
%
%   Add trailing zeros for residual response
%
    disp(' ')
    disp(' Add trailing zeros for residual response')
    tmax=(tmx-tmi) + 2./fn;
    limit = round( tmax/dt );
    n=limit;
end
%   
clear fdm;
fdm=f/mass;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SRS engine
%
%  displacement
%
d_forward=[   df1,  df2, df3 ];
d_back   =[     1, -a1, -a2 ];
d_resp=filter(d_forward,d_back,f);
%    
%  velocity
%
v_forward=[   vf1,  vf2, vf3 ];
v_back   =[     1, -a1, -a2 ];
v_resp=filter(v_forward,v_back,f);
%    
%  acceleration
%   
a_forward=[   af1,  af2, af3 ];
a_back   =[     1, -a1, -a2 ];
a_resp=filter(a_forward,a_back,f);
%
Q=1/(2*damp);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(n_force_mass_unit==2)
   d_resp=d_resp*1000;
end

%
displacement(:,1)=t;
displacement(:,2)=(d_resp)';
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
velocity(:,1)=t;
velocity(:,2)=(v_resp)';
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
acceleration(:,1)=t;
acceleration(:,2)=(a_resp)'; % do not delete
%
figure(fig_num);
fig_num=fig_num+1;
%
trans_force(:,1)=t;
%
trans_force(:,2)=f-mass*acceleration(:,2);  % important
%
if(n_force_mass_unit==1)
    a_resp=a_resp/386;
else
    a_resp=a_resp/9.81;
end
acceleration(:,2)=(a_resp)';  % do not delete
%
plot(t,a_resp); 
xlabel('Time (sec)');
ylabel('Accel (G)');
%
if(n_force_mass_unit==1)
    out5 = sprintf('SDOF Acceleration Response: mass=%g lbm  fn=%g Hz Q=%g',mass*386,fn,Q);
else
    out5 = sprintf('SDOF Acceleration Response: mass=%g kg  fn=%g Hz Q=%g',mass,fn,Q);
end
title(out5);
%
grid;
zoom on;

tt=t;
d=d_resp;
v=v_resp;
a=a_resp;

ay='Accel (G)';
if(n_force_mass_unit==1)
    out5 = sprintf('SDOF Acceleration Response: mass=%g lbm  fn=%g Hz Q=%g',mass*386,fn,Q);
else
    out5 = sprintf('SDOF Acceleration Response: mass=%g kg  fn=%g Hz Q=%g',mass,fn,Q);
end
aat=out5;

if(n_force_mass_unit==1)
    vy='Vel (inch/sec)';
    out5 = sprintf('SDOF Velocity Response: mass=%g lbm  fn=%g Hz Q=%g',mass*386,fn,Q);
else
    vy='Vel (m/sec)';
    out5 = sprintf('SDOF Velocity Response: mass=%g kg  fn=%g Hz Q=%g',mass,fn,Q);
end
vvt=out5;

if(n_force_mass_unit==1)
    dy='Disp (inch)';
    out5 = sprintf(' SDOF Displacement Response: mass=%g lbm fn=%g Hz Q=%g ',mass*386,fn,Q);
else
    dy='Disp (mm)';
    out5 = sprintf(' SDOF Displacement Response: mass=%g kg fn=%g Hz Q=%g ',mass,fn,Q);    
end    
ddt=out5;


[fig_num,hp]=plot_avd_time_histories_subplots_altp_titles(fig_num,tt,a,v,d,ay,vy,dy,aat,vvt,ddt);


data1=[t f];
data2=trans_force;

xlabel2='Time (sec)';

if(n_force_mass_unit==1)
    ylabel1='Force (lbf)';
else
    ylabel1='Force (N)';
end
ylabel2=ylabel1;

t_string1='Applied Force';

if(n_force_mass_unit==1)
    t_string2 = sprintf('Transmitted Force: mass=%g lbm  fn=%g Hz Q=%g',mass*386,fn,Q);
else
    t_string2 = sprintf('Transmitted Force: mass=%g kg  fn=%g Hz Q=%g',mass,fn,Q);
end

[fig_num]=...
    subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,...
                                          data1,data2,t_string1,t_string2);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

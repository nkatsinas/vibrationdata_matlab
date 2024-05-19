
%   fixed_free_point_force_end_frf.m  ver 1.0  by Tom Irvine

function[a,v,d,bs]=fixed_free_point_force_end_frf(fstart,fend,fn,damp,mass,L,beta,C,iu,E,MOI,cna)

    fig_num=1;
 
    LBC=1;
    RBC=3;  
    sq_mass=sqrt(mass);

    [ModeShape,ModeShape_dd]=beam_bending_modes_shapes(LBC,RBC);
 
    nf=1000;
    n=length(fn);
%
    disp(' ');
    fmax=fend;
%
    f=zeros(nf,1);
    f(1)=fstart;
    for k=2:nf
        f(k)=f(k-1)*2^(1/48);
        if(f(k)>fmax)
            break;
        end    
    end
    nf=max(size(f));
   
    YY=zeros(n,1);
    YYdd=zeros(n,1);
   
    for i=1:n
        arg=beta(i)*L;
        YY(i)=ModeShape(arg,C(i),sq_mass);
 
        arg=beta(i)*0;
        YYdd(i)=ModeShape_dd(arg,C(i),beta(i),sq_mass);
    end
%
    H_d=zeros(nf,1);
    H_v=zeros(nf,1);   
    H_a=zeros(nf,1);
    H_moment=zeros(nf,1);
% 
    for k=1:nf
       
        om=2*pi*f(k);
        
        for i=1:n
            
            omn=2*pi*fn(i);
            num=YY(i)^2;
            den=(omn^2-om^2)+(1i)*2*damp(i)*om*omn;
       
            H_d(k)=H_d(k)+(num/den);
            
            num_moment=YY(i)*YYdd(i);
            
            H_moment(k)=H_moment(k)+E*MOI*(num_moment/den);
            
        end
        
        H_v(k)=(1i)*om*H_d(k);       
        H_a(k)=-om^2*H_d(k);
        
    end
%
    H_d=abs(H_d);
    H_v=abs(H_v);    
    H_a=abs(H_a);  
    H_moment=abs(H_moment);
    H_stress=H_moment*cna/MOI;
%
    if(iu==1)
        H_a=H_a/386;
    else
        H_a=H_a/9.81;          
    end
%
    maxHd=0.;
    maxHv=0.;    
    maxHa=0.;
    maxHs=0.;
    maxFd=0.;
    maxFv=0.;
    maxFa=0.;    
    maxFs=0;
%
    for k=1:nf
        if(H_d(k)>maxHd)
            maxHd=H_d(k);
            maxFd=f(k);
        end
        if(H_v(k)>maxHv)
            maxHv=H_v(k);
            maxFv=f(k);
        end        
        if(H_a(k)>maxHa)
            maxHa=H_a(k);
            maxFa=f(k);
        end
        if(H_stress(k)>maxHs)
            maxHs=H_stress(k);
            maxFs=f(k);
        end      
    end       
%
    H_d=fix_size(H_d);
    H_v=fix_size(H_v);
    H_a=fix_size(H_a);
    H_stress=fix_size(H_stress);
%
    n=length(f);
    for i=n:-1:1
%
       if(f(i)==0)
             f(i)=[];
           H_d(i)=[];
           H_v(i)=[]; 
           H_a(i)=[];  
           H_stress(i)=[];
       end
%
    end
   
%%%
    out1=sprintf('\n Response at Free End');
    disp(out1); 
%%%

    md=5;
    fmin=fstart;
    fmax=fend;
    x_label='Frequency (Hz)';

%%%    
  
    t_string='Displacement Frequency Response Function at Free End';
    
    ppp=[f H_d];
        
    if(iu==1)
        y_label='Disp (in) / Force (lbf)';
    else
        y_label='Disp (m) / Force(N)';        
    end
    
    [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md); 
    
    if(iu==1)
        out1=sprintf('  max Disp FRF = %9.5f (in/lbf) at %8.4g Hz ',maxHd,maxFd);
    else
        out1=sprintf('  max Disp FRF = %9.5f (m/N) at %8.4g Hz ',maxHd,maxFd);       
    end
    disp(out1);
%
    displacement=[f H_d];
%%%
%%%

    ppp=[f H_v];
%
    t_string='Velocity Frequency Response Function at Free End';
    if(iu==1)
        y_label='Vel (in/sec) / Force (lbf)';
    else
        y_label='Vel (m/sec) / Force (N)';        
    end
%
   [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);
%

    if(iu==1)
        out1=sprintf('  max Vel FRF = %9.5f ((in/sec)/lbf) at %8.4g Hz ',maxHv,maxFv);
    else
        out1=sprintf('  max Vel FRF = %9.5f ((m/sec)/N) at %8.4g Hz ',maxHv,maxFv);       
    end
    disp(out1);
%
    velocity=[f H_v];
%%%

    ppp=[f H_a];
    t_string='Acceleration Frequency Response Function at Free End';
%    
    if(iu==1)
        y_label='Accel (G) / Force (lbf) ';
    else
        y_label='Accel (G) / Force (N) ';        
    end
    
   [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
  
    if(iu==1)
        out1=sprintf('  max Absolute Accel FRF = %8.4g (G/lbf) at %8.4g Hz ',maxHa,maxFa);
    else
        out1=sprintf('  max Absolute Accel FRF = %8.4g (G/N) at %8.4g Hz ',maxHa,maxFa);        
    end
    disp(out1);
%
    acceleration=[f H_a];
%
%%%%%%%%%%%
%
    ppp=[f H_stress];
    t_string='Bending Stress Frequency Response Function at Fixed End';
%    
    if(iu==1)
        y_label='Stress (psi) / Force (lbf) ';
    else
        y_label='Stress (Pa) / Force (N) ';        
    end
    
   [fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);    
  
    if(iu==1)
        out1=sprintf('  max Bending Stress FRF = %8.4g (psi/lbf) at %8.4g Hz ',maxHs,maxFs);
    else
        out1=sprintf('  max Bending Stress FRF = %8.4g (Pa/N) at %8.4g Hz ',maxHs,maxFs);        
    end
    disp(out1);
%
    bs=[f H_stress];
    a=acceleration;
    v=velocity;
    d=displacement;
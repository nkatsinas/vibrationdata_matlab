
%  fixed_free_point_force_end_fth.m  ver 1.0  by Tom Irvine

function[a,v,d,bs]=fixed_free_point_force_end_fth(THM,fn,damp,mass,L,beta,C,iu,E,MOI,cna)

    fig_num=1;
 
    LBC=1;
    RBC=3;  
    sq_mass=sqrt(mass);
       
    [ModeShape,ModeShape_dd]=beam_bending_modes_shapes(LBC,RBC);

    n=length(fn);
%
    disp(' ');
%
    YY=zeros(n,1);
    YYdd=zeros(n,1);
   
    for i=1:n
        arg=beta(i)*L;
        YY(i)=ModeShape(arg,C(i),sq_mass);
 
        arg=beta(i)*0;
        YYdd(i)=ModeShape_dd(arg,C(i),beta(i),sq_mass);
    end
%
    t=THM(:,1);
    num_steps=length(t);
    force=THM(:,2);
    tt=t;
%
    dt=mean(diff(tt));
%
    disp(' ')
    disp(' Time Step ');
    dtmin=min(diff(t));
    dtmax=max(diff(t));
%
    out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
    out5 = sprintf(' dt     = %8.4g sec  ',dt);
    out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
    disp(out4)
    disp(out5)
    disp(out6)
%
    disp(' ')
    disp(' Sample Rate ');
    out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
    out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
    out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
    disp(out4)
    disp(out5)
    disp(out6)
%
    if(((dtmax-dtmin)/dt)>0.01)
        disp(' ')
        disp(' Warning:  time step is not constant.')
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    [a1,a2,a_b1,a_b2,a_b3,v_b1,v_b2,v_b3,d_b1,d_b2,d_b3]=...
                                      srs_coefficients_avd(fn,damp,dt);

%%%%%%%%%%%  

    num_fn=length(fn);
    
    d=zeros(num_steps,1);
    v=zeros(num_steps,1);
    a=zeros(num_steps,1);    
    bm=zeros(num_steps,1);    
                                  
    for j=1:num_fn
%
            yp=force*YY(j);
%
            back   =[     1, -a1(j), -a2(j) ];
%
%   velocity
%
            clear forward;
            forward=[ v_b1(j),  v_b2(j),  v_b3(j) ];    
            nv=filter(forward,back,yp);
%
%   displacement
%
            clear forward;
            forward=[ d_b1(j),  d_b2(j),  d_b3(j) ];      
            nd=filter(forward,back,yp);
            nbm=nd;
%
%   acceleration
%
            clear forward;  
            forward=[ a_b1(j),  a_b2(j),  a_b3(j) ];    
            na=filter(forward,back,yp);     
%
            arg=beta(j)*L;
            
            ZZ=ModeShape(arg,C(j),sq_mass);
            
            d= d +ZZ*nd;
            v= v +ZZ*nv;
            a= a +ZZ*na;               
           
            arg=beta(j)*0;
            ZZdd=ModeShape_dd(arg,C(j),beta(j),sq_mass);
            bm= bm +ZZdd*nbm;  
%        
    end
    
%%%%%%%%%%%

    bm=bm*E*MOI;
    bstress=bm*(cna/MOI);
    
%
    if(iu==1)
        a=a/386;
        
    else
        d=d*1000;
        a=a/9.81;        
    end
%    
%%%%%%%%%%%

    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,a,'b');
    title('Acceleration at Free End');
    ylabel('Accel (G)');
    xlabel('Time (sec)');
    grid on;
    
    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,v,'b');
    title('Velocity at Free End');
    if(iu==1)
        ylabel('Vel (in/sec)');
    else
        ylabel('Vel (m/sec)');        
    end
    xlabel('Time (sec)');
    grid on;    

    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,d,'b');
    if(iu==1)
        ylabel('Disp (in)');
    else
        ylabel('Disp (mm)');        
    end
    title('Displacement at Free End');
    xlabel('Time (sec)');
    grid on;      
    

    figure(fig_num)
    fig_num=fig_num+1;
    plot(t,bstress,'b');
    if(iu==1)
        ylabel('Stress (psi)');
    else
        ylabel('Stress (Pa)');        
    end
    title('Bending Stress at Fixed End');
    xlabel('Time (sec)');
    grid on;      
    
%%%%%%%%%%%
%
    disp(' ');

    a=[t a];
    v=[t v];    
    d=[t d];    
    bs=[t bstress];        
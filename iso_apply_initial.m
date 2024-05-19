%
%  iso_apply_initial.m  ver 1.2  August 20, 2012
%
function[fig_num]=iso_apply_initial(m,fn,damp,ModeShapes,fig_num)
%
iu=1;
Q=ModeShapes;
MST=ModeShapes';
%
while(1)
%
    di=zeros(6,1);
    vi=zeros(6,1);
%
%
    disp(' ');
    disp(' Apply initial conditions? ');
    disp(' 1=yes  2=no ');
    inn = input(' ');
%
    if(inn==2)
        break;
    end
%
    disp(' ');        
    disp(' Apply initial displacement? ');
    disp(' 1=yes  2=no ');
    id_ap = input(' ');
%
    if(id_ap==1)
        disp(' Enter initial displacement(inch) X-axis:');
        di(1)=input(' ');
        disp(' Enter initial displacement(inch) Y-axis:');
        di(2)=input(' ');    
        disp(' Enter initial displacement(inch) Z-axis:');
        di(3)=input(' ');    
    end
    disp(' ');        
    disp(' Apply initial velocity? ');
    disp(' 1=yes  2=no ');
    iv_ap = input(' ');
%    
    if(iv_ap==1)
        disp(' Enter initial velocity(in/sec) X-axis:');
        vi(1)=input(' ');
        disp(' Enter initial velocity(in/sec) Y-axis:');
        vi(2)=input(' ');    
        disp(' Enter initial velocity(in/sec) Z-axis:');
        vi(3)=input(' ');    
    end
%
    disp(' ');
    sug = 10/(min(fn));
    disp(' Enter total analysis duration (sec) ');
    out1=sprintf(' (suggest > %9.5g)',sug);
    disp(out1);    
    dur=input(' ');
%
    sug = 10*max(fn);
    disp(' ');
    disp(' Enter sample rate (samples/sec) '); 
    out1=sprintf(' (suggest > %9.5g)',sug);
    disp(out1);
    sr=input(' ');
    dt=1/sr;
% 
    nt=round(dur/dt);
%
    omegan=2*pi*fn;
%
    omegad=zeros(6,1);
    domegan=zeros(6,1);
%
    d=zeros(nt,6);
    v=zeros(nt,6);
    a=zeros(nt,6);
%
    for i=1:6
       omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
       domegan(i)=damp(i)*omegan(i);
       omn2(i)=omegan(i)^2;
    end
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
%
    ndi=MST*m*di;
    nvi=MST*m*vi;    
%
    W=zeros(6,1);
%
    for i=1:6
        W(i)=(nvi(i) + domegan(i)*ndi(i))/omegad(i);
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    tt=zeros(nt,1);
    deee=zeros(6,1);
%
    nd=zeros(6,1);
    nv=zeros(6,1);
    na=zeros(6,1);
%
    for i=1:nt
        t=dt*(i-1);
        tt(i)=t;
%        
        eee=exp(-domegan*t); 
%
%
        for j=1:6
%
           eee(j)=exp(-domegan(j)*t); 
           deee(j)=-damp(j)*omegan(j)*eee(j);                
%
           argd=omegad*t;
%
           cd=cos(argd);
           sd=sin(argd);
%
                nd(j)=    eee(j)*( ndi(j)*cd(j)  +W(j)*sd(j) );
                nv(j)=   deee(j)*nd(j)...
                      +omegad(j)*eee(j)*( -ndi(j)*sd(j)  +W(j)*cd(j) );           
%
            na(j)= -2*damp(j)*omegan(j)*nv(j) -omn2(j)*nd(j);
%
        end
%
        d(i,:)=Q(:,1:6)*nd(1:6);
        v(i,:)=Q(:,1:6)*nv(1:6);
        a(i,:)=Q(:,1:6)*na(1:6);  
%
    end
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(tt,d(:,1),tt,d(:,2),tt,d(:,3));
        grid on;
        legend ('X-axis','Y-axis','Z-axis'); 
        xlabel('Time(sec)'); 
        out1=sprintf('Displacement Response');
%            
        title(out1);
        if(iu==1)
            ylabel('Disp(in)');
        else
            ylabel('Disp(m)');    
        end
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(tt,v(:,1),tt,v(:,2),tt,v(:,3));
        grid on;
        legend ('X-axis','Y-axis','Z-axis'); 
        xlabel('Time(sec)'); 
        out1=sprintf('Velocity Response');
%            
        title(out1);
        if(iu==1)
            ylabel('Vel(in)');
        else
            ylabel('Vel(m)');    
        end        
%
        figure(fig_num);
        fig_num=fig_num+1;
        if(iu==1)
            a(:,1)=a(:,1)/386;
            a(:,2)=a(:,2)/386;
            a(:,3)=a(:,3)/386;  
        end
        plot(tt,a(:,1),tt,a(:,2),tt,a(:,3));
        grid on;
        xlabel('Time(sec)');
        out1=sprintf('Acceleration Response');
%         
        title(out1);
        if(iu==1)
            ylabel('Accel(G)');
        else
            ylabel('Accel(m/sec^2)');    
        end
        legend('X-axis','Y-axis','Z-axis');         
%
        ax=a(:,1);
        ay=a(:,2);
        az=a(:,3);
%
        vx=v(:,1);
        vy=v(:,2);
        vz=v(:,3);
%
        dx=d(:,1);
        dy=d(:,2);
        dz=d(:,3);
%
        if(max(abs(ax))<1.0e-09 )
            ax=0.;
        end
        if(max(abs(ay))<1.0e-09 )
            ay=0.;
        end
        if(max(abs(az))<1.0e-09 )
            az=0.;
        end  
%
        if(max(abs(vx))<1.0e-09 )
            vx=0.;
        end
        if(max(abs(vy))<1.0e-09 )
            vy=0.;
        end
        if(max(abs(vz))<1.0e-09 )
            vz=0.;
        end         
%
        if(max(abs(dx))<1.0e-09 )
            dx=0.;
        end
        if(max(abs(dy))<1.0e-09 )
            dy=0.;
        end
        if(max(abs(dz))<1.0e-09 )
            dz=0.;
        end         
%
        disp(' ');
        disp('  Acceleration Response (G)');
        disp('              max       min  ');
        out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(ax),min(ax));
        out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(ay),min(ay));
        out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(az),min(az));
        disp(out1);
        disp(out2);
        disp(out3);
%
        disp(' ');
        disp('  Velocity Response (inch) ');
        disp('              max      min  ');
        out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(vx),min(vx));
        out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(vy),min(vy));
        out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(vz),min(vz));
        disp(out1);
        disp(out2);
        disp(out3);
%
        disp(' ');
        disp('  Displacement Response (inch) ');
        disp('              max      min  ');
        out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(dx),min(dx));
        out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(dy),min(dy));
        out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(dz),min(dz));
        disp(out1);
        disp(out2);
        disp(out3);
        disp(' ');
        disp(' Perform another initial condition case? ');
        disp(' 1=yes  2=no ');
        ian=input(' ');
        if(ian==2)
           break;
        end
    end
%
end
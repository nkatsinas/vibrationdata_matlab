%
%  iso_apply_hs.m  ver 1.1  December 20, 2011
%
function[fig_num]=iso_apply_hs(m,fn,damp,ModeShapes,PF,fig_num)
%
disp(' ');
disp(' Apply half-sine base input pulse? ');
disp(' 1=yes  2=no ');
ihs = input(' ');
%
if(ihs==1)
while(1)
    clear A;
    clear T;
    clear t;
    clear tt;
    clear nt;
%
    clear ra;
    clear rv;
    clear rd;
    clear x;
    clear v;
    clear a;
    clear t;
    clear tt;
    clear nt;
    clear temp;
    clear gamma;
    clear den;
    clear mmm;
    clear Tn;
    clear Tnv;
    clear W;
    clear eee;
    clear deee;
    clear P;
    clear abase;
%
    iu=1;
    PF=PF/386;
    Q=ModeShapes;
    MST=ModeShapes';
%
    disp(' ');
    disp(' Enter input axis ');
    disp(' 1=X  2=Y  3=Z ');
    iaxis=input(' ');
    disp(' ');
%
    disp(' ');
    A=input(' Enter amplitude(G) ');
    disp(' ');
%
    if(iu==1)
        A=A*386;
    end
%
    T=input(' Enter pulse duration(sec) '); 
%
    disp(' ');
    dur=input(' Enter total analysis duration (sec) ');
    disp(' ');
    sug = 20*max(fn);
    if(10/T > sug )
        sug = 10/T;
    end
    disp(' Enter sample rate (samples/sec) '); 
    out1=sprintf(' (suggest > %9.5g)',sug);
    disp(out1);
    sr=input(' ');
    dt=1/sr;
% 
    nt=round(dur/dt);
%
    gamma = PF;
%
    omega=pi/T;
    omegan=2*pi*fn;
%
    den=zeros(6,1);
    U1=zeros(6,1);
    U2=zeros(6,1);
    V1=zeros(6,1);
    V2=zeros(6,1);
    P=zeros(6,1);
    omegad=zeros(6,1);
    domegan=zeros(6,1);
%
    rd=zeros(nt,6);
    rv=zeros(nt,6);
    ra=zeros(nt,6);
    abase=zeros(nt,1);
%
    An=zeros(6,1);
%
    om2=omega^2;
    for(i=1:6)
       omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
       domegan(i)=damp(i)*omegan(i);
       omn2(i)=(omegan(i))^2;
       den(i)=( (om2-omn2(i))^2 + (2*damp(i)*omega*omegan(i))^2);
       U1(i)=2*damp(i)*omega*omegan(i);
       U2(i)=om2-omn2(i);
       V1(i)=2*damp(i)*omegan(i)*omegad(i);
       V2(i)=om2-omn2(i)*(1-2*(damp(i))^2);
       P(i)=omega/omegad(i);
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Transition points
%
    t=T;
%
    eee=exp(-domegan*t); 
%
    arg=omega*t;
%
    argd=omegad*t;
%
    c1=cos(arg);
    s1=sin(arg);
    cd=cos(argd);
    sd=sin(argd);
%
    for j=1:6
%
        An(j)=MST(j,iaxis)*m(iaxis,iaxis)*A;
%               
        term1=U1(j)*c1 + U2(j)*s1;
        term2=V1(j)*cd(j)+V2(j)*sd(j);
        dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
        dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
        deee(j)=-damp(j)*omegan(j)*eee(j);
%
        Tn(j)=An(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
        Tnv(j)=An(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);          
%
        W(j)= ( Tnv(j) +   damp(j)*omegan(j)*Tn(j) )/omegad(j);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    for i=1:nt
        t=dt*(i-1);
        tt(i)=t;
%        
        eee=exp(-domegan*t); 
%
        arg=omega*t;
%
        argd=omegad*t;
%
        c1=cos(arg);
        s1=sin(arg);
        cd=cos(argd);
        sd=sin(argd);
%
        for j=1:6
%
            if(t<=T)
                abase(i)=A*s1;
                An(j)=MST(j,iaxis)*m(iaxis,iaxis)*A;
 %               
                term1=U1(j)*c1 + U2(j)*s1;
                term2=V1(j)*cd(j)+V2(j)*sd(j);
                dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
                dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
                deee(j)=-damp(j)*omegan(j)*eee(j);
%
                n(j)=An(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
                nv(j)=An(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);          
%
            else
                abase(i)=0;
                ts=t-T;
%
                eee(j)=exp(-domegan(j)*ts); 
                deee(j)=-damp(j)*omegan(j)*eee(j);                
%
                arg=omega*ts;
%
                argd=omegad*ts;
%
                c1=cos(arg);
                s1=sin(arg);
                cd=cos(argd);
                sd=sin(argd);
%
                 n(j)=    eee(j)*( Tn(j)*cd(j)  +W(j)*sd(j) );
                nv(j)=   deee(j)*n(j)...
                      +omegad(j)*eee(j)*( -Tn(j)*sd(j)  +W(j)*cd(j) );           
            end
%
            An(j)=MST(j,iaxis)*m(iaxis,iaxis)*abase(i);
            na(j)= -2*damp(j)*omegan(j)*nv(j) -omn2(j)*n(j) -An(j);
%
        end
%
        rd(i,:)=Q(:,1:6)*n(1:6)';
        rv(i,:)=Q(:,1:6)*nv(1:6)';
        ra(i,:)=Q(:,1:6)*na(1:6)';  
%
        a(i,:)=ra(i,:);
%        
        a(i,iaxis)=a(i,iaxis)+abase(i);
%
    end
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(tt,rd(:,1),tt,rd(:,2),tt,rd(:,3));
        grid on;
        legend ('X-axis','Y-axis','Z-axis'); 
        xlabel('Time(sec)');
        if(iaxis==1)
            out1=sprintf('Relative Displacement Response to Half-Sine Pulse X-axis Input');
        end  
        if(iaxis==2)
            out1=sprintf('Relative Displacement Response to Half-Sine Pulse Y-axis Input');
        end
         if(iaxis==3)
            out1=sprintf('Relative Displacement Response to Half-Sine Pulse Z-axis Input');
        end         
        title(out1);
        if(iu==1)
            ylabel('Rel Disp(in)');
        else
            ylabel('Rel Disp(m)');    
        end
%
        figure(fig_num);
        fig_num=fig_num+1;
        if(iu==1)
            a(:,1)=a(:,1)/386;
            a(:,2)=a(:,2)/386;
            a(:,3)=a(:,3)/386;  
            abase=abase/386;
        end
        plot(tt,abase,tt,a(:,1),tt,a(:,2),tt,a(:,3));
        grid on;
        xlabel('Time(sec)');
        if(iaxis==1)
            out1=sprintf('Acceleration Response to Half-Sine Pulse X-axis Input');
        end  
        if(iaxis==2)
            out1=sprintf('Acceleration Response to Half-Sine Pulse Y-axis Input');
        end
         if(iaxis==3)
            out1=sprintf('Acceleration Response to Half-Sine Pulse Z-axis Input');
        end         
        title(out1);
        if(iu==1)
            ylabel('Accel(G)');
        else
            ylabel('Accel(m/sec^2)');    
        end
        legend ('Base Input','X-axis','Y-axis','Z-axis');         
%
        ax=a(:,1);
        ay=a(:,2);
        az=a(:,3);
        rdx=rd(:,1);
        rdy=rd(:,2);
        rdz=rd(:,3);
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
        if(max(abs(rdx))<1.0e-09 )
            rdx=0.;
        end
        if(max(abs(rdy))<1.0e-09 )
            rdy=0.;
        end
        if(max(abs(rdz))<1.0e-09 )
            rdz=0.;
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
        disp('  Relative Displacement Response (inch) ');
        disp('              max      min  ');
        out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(rdx),min(rdx));
        out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(rdy),min(rdy));
        out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(rdz),min(rdz));
        disp(out1);
        disp(out2);
        disp(out3);
        disp(' ');
        disp(' Perform another half-sine base input case? ');
        disp(' 1=yes  2=no ');
        ian=input(' ');
        if(ian==2)
           break;
        end
    end
%
end
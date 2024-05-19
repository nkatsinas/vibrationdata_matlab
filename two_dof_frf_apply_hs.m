function[fig_num]=two_dof_frf_apply_hs(m,fn,omegan,omegad,damp,Q,fig_num,iu)
%
disp(' ');
disp(' Apply half-sine base input pulse? ');
disp(' 1=yes  2=no ');
ihs = input(' ');
%
if(ihs==1)
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
    sug = 20*fn(2,2);
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
    mmm=[m(1,1); m(2,2)];
    gamma = Q'*mmm;
%
    omega=pi/T;
%
    den=zeros(2,1);
    U1=zeros(2,1);
    U2=zeros(2,1);
    V1=zeros(2,1);
    V2=zeros(2,1);
    P=zeros(2,1);
%    
    om2=omega^2;
    for(i=1:2)
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
    eee=exp(-damp.*omegan*t); 
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
    for(j=1:2)
        abase=A*s1;
        term1=U1(j)*c1 + U2(j)*s1;
        term2=V1(j)*cd(j)+V2(j)*sd(j);
        dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
        dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
        deee(j)=-damp(j)*omegan(j)*eee(j);
%
        Tn(j)=A*gamma(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
        Tnv(j)=A*gamma(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);          
%
        W(j)= ( Tnv(j) +   damp(j)*omegan(j)*Tn(j) )/omegad(j);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    for(i=1:nt)
        t=dt*(i-1);
        tt(i)=t;
%        
        eee=exp(-damp.*omegan*t); 
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
        for(j=1:2)
%
            if(t<=T)
                abase=A*s1;
                term1=U1(j)*c1 + U2(j)*s1;
                term2=V1(j)*cd(j)+V2(j)*sd(j);
                dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
                dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
                deee(j)=-damp(j)*omegan(j)*eee(j);
%
                n(j)=A*gamma(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
                nv(j)=A*gamma(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);          
%
            else
                abase=0;
                ts=t-T;
%
                eee=exp(-damp.*omegan*ts); 
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
                 n(j)=  eee(j)*( Tn(j)*cd(j)  +W(j)*sd(j) );
                nv(j)=-damp(j)*omegan(j)*n(j)...
                      + eee(j)*( -Tn(j)*sd(j)  +W(j)*cd(j) );           
            end
%
            na(j)= -2*damp(j)*omegan(j)*nv(j) -omn2(j)*n(j) -gamma(j)*abase;
%
        end
%
        rd(i,:)=Q(:,1:2)*n(1:2)';
        rv(i,:)=Q(:,1:2)*nv(1:2)';
        ra(i,:)=Q(:,1:2)*na(1:2)';  
%
        a(i,:)=ra(i,:)+abase;
%
    end
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(tt,rd(:,1),tt,rd(:,2));
        grid on;
        xlabel('Time(sec)');
        title('Relative Displacement');
        if(iu==1)
            ylabel('Rel Disp(in)');
        else
            ylabel('Rel Disp(m)');    
        end
        legend ('mass 1','mass 2');             
%
        figure(fig_num);
        fig_num=fig_num+1;
        if(iu==1)
            a(:,1)=a(:,1)/386;
            a(:,2)=a(:,2)/386;
        end
        plot(tt,a(:,1),tt,a(:,2));
        grid on;
        xlabel('Time(sec)');
        title('Acceleration');
        if(iu==1)
            ylabel('Accel(G)');
        else
            ylabel('Accel(m/sec^2)');    
        end
        legend ('mass 1','mass 2');         
%
end
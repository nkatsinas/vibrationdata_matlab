%
%  cantilever_beam_half_sine.m  ver 1.1  March 1, 2012
%
%
function[fig_num]=cantilever_beam_base_half_sine(iu,fn,damp,NT,PF,beta,C,x,fig_num)
%        
    tpi=2*pi;
    disp(' ');
    T=input(' Enter the excitation duration (sec): ');
    disp(' ');
    A=input(' Enter the base acceleration (G): ');
%
    dur1=5*T;
    dur2=5/fn(1);
    dur=max([dur1 dur2]);
%
    dt1=T/20;
    dt2=(1/max(fn))/10;
%
    dt=min([dt1 dt2]);
%
    num_steps=round(dur/dt);
%
    t=linspace(0,dur,num_steps);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    omega=pi/T;
    omegan=tpi*fn;
%
    den=zeros(NT,1);
    U1=zeros(NT,1);
    U2=zeros(NT,1);
    V1=zeros(NT,1);
    V2=zeros(NT,1);
    P=zeros(NT,1);
    omegad=zeros(NT,1);
    domegan=zeros(NT,1);
    omn2=zeros(NT,1);
%
    abase=zeros(num_steps,1);
%
    An=zeros(NT,1);
%
    om2=omega^2;
%    
    for i=1:NT
       omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
       domegan(i)=damp(i)*omegan(i);
       omn2(i)=(omegan(i))^2;
       den(i)=( (om2-omn2(i))^2 + (2*damp(i)*omega*omegan(i))^2);
       U1(i)=2*damp(i)*omega*omegan(i);
       U2(i)=om2-omn2(i);
       V1(i)=2*damp(i)*omegan(i)*omegad(i);
       V2(i)=om2-omn2(i)*(1-2*(damp(i))^2);
       P(i)=omega/omegad(i);
%
       A11(i)=-(om2-omn2(i));
       A12(i)=-2*damp(i)*omega*omegan(i);
       A21(i)=2*damp(i)*om2;
       A22(i)=(omegan(i)/omegad(i))*(-omn2(i)+om2*(1-2*damp(i)^2));
%
    end
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Transition points
%
    eee=exp(-domegan*T); 
%
    arg=omega*T;
%
    argd=omegad*T;
%
    c1=cos(arg);
    s1=sin(arg);
    cd=cos(argd);
    sd=sin(argd);
%
    for j=1:NT
%
        An(j)=PF(j)*A;   
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
    abase=zeros(num_steps,1);
       rd=zeros(num_steps,1);
      acc=zeros(num_steps,1);
%
    for i=1:num_steps
%
        eee=exp(-domegan*t(i)); 
%
        arg=omega*t(i);
%
        argd=omegad*t(i);
%
        c1=cos(arg);
        s1=sin(arg);
        cd=cos(argd);
        sd=sin(argd);     
%
        n=zeros(NT,1);
        nv=zeros(NT,1);
        na=zeros(NT,1);
        An=zeros(NT,1);
%
        deee=zeros(NT,1);
%
        for j=1:NT
%            
            if(abs(PF(j))>0)
%
                if t(i)<=T
%                   
                    abase(i)=A*s1;
                    An(j)=PF(j)*A;
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
                    a1=om2*(  A11(j)*s1  + A12(j)*c1);
                    a2=omega*omegan(j)*eee(j)*(  A21(j)*cd(j) +A22(j)*sd(j));
%                    
                    na(j)=An(j)*(a1+a2)/den(j);
%
                else
                    ts=t(i)-T;
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
%                        
                    na(j)= -2*damp(j)*omegan(j)*nv(j) -omn2(j)*n(j);      
                end
%
                arg=beta(j)*x;
                ZZ=(cosh(arg)-cos(arg))+C(j)*(sinh(arg)-sin(arg));                 
%
                rd(i)=rd(i) +ZZ*n(j);
               acc(i)=acc(i)+ZZ*na(j); 
%                           
            end  % PF                    
%
        end  % j mode
%
    end      % i  time 
%
%       
    acc=acc+abase;
%
    if(iu==1)
        rd=rd*386.;
    end
%
    disp(' ');
    disp(' Peak Response Values ');
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
    if(iu==1)
        out2=sprintf('\n Relative Displacement = %8.4g in',max(abs(rd)));    
    else
        out2=sprintf('\n Relative Displacement = %8.4g m',max(abs(rd)));        
    end
%    
    disp(out2);
    disp(out1);
%
%%%
%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);
%
    out1=sprintf('Relative Displacement at %8.4g in',x);
    title(out1);
    if(iu==1)
        ylabel('Rel Disp(in) ');
    else
        ylabel('Rel Disp(m) ');
    end
    xlabel('Time(sec)');
    grid on;
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc,t,abase);
%
    out1=sprintf('Acceleration at %8.4g in',x);
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)');
    legend('response','input');  
    grid on;
%
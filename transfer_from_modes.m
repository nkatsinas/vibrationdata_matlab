disp(' ');
disp(' transfer_from_modes.m   ver 2.5   March 27, 2014 ');
disp(' by Tom Irvine ');
%
disp(' ');
disp(' This program calculates a transfer function for each   ');
disp(' degree-of-freedom in a system based on the mode shapes, ');
disp(' natural frequencies, and damping ratios. ');
%
clear freq;
clear fnv;
clear dampv;
clear QE;
clear H;
clear HM;
clear HP;
clear H_response_force;
clear H_base_force;
clear max;
clear PHA;
clear PPP;
%
close all;
%
tpi=2*pi;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Select input method ');
disp('  1=mass & stiffness matrices ');
disp('  2=natural frequencies and mass-normalized eigenvectors ');
%
imethod=input(' ');
%
disp(' ');
disp(' Select output metric ');
disp('  1=displacement/force ');
disp('  2=velocity/force ');
disp('  3=acceleration/force ');
disp('  4=acceleration/acceleration ');
disp('  5=force/displacement');
%
iam=input(' ');
%
disp(' ');
disp(' Enter units: ');
if(iam==1 || iam==5)
    disp(' 1= inches, lbf ');
    disp(' 2= meters, N ');
end
if(iam==2)
    disp(' 1= inches/sec, lbf ');
    disp(' 2= meters/sec, N ');
end
if(iam==3 || iam==4)
    disp(' 1= G, lbf ');
    disp(' 2= meters/sec^2, N ');
end
iu=input(' ');
%
if(imethod==1)
    disp(' ');
        mass = input(' Enter the mass matrix name:  ');
    %    mass
    disp(' ');
    disp(' Divide mass by 386? ');
    disp(' 1=yes 2=no ');
    idm=input(' ');
    if(idm==1)
        mass=mass/386;
   %     mass
    end
    m=mass;
    disp(' ');
    stiffness = input(' Enter the stiffness matrix name:  ');
  %  stiffness
%
    num=max(size(mass));
%
    [fnv,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,1);
    QE=ModeShapes;
%
else
    disp(' ');
    disp(' Enter the name of the mass-normalized eigenvector matrix ');
    QE=input(' ');
    QE
    num=max(size(QE));
%
    disp(' ');
    disp(' Enter the natural frequency (Hz) vector or matrix ');
    clear fff;
    fff=input(' ');
    sz=size(fff);
    fnv=zeros(sz(1),1);
    if(sz(1)==sz(2))
        for i=1:sz(1)
            fnv(i)=fff(i,i);
        end
    else
        fnv=fff;
    end
    fnv
end
%
num_modes=max(size(fnv));
%
[dampv]=enter_modal_damping(num_modes);
dampv
%
disp(' ');
num_columns=input(' Enter the maximum mode number of interest ');
%
nrb=0;
%
if(fnv(1)<1.0)
    disp(' ');
    disp(' Does the system have any rigid-body modes which are to be suppressed? ');  
    disp(' 1=yes 2=no ');
    isr=input(' ');
    if(isr==1)
        disp(' ');
        nrb=input(' Enter the number of rigid-body modes ');
    end
end    
%
disp(' ');
disp(' Enter the frequency step ');
df=input(' ');
%
disp(' ');
disp(' Enter the minimum frequency for plots');
minf=input(' ');
%
disp(' ');
disp(' Enter the maximum frequency for plots');
maxf=input(' ');
%
if(maxf<=minf)
    maxf=100*minf;
end
%
nf=floor((maxf-minf)/df);
clear omega;
%
freq=zeros(nf,1);
omega=zeros(nf,1);
omega2=zeros(nf,1);
for i=1:nf
    freq(i)=(i-1)*df+minf;
    omega(i)=2*pi*freq(i);
    omega2(i)=(omega(i))^2;
end
%
clear omn;
omn=tpi*fnv;
omn2=omn.*omn;
%
sz=size(QE);
if(num_columns>sz(2))
    num_columns=sz(2);
end
%
disp(' ');
disp(' Select dof pair input method ');
disp('  1=manual  2=table ');
ipim=input(' ');
%
if(ipim==2)
    disp(' ');
    dof_pair_table=input(' Enter table name:  ');
    sz=size(dof_pair_table);
    mtable=1;
    if( (sz(1)+sz(2))>3)
        mtable=max(sz);
    end
end
%
disp(' ');
disp(' Display plots?  1=yes 2=no ');
impl=input(' ');
%
if(impl==1)
   disp(' ');
   fig_num=input(' Enter starting figure number ');
end
%
ikv=1;
while(1)
%
    if(ipim==1)
        disp(' ');
        if(iam<=3)
            i=input(' Enter response   dof ');
            k=input(' Enter excitation dof ');
        else
            i=input(' Enter response   dof ');
            k=input(' Enter base       dof ');            
        end
    else
        i=dof_pair_table(ikv,1);
        k=dof_pair_table(ikv,2);
    end
%
    [H_response_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
%
    if(iam ~=4)
        H=H_response_force;
    else
        [H_base_force]=...
        transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,k,k,nrb);
%
        for s=1:nf % frequency loop  
            H(s)=H_response_force(s)/H_base_force(s);
        end
%
    end
%
    HM=abs(H);
    HP=-atan2(imag(H),real(H))*180/pi;
%
%
    if(iam==3 && iu==1)
        HM=HM/386;
    end
%
    ijk=0;
%
    ijk=ijk+1;
    clear PPP;
    PPP=zeros(nf,1);
    PHA=zeros(nf,1);
%    
    for ia=1:nf
        PPP(ia)=HM(ia);
        PHA(ia)=HP(ia);
%
        while(PHA(ia)<0)
            PHA(ia)=PHA(ia)+360.;
        end
%
        ymax=max(PPP);
        ymin=min(PPP);
    end  
%
    freq=fix_size(freq);
    H=fix_size(H);
    HM=fix_size(HM);
    PPP=fix_size(PPP);       
    PHA=fix_size(PHA);
    AAA=angle(H);
%
    [varname1,varname2,varname3]=transfer_from_modes_H_files(iam,i,k,freq,H,HM);
% 
    disp(' ');
    disp(' Matlab array names ');

    disp(' ');
    eval([varname1 ' = [freq H];']);    % need to do in main script
    out1=sprintf('           Complex:  %s ',varname1);
    disp(out1);
%
    eval([varname2 ' = [freq PPP];']);
    out1=sprintf('         Magnitude:  %s ',varname2);
    disp(out1);
%
    eval([varname3 ' = [freq PPP AAA];']);
    out1=sprintf(' Magnitude & phase:  %s ',varname3);
    disp(out1);
%
    if(impl==1)
       [fig_num]=...
       transfer_from_modes_plots(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,PPP,PHA);    
    end
%
    if(ipim==1)
        disp(' ');
        disp(' Perform calculation for another pair ? ');
        disp(' 1=yes  2=no ');
        inc=input(' ');
        if(inc==2)
            break;
        end
    else
        ikv=ikv+1;
        if(ikv>mtable)
            break;
        end
    end
end
%
%  two_dof_sd_transfer_from_modes_function.m  ver 1.1  by Tom Irvine
%
function [fig_num]=two_dof_sd_transfer_from_modes_function(damp,omega,ModeShapes,fig_num,iu)
%
tpi=2*pi;
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
QE=ModeShapes;
num=max(size(QE));
fnv=omega/tpi;
dampv=damp;
%
num_modes=max(size(fnv));
%
num_columns=2;
%
nrb=0;  % Leave as zero     
%
disp(' ');
disp(' Enter the frequency step ');
df=input(' ');
%
minf=df;
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
dof_pair_table=[1 1; 1 2; 2 1; 2 2];
%
for ijk=1:4
%
    clear H_response_force;
    clear H_base_force;
%
    i=dof_pair_table(ijk,1);
    k=dof_pair_table(ijk,2);
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
    HP=(angle(H))*180/pi;
%
%
    if(iam==3 && iu==1)
        HM=HM/386;
    end
%
    clear PPP;
    PPP=zeros(nf,1);
    PHA=zeros(nf,1);
%    
    for ia=1:nf
        PPP(ia)=HM(ia);
        PHA(ia)=HP(ia);     
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
    
    varname1=regexprep(varname1,' ','');
    varname2=regexprep(varname2,' ','');
    varname3=regexprep(varname3,' ','');
% 
    disp(' ');
    disp(' Matlab array names ');

    disp(' ');
    eval([varname1 ' = [freq H];']);   
    out1=sprintf('           Complex:  %s ',varname1);
    disp(out1);
    assignin('base', varname1, [freq H]);
%
    eval([varname2 ' = [freq PPP];']);
    out1=sprintf('         Magnitude:  %s ',varname2);
    disp(out1);
    assignin('base', varname2, [freq PPP]);
%
    eval([varname3 ' = [freq PPP AAA];']);
    out1=sprintf(' Magnitude & phase:  %s ',varname3);
    disp(out1);
    assignin('base', varname3, [freq PPP AAA]);
%
    [fig_num]=...
    sd_transfer_from_modes_plots(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,PPP,PHA);    
%
end
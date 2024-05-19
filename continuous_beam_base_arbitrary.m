%
%  continuous_beam_base_arbitrary.m  ver 1.7  April 2, 2013
%
function[fig_num,acc_arb_resp,rv_arb_resp,rd_arb_resp,bm_arb_resp]=...
continuous_beam_base_arbitrary(iu,fn,damp,n,PF,ModeShape,ModeShape_dd,...
                                              E,I,sq_mass,beta,C,x,fig_num)
%
tpi=2*pi;
%
disp(' Select file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file ');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
end
if(file_choice==2)
        FS = input(' Enter the matrix name:  ','s');
        THM=evalin('caller',FS);
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
num_fn=length(fn);
%
t=THM(:,1);
abase=THM(:,2);
%
tmx=max(t);
tmi=min(t);
num_steps=length(t);
dt=(tmx-tmi)/(num_steps-1);
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
    disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
       rd=zeros(num_steps,1);
       rv=zeros(num_steps,1);
       ra=zeros(num_steps,1);
       bm=zeros(num_steps,1);
%
        nrd=zeros(num_steps,n);
        nrv=zeros(num_steps,n);
        nra=zeros(num_steps,n); 
       nbm=zeros(num_steps,n);
%
    [a1,a2,ra_b1,ra_b2,ra_b3,rv_b1,rv_b2,rv_b3,rd_b1,rd_b2,rd_b3]=...
                                      srs_coefficients_avd(fn,damp,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    omegan=tpi*fn;
%
    for j=1:num_fn
%
        if(abs(PF(j))>0)
%
            yp=-abase*PF(j);
%
            back   =[     1, -a1(j), -a2(j) ];
%
%   relative velocity
%
            clear forward;
            forward=[ rv_b1(j),  rv_b2(j),  rv_b3(j) ];    
            nrv(:,j)=filter(forward,back,yp);
%
%   relative displacement
%
            clear forward;
            forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];      
            nrd(:,j)=filter(forward,back,yp);
            nbm(:,j)=nrd(:,j);
%
%   relative acceleraiton
%
            clear forward;  
            forward=[ ra_b1(j),  ra_b2(j),  ra_b3(j) ];    
            nra(:,j)=filter(forward,back,yp);                
%
             arg=beta(j)*x;
              ZZ=ModeShape(arg,C(j),sq_mass);
            ZZdd=ModeShape_dd(arg,C(j),beta(j),sq_mass);
%
             rd(:)= rd(:) +ZZ*nrd(:,j);
             rv(:)= rv(:) +ZZ*nrv(:,j);
             ra(:)= ra(:) +ZZ*nra(:,j);
             bm(:)= bm(:) +ZZdd*nbm(:,j);            
%        
        end
    end
%
    bm=bm*E*I;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    if(iu==1)
        rd=rd*386;
        rv=rv*386;
        bm=bm*386;
    else
        rd=rd*9.81;
        rv=rv*9.81;
        bm=bm*9.81;      
    end
%
    acc=ra+abase;
%
    disp(' ');
    disp(' Peak Response Values ');
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
    if(iu==1)
        out2=sprintf('\n Relative Displacement = %8.4g in',max(abs(rd)));
        out4=sprintf('\n     Relative Velocity = %8.4g in/sec',max(abs(rv)));       
        out3=sprintf('\n        Bending Moment = %8.4g lbf-in',max(abs(bm)));       
    else
        out2=sprintf('\n Relative Displacement = %8.4g m',max(abs(rd)));
        out4=sprintf('\n     Relative Velocity = %8.4g m/sec',max(abs(rv)));        
        out3=sprintf('\n        Bending Moment = %8.4g N-m',max(abs(bm)));           
    end
%    
    disp(out2);
    disp(out4);
    disp(out1);
    disp(out3);
%
%%%
    sz=size(t);
    if(sz(2)>sz(1))
        t=t';
    end
%
    sz=size(acc);
    if(sz(2)>sz(1))
        acc=acc';
    end
%
    sz=size(rd);
    if(sz(2)>sz(1))
        rd=rd';
    end
%
    sz=size(rv);
    if(sz(2)>sz(1))
        rv=rv';
    end    
%%%
        acc_arb_resp=[t acc];
         rv_arb_resp=[t rv];
         rd_arb_resp=[t rd]; 
         bm_arb_resp=[t bm];
%%%
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc,t,abase);
    legend('response','input');  
%
    if(iu==1)
        out1=sprintf('Acceleration at %8.4g in',x);        
    else
        out1=sprintf('Acceleration at %8.4g m',x);
    end
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)'); 
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rv);  
%
    if(iu==1)
        out1=sprintf('Relative Velocity at %8.4g in',x);
        ylabel('Rel Vel (in/sec) ');       
    else
        out1=sprintf('Relative Velocity at %8.4g m',x);
        ylabel('Rel Vel (m/sec) ');   
    end
    title(out1);
    xlabel('Time(sec)'); 
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);  
%
    if(iu==1)
        out1=sprintf('Relative Displacement at %8.4g in',x);
        ylabel('Rel Disp (in) ');       
    else
        out1=sprintf('Relative Displacement at %8.4g m',x);
        ylabel('Rel Disp (m) ');   
    end
    title(out1);
    xlabel('Time(sec)'); 
    grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,bm);
%
    if(iu==1)
        out1=sprintf('Bending Moment at %8.4g in',x);        
        ylabel('Moment(lbf-in) ');
    else
        out1=sprintf('Bending Moment at %8.4g m',x); 
        ylabel('Moment Disp(N-m) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on;
%
%  plate_base_arbitrary.m  ver 1.5  April 9, 2013
%
function[fig_num,acc,rv,rd]=plate_base_arbitrary(h,a,b,mu,E,fn,damp,PF,...
                      num_nodes,Amn,pax,pby,x,y,m_index,n_index,fig_num,iu)
%
    clear length;
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
t=THM(:,1);
f=THM(:,2);
abase=f;
%
tmx=max(t);
tmi=min(t);
n = length(f);
num_steps=n;
dt=(tmx-tmi)/(n-1);
sr=1./dt;
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
    disp('*** Warning:  time step is not constant.***')
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
       rd=zeros(num_steps,1);
       rv=zeros(num_steps,1);
       ra=zeros(num_steps,1);
%
       sxx=zeros(num_steps,1);
       syy=zeros(num_steps,1);
       txy=zeros(num_steps,1);
%
        nrd=zeros(num_steps,num_nodes);
        nrv=zeros(num_steps,num_nodes);
        nra=zeros(num_steps,num_nodes); 
%
    [a1,a2,ra_b1,ra_b2,ra_b3,rv_b1,rv_b2,rv_b3,rd_b1,rd_b2,rd_b3]=...
                                      srs_coefficients_avd(fn,damp,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    fmax=sr/10;
%
    out1=sprintf('\n maximum frequency limit for modal transient analysis: fmax=%9.5g Hz \n',fmax);
    disp(out1);
%
    for j=1:length(PF)
%
        if(abs(PF(j))>0 && fn(j)<fmax)
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
%
            ZZ=Amn*sin(m_index(j)*pax)*sin(n_index(j)*pby);                 
%     
             rd(:)= rd(:) +ZZ*nrd(:,j);
             rv(:)= rv(:) +ZZ*nrv(:,j);             
             ra(:)= ra(:) +ZZ*nra(:,j); 
%
             ZZxx=-(pi*m_index(j)/a)^2*ZZ;
             ZZyy=-(pi*n_index(j)/b)^2*ZZ;
             ZZxy= (pi^2/(a*b))*m_index(j)*n_index(j)*Amn*cos(m_index(j)*pax)*cos(n_index(j)*pby);
%
             sxx(:)=sxx(:)+ (ZZxx+mu*ZZyy)*nrd(:,j);
             syy(:)=syy(:)+ (mu*ZZxx+ZZyy)*nrd(:,j);
             txy(:)=txy(:)+ ZZxy*nrd(:,j);
%
        end
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       
    acc=ra+abase;
%
    if(iu==1)
        rd=rd*386;
        rv=rv*386;
        sxx=sxx*386;
        syy=syy*386;
        txy=txy*386;
    else
        rd=rd*9.81*1000;
        rv=rv*9.81; 
        sxx=sxx*9.81;
        syy=syy*9.81;
        txy=txy*9.81;        
    end
%
    z=h/2;
    term1=-(E*z/(1-mu^2));    
    term2=-(E*z/(1+mu));
%
    sxx=sxx*term1;
    syy=syy*term1;
    txy=txy*term2;
%
    clear length;
    n=length(sxx);
    vM=zeros(n,1);
    for i=1:n
        vM(i)=sqrt( sxx(i)^2 + syy(i)^2 - sxx(i)*syy(i) + 3*txy(i)^2 );
    end
%
    disp(' ');
    disp(' Peak Response Values ');
    disp(' ');
    out1=sprintf('          Acceleration = %8.4g G',max(abs(acc)));
%   
    if(iu==1)
        out2=sprintf('     Relative Velocity = %8.4g in/sec',max(abs(rv)));          
        out3=sprintf(' Relative Displacement = %8.4g in',max(abs(rd)));  
        out4=sprintf('\n      von Mises Stress = %8.4g psi',max(abs(vM))); 
    else
        out2=sprintf('     Relative Velocity = %8.4g m/sec',max(abs(rv)));         
        out3=sprintf(' Relative Displacement = %8.4g mm',max(abs(rd)));
        out4=sprintf('\n      von Mises Stress = %8.4g Pa',max(abs(vM)));       
    end
%    
    disp(out1);
    disp(out2);
    disp(out3);
    disp(out4);   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rd);
%    
    if(iu==1)
        out1=sprintf(' Relative Displacement at x=%7.4g in  y=%7.4g in',x,y);
        ylabel('Rel Disp(in) ');
    else
        out1=sprintf(' Relative Displacement at x=%7.4g m  y=%7.4g m',x,y);
        ylabel('Rel Disp(m) ');
    end
    title(out1);
    xlabel('Time(sec)');
    grid on;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,rv);
%
    if(iu==1)
        out1=sprintf(' Relative Velocity at x=%7.4g in  y=%7.4g in',x,y);        
        ylabel('Rel Vel (in/sec) ');
    else
        out1=sprintf(' Relative Velocity at x=%7.4g m  y=%7.4g m',x,y);        
        ylabel('Rel Vel (m/sec) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on    
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,acc,t,abase);
%
    if(iu==1)
        out1=sprintf(' Acceleration at x=%7.4g in  y=%7.4g in',x,y);
    else
        out1=sprintf(' Acceleration at x=%7.4g m  y=%7.4g m',x,y);       
    end
    title(out1);
    ylabel('Accel(G) ');
    xlabel('Time(sec)');
    legend('response','input');  
    grid on;
%
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,sxx);
%
    if(iu==1)
        out1=sprintf(' Stress sxx at x=%7.4g in  y=%7.4g in',x,y);        
        ylabel('Stress(psi) ');
    else
        out1=sprintf(' Stress sxx at x=%7.4g m  y=%7.4g m',x,y);       
        ylabel('Stress(Pa) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on;
%
    figure(fig_num)
    fig_num=fig_num+1;
%
    plot(t,syy);
%
    if(iu==1)
        out1=sprintf(' Stress syy at x=%7.4g in  y=%7.4g in',x,y);        
        ylabel('Stress(psi) ');
    else
        out1=sprintf(' Stress syy at x=%7.4g m  y=%7.4g m',x,y);       
        ylabel('Stress(Pa) ');
    end
    title(out1);    
    xlabel('Time(sec)');
    grid on;    
%
t=fix_size(t);
acc=fix_size(acc);
rv=fix_size(rv);
rd=fix_size(rd);
%
acc=[t acc];
rv=[t rv];
rd=[t rd];
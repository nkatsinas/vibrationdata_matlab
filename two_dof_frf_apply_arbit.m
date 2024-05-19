function[fig_num]=two_dof_frf_apply_arbit(m,fn,omegan,omegad,damp,Q,fig_num,iu)
%
disp(' ');
disp(' Apply arbitrary base input pulse? ');
disp(' 1=yes  2=no ');
iarb = input(' ');
%
if(iarb==1)
%
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
    clear THM;
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
    clear base;
%
    iu=1;
    mass=m(1,1);
    ModeShapes=Q;
    MST=Q';
%
    disp(' ');
    disp(' The base input should have a constant time step ');
    disp(' ');
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
        THM = input(' Enter the matrix name:  ');
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
    base=THM(:,2);
    num=length(t);
    tt=t;
%
    dt=(t(num)-t(1))/(num-1);
%
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
ncontinue=1;
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant.  Continue calculation? 1=yes 2=no ')
    ncontinue=input(' ');
end
if(ncontinue==1)
%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(t,base);
    grid on;
    xlabel('Time(sec)');
    ylabel('Accel(G)');
    title('Base Input ');
%
    iu=1;
%
    iaxis=1;
% 
    nt=length(t);
%
    domegan=zeros(2,1);
%
    rd=zeros(nt,2);
    ra=zeros(nt,2);
%
    x=zeros(nt,2);
    a=zeros(nt,2);
%    
    acc=zeros(nt,2);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Digital Recursive Filtering Relationship Coefficients
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%
    for(i=1:2)
       domegan(i)=damp(i)*omegan(i);
 %      
       cosd(i)=cos(omegad(i)*dt);
       sind(i)=sin(omegad(i)*dt);
       domegadt(i)=domegan(i)*dt;
%
	   E=exp(-domegan(i)*dt);
	   K=omegad(i)*dt;
	   C=E*cos(K);
	   S=E*sin(K);
	   Sp=S/K;
%
	   a1(i)=2*C;
	   a2(i)=-E^2;
	   b1(i)=1.-Sp;
	   b2(i)=2.*(Sp-C);
	   b3(i)=E^2-Sp;
%%
       rd_a1(i)=2.*exp(-domegadt(i))*cosd(i); 
       rd_a2(i)=-exp(-2.*domegadt(i));
       rd_b1(i)=0.;
       rd_b2(i)=-(dt/omegad(i))*exp(-domegadt(i))*sind(i);
       rd_b3(i)=0;   
%%
    end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Acceleration Response
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%
    for(j=1:2)
%
        yy=MST(j,iaxis)*mass*base;
        yy=yy';
%
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        a(:,j)=filter(forward,back,yy);
%
        a(:,j)=a(:,j)-yy(:);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Relative Displacement Response
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
%
    for(j=1:2)
%
        yy=MST(j,iaxis)*mass*base;
        yy=yy';     
%
        rd_forward=[ rd_b1(j),  rd_b2(j),  rd_b3(j) ];    
        rd_back   =[     1, -rd_a1(j), -rd_a2(j) ];     
%    
        x(:,j)=filter(rd_forward,rd_back,yy);
%
    end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    for(i=1:nt) 
        rd(i,:)=Q(:,1:2)*x(i,1:2)';
        ra(i,:)=Q(:,1:2)*a(i,1:2)';  
%
        acc(i,:)=ra(i,:);
    end
%
    acc(:,iaxis)=acc(:,iaxis)+base;
%
    clear a;
    a=acc;
%
    if(iu==1)
            rd(:,1)=rd(:,1)*386;
            rd(:,2)=rd(:,2)*386;          
    end
%  
    for iv=1:2
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(tt,rd(:,iv));
        grid on; 
        xlabel('Time(sec)');
%
        out1=sprintf('Relative Displacement Response to Base Input Pulse');
        title(out1);
        if(iu==1)
            ylabel('Rel Disp(in)');
        else
            ylabel('Rel Disp(m)');    
        end
        if(iv==1)
           legend ('Mass 1 Response');   
        end
        if(iv==2)
           legend ('Mass 2 Response');   
        end
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(tt,a(:,iv));
        grid on;
        xlabel('Time(sec)');
%
        out1=sprintf('Acceleration Response to Base Input Pulse');
        title(out1);
        if(iu==1)
            ylabel('Accel(G)');
        else
            ylabel('Accel(m/sec^2)');    
        end 
        if(iv==1)
           legend ('Mass 1 Response');   
        end
        if(iv==2)
           legend ('Mass 2 Response');   
        end    
%
    end
%  
end
end
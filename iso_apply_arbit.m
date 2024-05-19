%
%   iso_apply_arbit.m  ver 1.2  October 10, 2012
%
function[fig_num]=iso_apply_arbit(m,fn,damp,ModeShapes,PF,fig_num)
%
disp(' ');
disp(' Apply arbitrary base input pulse? ');
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
    Q=ModeShapes;
    MST=ModeShapes';
%
    disp(' ');
    disp(' Enter input axis ');
    disp(' 1=X  2=Y  3=Z ');
    iaxis=input(' ');
    disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Digital Recursive Filtering Relationship 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    [a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                              srs_coefficients(fn,damp,dt);
%
    clear temp;
    temp=base;
    clear base;
    ntt=length(temp)+round((1.5/fn(1))/dt);
    base=zeros(ntt,1);
    base(1:length(temp))=temp;
%
    clear t;
    t=linspace(0,(ntt-1)*dt,ntt);
%
    nt=ntt;
%
    rd=zeros(nt,6);
    ra=zeros(nt,6);
%
    x=zeros(nt,6);
    a=zeros(nt,6);
%    
    acc=zeros(nt,6);
%
    for j=1:6
%
%   Acceleration Response
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
%   Relative Displacement Response   
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
    for i=1:nt 
        rd(i,:)=Q(:,1:6)*x(i,1:6)';
        ra(i,:)=Q(:,1:6)*a(i,1:6)';  
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
            rd(:,3)=rd(:,3)*386;            
    end
%
    for iv=1:3
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(t,rd(:,iv));
        grid on; 
        xlabel('Time(sec)');
        if(iaxis==1)
            out1=sprintf('Relative Displacement Response to X-axis Input Pulse');
        end  
        if(iaxis==2)
            out1=sprintf('Relative Displacement Response to Y-axis Input Pulse');
        end
         if(iaxis==3)
            out1=sprintf('Relative Displacement Response to Z-axis Input Pulse');
        end         
        title(out1);
        if(iu==1)
            ylabel('Rel Disp(in)');
        else
            ylabel('Rel Disp(m)');    
        end
        if(iv==1)
           legend ('X-axis Response');   
        end
        if(iv==2)
           legend ('Y-axis Response');   
        end
        if(iv==3)
           legend ('Z-axis Response');   
        end        
%
        figure(fig_num);
        fig_num=fig_num+1;
        plot(t,a(:,iv));
        grid on;
        xlabel('Time(sec)');
        if(iaxis==1)
            out1=sprintf('Acceleration Response to X-axis Input Pulse');
        end  
        if(iaxis==2)
            out1=sprintf('Acceleration Response to Y-axis Input Pulse');
        end
         if(iaxis==3)
            out1=sprintf('Acceleration Response to Z-axis Input Pulse');
        end         
        title(out1);
        if(iu==1)
            ylabel('Accel(G)');
        else
            ylabel('Accel(m/sec^2)');    
        end 
        if(iv==1)
           legend ('X-axis Response');   
        end
        if(iv==2)
           legend ('Y-axis Response');   
        end
        if(iv==3)
           legend ('Z-axis Response');   
        end        
%
    end
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
    end
%
        disp(' ');
        disp(' Perform another arbitrary base input case? ');
        disp(' 1=yes  2=no ');
        ian=input(' ');
        if(ian==2)
           break;
        end
    end
%
end
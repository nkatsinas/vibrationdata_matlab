disp(' ');
disp(' powertrans_from_modes.m   ver 1.2   September 21, 2012 ');
disp(' by Tom Irvine ');
%
disp(' ');
disp(' This program calculates a power transmissibility function (G^2/G^2) ');
disp(' for a given pair of degree-of-freedoms in a system based on the     ');
disp(' mode shapes, natural frequencies, and damping ratios.               ');
disp(' The transmissibility function is referenced to a force input node.  ');
%
clear freq;
clear fnv;
clear dampv;
clear QE;
clear H;
clear HM;
clear max;
clear TM;
clear PT;
clear PTM;
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
if(imethod==1)
    disp(' ');
        massm = input(' Enter the mass matrix name:  ');
        massm
    disp(' ');
    disp(' Divide mass by 386? ');
    disp(' 1=yes 2=no ');
    idm=input(' ');
    if(idm==1)
        massm=massm/386;
        massm
    end
    m=massm;
    disp(' ');
    stiffness = input(' Enter the stiffness matrix name:  ');
    stiffness
%
    sz=size(massm);
    num=max(sz);
    num_columns=sz(2);
%
    [fnv,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,massm,1);
%
    QE=ModeShapes;
else
    disp(' ');
    disp(' Enter the name of the massm-normalized eigenvector matrix ');
    QE=input(' ');
    num=max(size(QE));
%
    disp(' ');
    disp(' Enter the natural frequency (Hz) vector or matrix ');
    clear fff;
    fff=input(' ');
    sz=size(fff);
    if(sz(1)==sz(2))
        for(i=1:sz(1))
            fnv(i)=fff(i,i);
        end
    else
        fnv=fff;
    end
end
%
[dampv]=enter_modal_damping(num);
%
disp(' ');
disp(' Enter the frequency step ');
df=input(' ');
%
disp(' ');
disp(' Enter the maximum frequency ');
maxf=input(' ');
%
disp(' ');
disp(' Enter the minimum frequency for plots');
minf=input(' ');
%
nf=round(maxf/df);
freq=zeros(nf,1);
omega=zeros(nf,1);
omega2=zeros(nf,1);
for i=1:nf
    freq(i)=i*df;
    omega(i)=2*pi*freq(i);
    omega2(i)=(omega(i))^2;
end
%
clear omn;
omn=tpi*fnv;
omn2=omn.*omn;
%
%
disp(' ');
i=input(' Enter response dof ');
j=input(' Enter base     dof ');
k=input(' Enter force    dof ');
%
iam=3;
%
    [H_response_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k);
%
    [H_base_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,j,k);
%
%
HM_response_force=abs(H_response_force);
HM_base_force=abs(H_base_force);
%
for s=1:nf % frequency loop  
    TM(s)=HM_response_force(s)/HM_base_force(s);
    PT(s)=(TM(s))^2;
end
%
PTM=[freq PT'];
figure(1);
plot(freq,PT);
out1=sprintf('Power Transmissibility (dof %d/dof %d) with Force at dof %d ',i,j,k);
title(out1);
xlabel('Frequency(Hz)');
ylabel('Trans(G^2/G^2)');
grid on;
ymax=max(PT);
ymin=min(PT);
%
ymax=10^(ceil(0.1+log10(ymax)));
%
ymin=10^(floor(log10(ymin)));
%
if(ymin<ymax*0.0001)
     ymin=ymax*0.0001;
end
%
axis([minf,maxf,ymin,ymax]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
%
disp(' ');
disp(' The power transmissibility matix name is PTM.');
%%
choice=input(' Export as txt file?  1=yes  2=no  ' );
disp(' ')
%
if choice == 1 
       [writefname, writepname] = uiputfile('*','Save data as');
	   writepfname = fullfile(writepname, writefname);
	   writedata = [PTM(:,1) PTM(:,2) ];
	   fid = fopen(writepfname,'w');
	   fprintf(fid,'  %g  %g\n',writedata');
	   fclose(fid);
end
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
disp(' ');
disp(' Multiply the power transmissibility function by an input PSD?');
disp('  1=yes  2=no ');
ium=input(' ');
if(ium==1)
%
    yone=double(PTM(:,2));
    xone=double(PTM(:,1));
%
    out1=sprintf(' Select file input method for the PSD at node dof %d',base_node);
    disp(out1);
    disp('   1=external ASCII file ');
    disp('   2=file preloaded into Matlab ');
    file_choice = input('');
%
    if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
    else
        THM = input(' Enter the matrix name:  ');
    end
%
    clear ytwo;
    clear xtwo;
    clear a1;
    clear f1;
    ytwo=double(THM(:,2));
    xtwo=double(THM(:,1));
%
    f1=xone;
    a1=yone;
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%    Q2 = real_mult_intlog(xone,ytwo,df);
    clear xi;
    clear yi;
    clear xL;
    clear yL;
    clear xiL;
    clear yiL;
%
    xi=min(xone):df:max(xone); 
%
    xL=log10(xtwo);
    yL=log10(ytwo);
    xiL=log10(xi);
%
    disp('ref 1');
    yiL = interp1(xL,yL,xiL);
%
    for(i=1:max(size(xi)))
        xi(i)=10^xiL(i);
        yi(i)=10^yiL(i);
    end
%   
    disp('ref 2');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear a2;
    clear f2;
    ijk=1;
    for i=1:max(size(yi))
       if(yi(i)>=-1.0e-30 && yi(i)<=1.0e+30)
          f2(ijk)=xi(i); 
          a2(ijk)=yi(i);
          ijk=ijk+1;
       end
    end
%
    df2=df/2;
%
    clear ab;
    clear ff;
%
    disp('ref 3');
%
    ijk=1;
    for i=1:max(size(f1))
        for j=1:max(size(f2))
            if(abs(f1(i)-f2(j))<df2)
                ab(ijk)=a1(i)*a2(j);
                ff(ijk)=(f1(i)+f2(j))/2.;
                ijk=ijk+1;
                break;
            end
        end
    end    
%
    area=df*sum(ab);
    grms=sqrt(area);
%
    area=df*sum(a2);
    grms_in=sqrt(area);    
%
    disp(' See figure(2) ');
%
    figure(2);
    plot(f2,a2,'r',ff,ab,'b');
    out1=sprintf('PSD  dof %d  overall level=%6.3g GRMS',response_node,grms);
    title(out1);
    out1=sprintf(' Input %6.3g GRMS',grms_in);  
    out2=sprintf('Response %6.3g GRMS',grms);   
    legend (out1,out2);      
    ylabel('Accel(G^2/Hz)');
    xlabel('Frequency(Hz)');
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log','XminorTick','on','YminorTick','on');
    grid('on');
%
    disp(' ');
    choice=input(' Export output PSD as txt file?  1=yes  2=no  ' );
    disp(' ')
%
    if choice == 1 
       [writefname, writepname] = uiputfile('*','Save data as');
	   writepfname = fullfile(writepname, writefname);
	   writedata = [ff' ab' ];
	   fid = fopen(writepfname,'w');
	   fprintf(fid,'  %g  %g\n',writedata');
	   fclose(fid);
    end
end
disp(' ');
disp(' plate_fea.m   ver 1.6   August 31, 2012');
disp('  ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp(' ');
%
disp(' This program calculates the bending natural frequencies of a ');
disp(' flat, thin, plate via the finite element method. ');
disp(' ');
disp(' Rectangular elements are used. The elements must be aligned ');
disp(' with the x-y coordinate system. ');
%
close all hidden;
%
clear mass;
clear stiff;
clear fn;
clear omega;
clear ModeShapes;
clear MST;
%
fig_num=1;
%
iu=1;
%
[E,rho,mu]=materials(iu);
%
disp(' ');
disp(' Enter uniform nonstructural mass? '); 
disp(' 1=yes 2=no ');
%
amass=0;
tmass=0;
ins=input(' ');
if(ins==1)
    disp(' ');
    disp(' Select method '); 
    disp(' 1= Add mass   ');
    disp(' 2= Specify total mass'); 
    imeth=input(' ');
    disp(' ');
    if(imeth==1)
       amass=input(' Enter added mass(lbm) ');
       amass=amass/386;
    else
       tmass=input(' Enter total mass(lbm) ');
       tmass=tmass/386;
    end
end
%
beta=2*(1-mu);
%
disp(' ');
disp(' Enter thickness (inch) ');
thick=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear nodex;
clear nodey;
clear node1;
clear node2;
clear node3;
clear node4;
%
disp(' ');
disp(' The node coordinate matrix must have two columns:  x(inch)  y(inch) ');
disp(' ');
clear THM;
THM = input(' Enter the node coordinate matrix name:  ');
%
sz=size(THM);
dof=3*sz(1);
number_nodes=sz(1);
%
nodex=THM(:,1);
nodey=THM(:,2);
%
hold off;
figure(fig_num);
fig_num=fig_num+1;
plot(nodex,nodey,'.');
for(i=1:number_nodes)
   string=num2str(i,'%d\n');
   text(nodex(i),nodey(i),string);
end
xlabel('X');
ylabel('Y');
grid on;
%
max_ux=max(nodex);
max_uy=max(nodey);
%
min_ux=min(nodex);
min_uy=min(nodey);
%
ux=max_ux-min_ux;
uy=max_uy-min_uy;
%
avex=(max_ux+min_ux)/2;
avey=(max_uy+min_uy)/2;
%
ddd=[ux,uy];
dmax=max(ddd);
dmax=dmax*1.2;
%
xmin=avex-dmax/2;
xmax=avex+dmax/2;
ymin=avey-dmax/2;
ymax=avey+dmax/2;
%
axis([xmin,xmax,ymin,ymax]);
hold on;
%
disp(' ');
disp(' The element connectivity matrix must have four columns ');
disp('   node 1   node 2   node 3   node 4 ');
disp(' ');
clear THM;
THM = input(' Enter the element connectivity matrix name:  ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
sz=size(THM);
nelem=sz(1);
%
node1=THM(:,1);
node2=THM(:,2);
node3=THM(:,3);
node4=THM(:,4);
%
%  element check
%
tol=1.0e-08;
%
for(i=1:nelem)
    iflag=0;
    if( abs( nodex(node1(i))-nodex(node4(i)) ) > tol )
        iflag=1;
    end
    if( abs( nodex(node2(i))-nodex(node3(i)) ) > tol )
        iflag=1;        
    end
    if( abs( nodey(node1(i))-nodey(node2(i)) ) > tol )
        iflag=1;        
    end
    if( abs( nodey(node3(i))-nodey(node4(i)) ) > tol )
        iflag=1;        
    end    
    if(iflag==1)
        out1=sprintf(' Element error:  %d',i);
        disp(out1);
    end
end
%
for(i=1:nelem)
    x=[ nodex(node1(i))  nodex(node2(i))  nodex(node3(i))  nodex(node4(i)) nodex(node1(i)) ];
    y=[ nodey(node1(i))  nodey(node2(i))  nodey(node3(i))  nodey(node4(i)) nodey(node1(i)) ];
    plot(x,y);
    hold on;
end
hold off;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' Unconstrained model statistics ');
out1=sprintf('\n  nodes=%d  elements=%d   degrees-of-freedom=%d  \n',number_nodes,nelem,dof);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
mass=zeros(dof,dof);
stiff=zeros(dof,dof);
total_volume=0;
%
progressbar;
%
for(ijk=1:nelem)
%
    progressbar(ijk/nelem);
%
    [mass_local,stiff_local,area]=plate_mass_stiff(nodex,nodey,node1,node2,node3,node4,mu,beta,ijk);
%
    total_volume=total_volume+area*thick;
%
    n1=(3*node1(ijk))-2;
    n2=(3*node2(ijk))-2;
    n3=(3*node3(ijk))-2;
    n4=(3*node4(ijk))-2;
%
    pr=[n1 n1+1 n1+2  n2 n2+1 n2+2  n3 n3+1 n3+2  n4 n4+1 n4+2  ];
    pc=pr;       
%
    for(i=1:12)
        for(j=1:12)
             mass(pr(i),pc(j))= mass(pr(i),pc(j))+mass_local(i,j);            
            stiff(pr(i),pc(j))=stiff(pr(i),pc(j))+stiff_local(i,j);
        end
    end
%
end
%
progressbar(1);
%
D=E*(thick^3)/(12*(1-mu^2)); 
%
clear stiff_as;
clear mass_as;
%
stiff=stiff*D;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
volume=total_volume;
%
rho_s=rho;
if(ins==1)
%%%     disp(' 1= Add mass   ');
%%%     disp(' 2= Specify total mass'); 
    if(imeth==1)
%%%       amass=input(' Enter added mass(lbm) ');
          rho=rho_s+(amass/volume);
    else
%%%       tmass=input(' Enter total mass(lbm) ');
          rho=tmass/volume;
    end
end
%
disp(' ');
total_mass=386*rho*volume;
out1 = sprintf(' structural mass    = %8.4g lbm',386*(rho_s*volume));
out2 = sprintf(' nonstructural mass = %8.4g lbm',386*(rho-rho_s)*volume);
out3 = sprintf(' total mass         = %8.4g lbm \n',total_mass);
out4 = sprintf(' volume = %8.4g in^3  \n',volume);
disp(out1);
disp(out2);
disp(out3);
disp(out4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mass=mass*rho*thick;
%
clear mass_unc;
clear stiff_unc;
%
mass_unc=mass;
stiff_unc=stiff;
%
%  Need to apply BCs
%
disp('   ');
disp(' Apply boundary conditions?  1=yes  2=no ');
ibc=input(' ');
%
if(ibc==1)
    disp(' ');
    disp(' The constraint matrix must have three four columns:  node number   TZ RX RY ');
    disp(' A value of 1 indicates a constraint.  A value of 0 indicates free. ');
    disp(' ');
    clear THM;
    THM = input(' Enter constraint matrix name.  ');
%
    sz = size(THM);
    nc=sz(1);
%
    clear con;
    ij=1;
%
    progressbar;
    for(i=1:nc)
        progressbar(i/nc);
%        
        nodec=THM(i,1);
%        
        if(THM(i,2)==1)
           con(ij)=3*nodec-2;
           ij=ij+1;
        end
%        
        if(THM(i,3)==1)
           con(ij)=3*nodec-1;
           ij=ij+1;
        end
%     
        if(THM(i,4)==1)
           con(ij)=3*nodec;
           ij=ij+1;
        end       
%
    end
    progressbar(1);
%
    clear length;
    pp=length(con);
    con=con';
    con=sort(con,1,'descend');
    con;
%
    progressbar;
    for(ij=1:pp)
        progressbar(ij/pp);
%        
         k=con(ij);
         sz=size(mass);
%%         out1=sprintf(' k=%d   %d %d',k,sz(1),sz(2));
%%         disp(out1);
         mass(:,k)=[];
         mass(k,:)=[];
        stiff(:,k)=[];
        stiff(k,:)=[];        
%
    end
    progressbar(1);
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Does the system have rigid-body modes? ');
disp(' 1=yes  2=no ');
isd=input(' ');
%
disp(' ');
disp(' Calculating eigenvalues... ');
%
pause(1);  % need for previous message display
%
tic

stiffc=stiff;
massc=mass;

if(isd==2)
    [fn,omega,ModeShapes,MST]=Generalized_Eigen(stiff,mass,2);
else
    [fn,omega,ModeShapes,MST]=Generalized_Eigen_semidefinite(stiff,mass,2);
end
%
mstore=mass;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ijk=1;
if(ibc==1)
%
    clear newModes;
    ncc=dof-pp;
    newModes=zeros(dof,ncc);
%
    for(i=1:dof)
%
        iflag=0;
        for(ij=1:pp)
             k=con(ij);
             if(k==i)
                 iflag=9;
                 break;
             end
        end
%        
       if(iflag==0)
          newModes(i,1:ncc)=ModeShapes(ijk,1:ncc);
          ijk=ijk+1;
       else
          newModes(i,1:ncc)=0;           
       end
%    
    end
%
    clear ModeShapes;
    ModeShapes=newModes;    
end 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
mode=ModeShapes;
%
clear mass;
mass=mass_unc;
%
v=ones(dof,1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  The accuracy decreases with mode number.
%
icmc=2;
if(icmc==2)
    LM=mode'*mass*v;
    pf=LM;
    sum=0;
%    
    mmm=mode'*mass*mode;   
%  
    clear length;
    nndd=length(pf);
    for i=1:nndd
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        if(emm(i) < 1e-30)
            emm(i)=0.;
            pff(i)=0.;
        end    
%
        sum=sum+emm(i);
    end
end
%
pdof=length(emm);
if(pdof>40)
    pdof=40;
end
%
disp(' ');
disp('           Natural     Participation     Effective     Mass     ');
disp('Mode       Freq(Hz)       Factor         Modal Mass    Fraction ');
%    
for i=1:pdof
    frac=386*emm(i)/total_mass;
    if(frac<0.0001)
        frac=0;
    end
    out1 = sprintf('  %d \t %11.5g \t %10.4g \t %10.4g \t %7.3g',i,fn(i),pff(i),emm(i),frac);
    disp(out1)
end   

%
disp(' ')
out1 = sprintf(' Total Effective Modal Mass = %10.4g lbf sec^2/in',sum );
out2 = sprintf('                            = %10.4g lbm',sum*386 );
disp(out1)
disp(out2)
%
disp(' ');
disp(' Eigenvalue calculation time');
toc
%
disp(' ');
disp(' Plot modes shapes?  1=yes  2=no ');
ips=input(' ');
%
disp(' ');
disp(' Note that the plotting elements are triangular ');
disp(' even though the FEA model elements are rectangular. ');
%
if(ips==1)
    clear aaa;
    clear abc;
    abc=zeros(number_nodes,2);
    abc=[ nodex  nodey ];
    aaa=max(abc);
    xmin=-aaa;
    ymin=-aaa;
    xmax=aaa;
    ymax=aaa;
end    
while(ips==1)
    clear zzr;
    zzr=zeros(number_nodes,1);
    disp(' ');
    mode_num=input(' Enter mode number ');
%
    figure(fig_num);
    fig_num=fig_num+1;
%    
    for(i=1:number_nodes)
        ndof=3*i-2;
        zzr(i)=ModeShapes(ndof,mode_num);
    end
%
    zmax=max(zzr);
    zmin=min(zzr);   
%    
    tri = delaunay ( nodex, nodey );
    trisurf ( tri, nodex, nodey, zzr );
%
    out1=sprintf(' Mode %d   fn=%8.4g Hz',mode_num,fn(mode_num));
    title(out1);
    grid on;
%    
    disp(' ');
    disp(' Plot another mode?  1=yes  2=no ');
    iam=input(' ');
    if(iam==2)
        break;
    end
%
end
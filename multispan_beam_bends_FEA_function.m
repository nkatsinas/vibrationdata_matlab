%
%  multispan_beam_bends_FEA_function.m  ver  1.1 by Tom Irvine
%
%  This script calculates the natural frequencies & mass-normalized 
%  mode shapes for a multispan beam with optional bends via the 
%  finite element method
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables:
%
%          E=elastic modulus psi
%         mu=Poisson ratio
%        rho=mass density (lbm/in^3)
%        nsm=nonstructural mass (lbm);
%       area=cross section area (in^2)
%          I=area moment of inertia (in^4)
%     
%     LBC,RBC=left & right boundary conditions:
%             1=free
%             2=pinned
%             3=fixed
%
%%%%%%%%%%%%%
%
%    straight_sections - 2D array
%
%       number of rows = number of straight sections
%       five columns with x & y locations (inch)
%
%       col 1= x1 
%       col 2= y1 
%       col 3= x2
%       col 4= y2
%       col 5= number of elements per each straight section
%
%   Reference beam configurations per number of rows: 
%
%        1=Straight
%        2=Straight-Bend-Straight
%        3=Straight-Bend-Straight-Bend-Straight
%        4=Straight-Bend-Straight-Bend-Straight-Bend-Straight
%
%   ns_elem - 1D array with number of rows equal to number of bends
%        The number of rows must be equal to the number of straight
%        sections minus one.
%        The values in thew rows are the number of elements in each bend.   
%
%%%%%%%%%%%%%
%
%    intermediate_pinned - 2D array with x & y locations (inch) of internal 
%                          pinned constraints.  
%                          The script will find the nearest node.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Reference equations by cross-section not included in the script
%
%    Pipe
%       area=pi*(diameter^2-ID^2)/4;
%       I=pi*(diameter^4-ID^4)/64;
%  
%    Solid Cylinder
%       area=pi*diameter^2/4;
%       I=pi*diameter^4/64; 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%     Output arrays:
%         
%                     fn=natural frequencies (Hz)
%             ModeShapes=mass-normalized eigenvectors in column format
%
%                     xx= 2D array - X & Y coordinates (inch) with each
%                         row representing a node number
%
%             Mass,Stiff=constrained global mass & stiffness matrices
%     mass_unc,stiff_unc=unconstrained global mass & stiffness matrices
%
%                   cdof= 1D array containing constrained dof numbers
%
%      nodex,nodey,nodez= location (inch) for each node
%            node1,node2= 1D arrays with rows representing element numbers
%                         and values corresponding to nodes by elements.
%                         node1 and nodes are starting and ending nodes, 
%                         respectively
%
%                    LEN= 1D array with length (inch) for each element
%
%                   theta= 1D array with angle (rad) about Z-axis for each
%                          element
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    External functions called:
%
%          beam_3d_mass_stiffness_matrices
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[fn,ModeShapes,xx,Stiff,Mass,stiff_unc,mass_unc,cdof,nodex,nodey,nodez,node1,node2,LEN,theta]=...
   multispan_beam_bends_FEA_function(E,mu,rho,nsm,area,I,LBC,RBC,straight_sections,ns_elem,intermediate_pinned)
 
try
    [xx,total_ne,L,cdof,jflag]=display_function(LBC,RBC,straight_sections,ns_elem,intermediate_pinned);
catch
   disp('display function failed');
   return;
end

if(jflag==1)
    return;
end

G=E/(2*(1+mu)); % shear modulus

Iyy=I;
Izz=Iyy;
J=Iyy+Izz; % polar moment of inertia via perpendicular axis theorem

rho=rho/386;
nsm=nsm/386;

mass_per_length=rho*area+(nsm/L);   % mass per unit length
    
tmass=mass_per_length*L;
   
fprintf('\n Total mass = %8.4g lbm \n',tmass*386);

rho=tmass/(area*L);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_nodes=length(xx(:,1));

nodex=xx(:,1);
nodey=xx(:,2);
nodez=zeros(num_nodes,1);

%
disp(' ');
disp('       Node Table ');
disp(' Number     X       Y  ');
%
for i=1:length(nodex)
    fprintf(' %4d  %8.3f  %8.3f \n',i,nodex(i),nodey(i));
end

% element table

node1=zeros(total_ne,1);
node2=zeros(total_ne,2);

for i=1:num_nodes-1
    node1(i)=i;
    node2(i)=i+1;
end
    
enum=length(node1);
%
disp(' ');
disp('       Element Table ');
disp('   Number    N1    N2   Length');
%
LEN=zeros(enum,1);

for i=1:enum
    dx=nodex(node1(i))-nodex(node2(i));
    dy=nodey(node1(i))-nodey(node2(i));
    dz=nodez(node1(i))-nodez(node2(i));
    LEN(i)=sqrt(dx^2+dy^2+dz^2);
    fprintf('    %4d   %4d    %4d  %7.3f \n',i,node1(i),node2(i),LEN(i));
end

A=area;

ndof=num_nodes*6;

% Calculate unconstrained global mass & stiffness matrices

[Mass,Stiff,theta]=mass_stiffness_matrices(enum,ndof,LEN,rho,E,G,Iyy,Izz,J,A,nodex,nodey,nodez,node1,node2);

stiff_unc=Stiff;
 mass_unc=Mass;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    cdof=unique(cdof);
    cdof=sort(cdof);
    temp=cdof(end:-1:1);
    cdof=temp;
    num_con=length(cdof);
 
%
%   Apply constraints to global matrices
%
    for i=1:num_con
        Stiff(cdof(i),:)=[];
        Stiff(:,cdof(i))=[];
        Mass(cdof(i),:)=[];
        Mass(:,cdof(i))=[];
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Solve the generalized eigenvalue problem

[fn,~,ModeShapes,~]=Generalized_Eigen(Stiff,Mass,2);

fn=abs(fn);

NJ=min([20 length(fn)]);

disp(' ');
disp('Mode   fn(Hz)');

for i=1:NJ
    fprintf(' %d  %8.4g \n',i,fn(i));
end    

fprintf('\n\n Calculation complete \n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[xx,total_ne,L,cdof,jflag]=display_function(LBC,RBC,straight_sections,nb_elem,intermediate_pinned)
                                                   
jflag=0;

sz=size(straight_sections);

N=sz(1);

x1=straight_sections(:,1);
y1=straight_sections(:,2);
x2=straight_sections(:,3);
y2=straight_sections(:,4);
ns_elem=straight_sections(:,5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(N==1)
   NB=0;
else
    sz=size(nb_elem);
   NB=sz(1);
end

if(NB~=N-1)
    disp(' Error: Number of bends must be one less than number of straight sections. ');
    jflag=1;
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(intermediate_pinned);

numi=sz(1);

xp=intermediate_pinned(:,1);
yp=intermediate_pinned(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% N=1 straight
% N=2 straight-bend-straight
% N=3 straight-bend-straight-bend-straight
% N=4 straight-bend-straight-bend-straight-bend-straight

total_ne=sum(ns_elem)+sum(nb_elem);

xx=zeros((total_ne+1),2);

k=1;
L=0;

try
    [k,L,xx]=straight(k,L,xx,x1,x2,y1,y2,ns_elem,1);  % straight 1
catch
    disp('straight failed');
    return;
end

for i=2:N
    
    try
   
        [k,L,xx,kflag]=bend(k,L,xx,x1,x2,y1,y2,nb_elem(i-1),i-1);

        if(kflag==1)
            warndlg('kflag=1');
            return;
        end
    catch
        warndlg(' bend error ');
        return;
    end

    [k,L,xx]=straight(k,L,xx,x1,x2,y1,y2,ns_elem,i);
    
    if(kflag==1)
        jflag=1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num_nodes=length(xx);

%   Value=0 for fixed
%         1 for free

pinned_node=zeros(numi,1);

nL=0;
nR=0;

% Left boundary condition

if(LBC==2)
   nL=3;
end
if(LBC==3)
   nL=6;
end

% Right boundary condition

if(RBC==2)
   nR=3;
end
if(RBC==3)
   nR=6;
end

tnc=(3*numi)+nL+nR;

cdof=zeros(tnc,1);

k=1;

% Left BC

if(LBC>=2)
    ncon=1;
    cdof(k)=ncon*6-5;
    k=k+1;
    cdof(k)=ncon*6-4;
    k=k+1;    
    cdof(k)=ncon*6-3;
    k=k+1;
    
    if(LBC==3)
        cdof(k)=ncon*6-2;
        k=k+1;
        cdof(k)=ncon*6-1;
        k=k+1;    
        cdof(k)=ncon*6;
        k=k+1;        
    end    
end

% Right BC

if(RBC>=2)
    ncon=num_nodes;
    cdof(k)=ncon*6-5;
    k=k+1;
    cdof(k)=ncon*6-4;
    k=k+1;    
    cdof(k)=ncon*6-3;
    k=k+1;  

    if(RBC==3)
        cdof(k)=ncon*6-2;
        k=k+1;
        cdof(k)=ncon*6-1;
        k=k+1;    
        cdof(k)=ncon*6;
        k=k+1;        
    end    
end


fprintf('\n numi=%d  num_nodes=%d \n',numi,num_nodes);

% Intermediate Pinned
for i=1:numi
    
    D=zeros(num_nodes,1);
    
    for j=1:num_nodes
        D(j)=norm([ xx(j,1)-xp(i) , xx(j,2)-yp(i) ]);
    end
    
    [~,I] = min(D);
    
    pinned_node(i)=I;
    ncon=I;
    
    cdof(k)=ncon*6-5;
    k=k+1;
    cdof(k)=ncon*6-4;
    k=k+1;    
    cdof(k)=ncon*6-3;
    k=k+1;
end


cdof=unique(sort(cdof));
setappdata(0,'cdof',cdof);

dof_status=ones(num_nodes,6);
% 0 fixed
% 1 free

k=1;

for i=1:num_nodes
    for j=1:6
        if(ismember(k,cdof))
%            fprintf(' i=%d j=%d k=%d \n',i,j,k);
            dof_status(i,j)=0;
        end
        k=k+1;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    
    figure(1)
    hold on
    plot(xx(:,1),xx(:,2),xx(:,1),xx(:,2),'o','MarkerSize',3);
    for i=1:numi
        j=pinned_node(i);
        plot(xx(j,1),xx(j,2),'kx','MarkerSize',10);    
    end
    if(LBC==2)
        plot(xx(1,1),xx(1,2),'kx','MarkerSize',10);
    end
    if(LBC==3)
        plot(xx(1,1),xx(1,2),'k*','MarkerSize',10);    
    end
    if(RBC==2)
        plot(xx(end,1),xx(end,2),'kx','MarkerSize',10);
    end
    if(RBC==3)
        plot(xx(end,1),xx(end,2),'k*','MarkerSize',10);    
    end
    grid on;
    xlabel('X (in)');
    ylabel('Y (in)');
    title('Elements, Nodes & Constraints  (x Pinned, * fixed)');
    hold off;
catch
    disp('plot failed');
end

fprintf('\n  total elements=%d  total nodes=%d \n',total_ne,num_nodes);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[k,L,xx]=straight(k,L,xx,x1,x2,y1,y2,ns_elem,j)

    ne=ns_elem(j);
    deltax=x2(j)-x1(j);
    deltay=y2(j)-y1(j);
    dx=deltax/ne;
    dy=deltay/ne;
    
    L=L+norm([ deltax,deltay]);    
    
    xx(k,:)=[ x1(j) y1(j) ];
    k=k+1;
    
    for i=2:(ne+1)
        xx(k,1)=xx(k-1,1)+dx;
        xx(k,2)=xx(k-1,2)+dy;
        k=k+1;
    end
    

function[Mass,Stiff,theta]=mass_stiffness_matrices(enum,ndof,LEN,rho,E,G,Iyy,Izz,J,A,nodex,nodey,nodez,node1,node2)

% Calculate local mass & stiffness matrices

[mlocal,klocal]=beam_3d_mass_stiffness_matrices(enum,LEN,rho,E,G,Iyy,Izz,J,A);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Coordinate transformations of local matrices into X,Y,Z system
%
theta=zeros(enum,1);

for k=1:enum
%
     xi=nodex(node1(k));
     xj=nodex(node2(k));
     yi=nodey(node1(k));
     yj=nodey(node2(k));     

%
    dy=yj-yi;
    dx=xj-xi;

    theta(k)=atan2(dy,dx);  

    try
        R=rotz(-theta(k)*180/pi);
    catch
        warndlg('rotz error');
        return;
    end
    T=zeros(12,12);
    T(1:3,1:3)=R;
    T(4:6,4:6)=R;
    T(7:9,7:9)=R;
    T(10:12,10:12)=R;
%
     clear ml;
     clear kl;
     ml((1:12),(1:12))=mlocal(k,(1:12),(1:12));
     kl((1:12),(1:12))=klocal(k,(1:12),(1:12));
%
     mlocal_ct=T'*ml*T;
     klocal_ct=T'*kl*T;
% 
     mct(k,(1:12),(1:12))=mlocal_ct;
     kct(k,(1:12),(1:12))=klocal_ct;
%    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Assembly global mass & stiffness
%

Mass=zeros(ndof,ndof);
Stiff=zeros(ndof,ndof);

for k=1:enum
     clear TT;
     TT=zeros(12,ndof);
%     
     dof=node1(k)*6-5;
     for i=1:6
       TT(i,dof)=1;
       dof=dof+1;
     end
%     
     dof=node2(k)*6-5;
     for i=7:12
       TT(i,dof)=1; 
       dof=dof+1;       
     end
%
     clear mlocal_ct;
     clear klocal_ct;
     mlocal_ct((1:12),(1:12))=mct(k,(1:12),(1:12));
     klocal_ct((1:12),(1:12))=kct(k,(1:12),(1:12));
%
     Mass=Mass +TT'*mlocal_ct*TT;
    Stiff=Stiff+TT'*klocal_ct*TT;
end
%
function[k,L,xx,kflag]=bend(k,L,xx,x1,x2,y1,y2,nb_elem,j)
    
    kflag=0;
    
    x1o=x1;
    x2o=x2;
    y1o=y1;
    y2o=y2;

    [s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j);
    
    if(abs(deltax1)>0 && abs(deltax2)>0)
        [k,L,xx,kflag]=bend_spline(k,L,xx,nb_elem,j,s1,s2,ya,yb,xa,xb);
    else
   
        alpha=-45;        
        
        Q1=rotz(alpha)*[x1o y1o x1o*0]';
        x1=Q1(1,:);
        y1=Q1(2,:)';
        
        Q2=rotz(alpha)*[x2o y2o x2o*0]';
        x2=Q2(1,:);
        y2=Q2(2,:); 
        
        [s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j);
        
        if(abs(deltax1)<1.0e-04 || abs(deltax2)<1.0e-04)
            
            alpha=-30;        
        
            Q1=rotz(alpha)*[x1o y1o x1*0]';
            x1=Q1(1,:);
            y1=Q1(2,:)';
        
            Q2=rotz(alpha)*[x2o y2o x2*0]';
            x2=Q2(1,:);
            y2=Q2(2,:); 
            
            [s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j);
        end
       
        Qx=rotz(alpha)*[xx(:,1) xx(:,2) xx(:,1)*0]';
        xx(:,1)=Qx(1,:)';
        xx(:,2)=Qx(2,:)';         
                            
        [k,L,xx,kflag]=bend_spline(k,L,xx,nb_elem,j,s1,s2,ya,yb,xa,xb);

        Qx=rotz(-alpha)*[xx(:,1) xx(:,2) xx(:,1)*0]';
        xx(:,1)=Qx(1,:)';
        xx(:,2)=Qx(2,:)';           
        
    end    

    
function[k,L,xx,kflag]=bend_spline(k,L,xx,nb_elem,j,s1,s2,ya,yb,xa,xb)

    disp('bend_spline');

    kflag=0;

    x=[xa xb];
    y=[ya yb];
    PP=[s1 y s2];
    
    try
        cs = spline(x,PP);
    catch
        disp(' cs fail');
        kflag=1;
    end

    ne=nb_elem;
    
    dL=(xb-xa)/ne;  
    
    try
        k1=k;
        for i=1:(ne-1)
            xx(k,1)=xa+dL*i;
            xx(k,2)=ppval(cs,xx(k,1));
            k=k+1;
        end
        k2=k-1;
%        disp('ppval passed'); 
    catch
        disp('ppval failed');
        kflag=1;
        return;
    end
    
% even arc length correction

    try

        p = polyfit(xx(k1:k2,1),xx(k1:k2,2),3);

        cube=@(x) p(1)*x.^3+p(2)*x.^2+p(3)*x+p(4);
        core=@(x) sqrt( 1+ (3*p(1)*x.^2+2*p(2)*x+p(3)).^2);

        alen=integral(core,xa,xb); 
   
        dL=alen/ne;
%        disp('polyfit passed');           
    catch
        disp('polyfit failed');
        kflag=1;
        return;
    end
 
    try
        nnn=1000;
        dxx=(xb-xa)/nnn;
        aa=zeros(nnn,1);
        xbb=zeros(nnn,1);

        for i=1:nnn
            xbb(i)=xa+i*dxx;
            aa(i)=integral(core,xa,xbb(i));
        end
%        disp('integral pass');       
    catch
        disp('integral fail');
        k=1;
        return;
    end
    
    try
    
        k=k1;
        for i=1:(ne-1)
            dLi=i*dL;
            [~,ijk]=min(abs(aa-dLi));
            xx(k,1)=xbb(ijk);
            xx(k,2)=cube(xx(k,1));
            
            k=k+1;
        end    
        
    catch
        disp(' xx fail');
        kflag=1;
    end
    

function[s1,s2,xa,xb,ya,yb,deltax1,deltax2]=slope_check(x1,x2,y1,y2,j)

    xa=x2(j);
    xb=x1(j+1);
    ya=y2(j);
    yb=y1(j+1);    

    deltax1=x2(j)-x1(j);
    deltay1=y2(j)-y1(j);
    
    s1=deltay1/deltax1;
 
    deltax2=x2(j+1)-x1(j+1);
    deltay2=y2(j+1)-y1(j+1);
   
    s2=deltay2/deltax2;

disp('  ');
disp(' plate_fea_pre.m  ver 1.5   June 7, 2012 ');
disp('  ');
disp(' by Tom Irvine   Email: tomirvine@aol.com ');
disp('  ');
%
disp(' ');
L=input(' Enter the length (inch) along the x-axis ');
disp(' ');
W=input(' Enter the width (inch)  along the y-axis ');
disp(' ');
disp(' ');
nx=input(' Enter the number of nodes along the x-axis ');
disp(' ');
ny=input(' Enter the number of nodes along the y-axis ');
disp(' ');
%
number_nodes=nx*ny;
%
dx=L/(nx-1);
dy=W/(ny-1);
%
clear node_matrix;
clear element_matrix;
clear constraint_matrix;
%
ijk=1;
%
for(j=1:ny)
%    
    for(i=1:nx)
        node_matrix(ijk,1)=(i-1)*dx;
        node_matrix(ijk,2)=(j-1)*dy;        
        ijk=ijk+1;  
    end
%    
end
%
ne=(nx-1)*(ny-1);
%
j=1;
k=1;
for(i=1:ne)
%
    element_matrix(i,1)=j; 
    element_matrix(i,2)=j+1; 
    element_matrix(i,3)=element_matrix(i,2)+nx;
    element_matrix(i,4)=element_matrix(i,1)+nx;
%
    j=j+1;
    k=k+1;
    
    if(k==nx)
        j=j+1;
        k=1;
    end
%    
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold off;
clear figure(1);
figure(1);
plot(node_matrix(:,1),node_matrix(:,2),'.');
%
clear nodex;
clear nodey;
nodex=node_matrix(:,1);
nodey=node_matrix(:,2);
%
for(i=1:number_nodes)
   string=num2str(i,'%d\n');
   text(nodex(i),nodey(i),string);
end
xlabel('X');
ylabel('Y');
grid on;
%
xmax=max(nodex)+dx/2;
ymax=max(nodey)+dy/2;
%
xmin=min(nodex)-dx/2;
ymin=min(nodey)-dy/2;
%
axis([xmin,xmax,ymin,ymax]);
hold off;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp('  ');
disp(' Select boundary Condition ');
disp(' 1=all free   2=corners pinned   3=other ');
disp('  ');
ibc=input(' ');
%
clear constraint_matrix;
if(ibc==2)
    constraint_matrix(1,:)=[1 1 0 0]; 
    constraint_matrix(2,:)=[nx 1 0 0];  
    constraint_matrix(3,:)=[(nx*(ny-1)+1) 1 0 0];  
    constraint_matrix(4,:)=[nx*ny 1 0 0];  
end
%
fixed=[1 1 1]; 
RY_only=[1 0 1];   
RX_only=[1 1 0];   
%
icn=1;
if(ibc==3)
%    
    disp(' ');
    disp(' Select BC for bottom edge ');
    disp(' 1=free   2=simply supported   3=fixed ');
    e1=input(' ');
    if(e1==2)
        for(i=1:nx) 
            constraint_matrix(icn,:)=[i RX_only];
            icn=icn+1;
        end        
    end
    if(e1==3)
        for(i=1:nx) 
            constraint_matrix(icn,:)=[i fixed];
            icn=icn+1;
        end
    end
%
    disp(' ');
    disp(' Select BC for right edge ');
    disp(' 1=free   2=simply supported   3=fixed ');
    e2=input(' ');
    if(e2==2)
        ijk=nx;
        for(j=1:ny)
            constraint_matrix(icn,:)=[ijk RY_only];
            icn=icn+1;           
            ijk=ijk+nx;
        end        
    end
    if(e2==3)
        ijk=nx;
        for(j=1:ny)
            constraint_matrix(icn,:)=[ijk fixed];
            icn=icn+1;           
            ijk=ijk+nx;
        end      
    end    
%
    disp(' ');
    disp(' Select BC for top edge ');
    disp(' 1=free   2=simply supported   3=fixed ');
    e3=input(' ');
    if(e3==2)     
        for(i=(nx*(ny-1)+1):(nx*ny)) 
            constraint_matrix(icn,:)=[i RX_only];
            icn=icn+1;
        end        
    end
    if(e3==3)  
        for(i=(nx*(ny-1)+1):(nx*ny)) 
            constraint_matrix(icn,:)=[i fixed];
            icn=icn+1;
        end
    end    
%
    disp(' ');
    disp(' Select BC for left edge ');
    disp(' 1=free   2=simply supported   3=fixed ');
    e4=input(' ');
    if(e4==2)
        ijk=1;
        for(j=1:ny)
            constraint_matrix(icn,:)=[ijk RY_only];
            icn=icn+1;             
            ijk=ijk+nx;
        end          
    end
    if(e4==3)
        ijk=1;
        for(j=1:ny)
            constraint_matrix(icn,:)=[ijk fixed];
            icn=icn+1;  
            ijk=ijk+nx;
        end     
    end   
%
end
%
if(ibc~=1)
    disp(' sort ');
    constraint_matrix=sortrows(constraint_matrix,1);
    sz=size(constraint_matrix);
    nz=sz(1);
%
    i=1;
    while(1)
        if(constraint_matrix(i,1)==constraint_matrix(i+1,1))
    %
            for(j=2:4)
                an=constraint_matrix(i,j)+constraint_matrix(i+1,j);
                if(an>1)
                    an=1;
                end
                constraint_matrix(i,j)=an;
            end
    %
            constraint_matrix(i+1,:)=[];
            sz=size(constraint_matrix);
            nz=sz(1);
            constraint_matrix;
        else
            i=i+1;
        end
%    
        if(i+1>nz)
            break;
        end
    end
end    
%
disp(' ');
disp(' Output Matrices ');
disp(' ');
disp('    node_matrix ');
disp('    element_matrix ');
%
if(ibc ~=1)
    disp('    constraint_matrix ');
end
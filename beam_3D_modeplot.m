function[mx,my,mz,scale]=beam_3D_modeplot(scale,nodex,nodey,nodez,node1,node2,cdof,nnum,enum,ModeShapes,fn)
clear max;
disp(' ');
kjv=input(' Enter mode number ');
disp(' ');
clear MS;
figure(3);
plot3(nodex,nodey,nodez,'s');
hold on;
xlabel('X');
ylabel('Y');
zlabel('Z');
grid on;
for(i=1:enum)
  x=[nodex(node1(i)),nodex(node2(i))];
  y=[nodey(node1(i)),nodey(node2(i))];
  z=[nodez(node1(i)),nodez(node2(i))];
  plot3(x,y,z,'b');    
end
%
max_ux=max(nodex);
max_uy=max(nodey);
max_uz=max(nodez);
min_ux=min(nodex);
min_uy=min(nodey);
min_uz=min(nodez);
%
distance_u=sqrt( (max_ux-min_ux)^2 + (max_uy-min_uy)^2 + (max_uz-min_uz)^2 );
%
ux=max_ux-min_ux;
uy=max_uy-min_uy;
uz=max_uz-min_uz;
%
avex=(max_ux+min_ux)/2;
avey=(max_uy+min_uy)/2;
avez=(max_uz+min_uz)/2;
%
ddd=[ux,uy,uz];
dmax=max(ddd);
dmax=dmax*1.2;
%
xmin=avex-dmax/2;
xmax=avex+dmax/2;
ymin=avey-dmax/2;
ymax=avey+dmax/2;
zmin=avez-dmax/2;
zmax=avez+dmax/2;
%
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
%
clear MS;
j=1;
sz=max(size(cdof));
dof=nnum*6;
for(k=1:dof)
%    
    iflag=0;
    for(i=1:sz)
        if(k==cdof(i))
            iflag=1;
            break;
        end
    end
%
    if(iflag==1)
        MS(k)=0;
    else
        MS(k)=ModeShapes(j,kjv);
        j=j+1;
    end
%        
end
%
j=1;
clear mx;
clear my;
clear mz;
mx=zeros(nnum,1);
my=zeros(nnum,1);
mz=zeros(nnum,1);
%
for(i=1:nnum)
    mx(i)=scale*MS(j);
    my(i)=scale*MS(j+1);
    mz(i)=scale*MS(j+2);
    j=j+6;
end
sz=size(nodex);
if(sz(2)>sz(1))
  nodex=nodex';
  nodey=nodey';
  nodez=nodez';
end
%
mx=mx+nodex;
my=my+nodey;
mz=mz+nodez;
%
nodexx=mx;
nodeyy=my;
nodezz=mz;
%
%****** Find Scale **************************************
%
if( abs(scale-1)<0.01)
%    
    max_mx=max(mx);
    max_my=max(my);
    max_mz=max(mz);
%
    min_mx=min(mx);
    min_my=min(my);
    min_mz=min(mz);
%
    distance_m=sqrt( (max_mx-min_mx)^2 + (max_my-min_my)^2 + (max_mz-min_mz)^2 );
    scale=(distance_u/distance_m);    
%
    j=1;
    for(i=1:max(size(mx)))
        mx(i)=scale*MS(j);
        my(i)=scale*MS(j+1);
        mz(i)=scale*MS(j+2);
        j=j+6;
    end
    sz=size(nodex);
    if(sz(2)>(1))
        nodex=nodex';
        nodey=nodey';
        nodez=nodez';
    end
%
    mx=mx+nodex;
    my=my+nodey;
    mz=mz+nodez;
%
    nodexx=mx;
    nodeyy=my;
    nodezz=mz;
end    
%
%
%**********************************************************
%
plot3(mx,my,mz,'r*'); 
for(i=1:enum)
  x=[nodexx(node1(i)),nodexx(node2(i))];
  y=[nodeyy(node1(i)),nodeyy(node2(i))];
  z=[nodezz(node1(i)),nodezz(node2(i))];
  plot3(x,y,z,'r');     
end
%
max_nx=max(nodexx);
max_ny=max(nodeyy);
max_nz=max(nodezz);
min_nx=min(nodexx);
min_ny=min(nodeyy);
min_nz=min(nodezz);
dx=max_nx-min_nx;
dy=max_ny-min_ny;
dz=max_nz-min_nz;
%
avex=(max_nx+min_nx)/2;
avey=(max_ny+min_ny)/2;
avez=(max_nz+min_nz)/2;
%
ddd=[dx,dy,dz,ux,uy,uz];
dmax=max(ddd);
dmax=dmax*1.2;
%
xmin=avex-dmax/2;
xmax=avex+dmax/2;
ymin=avey-dmax/2;
ymax=avey+dmax/2;
zmin=avez-dmax/2;
zmax=avez+dmax/2;
%
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
%
out1=sprintf(' Mode %d   fn=%8.4g Hz',kjv,fn(kjv));
title(out1);
    h = get(gca, 'title');
    set(h, 'FontName', 'Arial','FontSize',12);
hold off;

%  ss_ss_ss_ss_plate_alt.m  ver 1.0  by Tom Irvine

function[omegan,fbig,part,phi,phi_x,phi_xx,phi_y,phi_yy,phi_xy,fig_num]=ss_ss_ss_ss_plate_alt(AAA,Amn,DD,a,b,nm,fig_num)


    part=@(AAA,m,n)(AAA*(cos(m*pi)-1)*(cos(n*pi)-1)/(m*n));    

       phi=@(Amn,x,y,m,n,a,b)(Amn*sin(m*pi*x/a)*sin(n*pi*y/b));
       
     phi_x=@(Amn,x,y,m,n,a,b)(   (m*pi/a)*Amn*cos(m*pi*x/a)*sin(n*pi*y/b));    
    phi_xx=@(Amn,x,y,m,n,a,b)(-(m*pi/a)^2*Amn*sin(m*pi*x/a)*sin(n*pi*y/b));
    
     phi_y=@(Amn,x,y,m,n,a,b)(   (n*pi/b)*Amn*sin(m*pi*x/a)*cos(n*pi*y/b));    
    phi_yy=@(Amn,x,y,m,n,a,b)(-(n*pi/b)^2*Amn*sin(m*pi*x/a)*sin(n*pi*y/b));      

    phi_xy=@(Amn,x,y,m,n,a,b)((m*pi/a)*(n*pi/b)*Amn*cos(m*pi*x/a)*cos(n*pi*y/b));    
    
    omegan=zeros(nm,nm);
    faux=zeros(nm^2,1);
    fbig=zeros(nm^2,1);
    
    i=1;
    for m=1:nm
        for n=1:nm
            omegan(m,n)=DD*( (m*pi/a)^2 + (n*pi/b)^2 );
            faux(i)=omegan(m,n)/(2*pi);
            
            fbig(i,1)=faux(i);
            fbig(i,2)=m;
            fbig(i,3)=n;
            
            i=i+1;
        end
    end
    
    fn=omegan/(2*pi);
    
%%%%%%%%%%%%%%%%%%

figure(fig_num); 
fig_num=fig_num+1;

%
num=41; 
%
clear x;
clear y;
%
dx=a/(num-1);
dy=b/(num-1);
%

x=zeros(num,1);
y=zeros(num,1);

for i=1:num
   ii=i-1;
   x(i)=ii*dx;
   y(i)=ii*dy;
end
%
%  Calculate mode shapes and mass-normalized
%
clear norm;
%
zzr=zeros(num,num);
%
m=1;
n=1;

for i=1:num 
    for j=1:num 
        zzr(i,j)=phi(Amn,x(i),y(j),m,n,a,b);  
    end
end

%
%
zmax=max(max(zzr));
zmin=min(min(zzr));
%
clear aaa;

aaa=max([max(x) max(y)]);
xmin=0;
ymin=0;
xmax=aaa;
ymax=aaa;
surf(x,y,zzr);
zmax=2*zmax;
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
out1=sprintf('Mode 1  fn=%8.4g Hz',fn(1));
title(out1)


function[fig_num]=ss_plate_mode_shape(fn,L,W,mass_per_area,fig_num)

a=L;
b=W;

num=51;

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
for i=1:num 
%          
        for j=1:num 
%
            zzr(i,j)=sin(pi*x(i)/a)*sin(pi*y(j)/b);            
%
        end
end

%
norm=sqrt(mass_per_area*a*b);
%
zzr=2*zzr/norm;
%
%
zmax=max(max(zzr));
zmin=min(min(zzr));
%
clear aaa;
clear abc;
abc=[x y];
aaa=max(max(abc));
xmin=0;
ymin=0;
xmax=aaa;
ymax=aaa;
figure(fig_num);
fig_num=fig_num+1;
surf(x,y,zzr);
out1=sprintf('Mode 1  fn=%8.4g Hz',fn);
title(out1)

zmax=2*zmax;
axis([xmin,xmax,ymin,ymax,zmin,zmax]);



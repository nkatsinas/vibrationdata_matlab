%
%  ss_ss_ss_ss_plate_uniform_alt.m  ver 1.0   by Tom Irvine
%
function[zzr,faux,omegamn,x,y]=ss_ss_ss_ss_plate_uniform_alt(D,a,b,mass_per_area)
%
nmodes=6;
%
mass=mass_per_area*a*b;
%
DD=sqrt(D/mass_per_area);
%
i=1;

omegamn=zeros(nmodes,nmodes);
faux=zeros(nmodes^2,1);

for m=1:nmodes
    for n=1:nmodes
        omegamn(m,n)=DD*( (m*pi/a)^2 + (n*pi/b)^2 );
        faux(i)=omegamn(m,n)/(2*pi);
        i=i+1;
    end
end

AAA=(2*sqrt(mass)/pi^2);
iv=1;
part=zeros(nmodes,nmodes);

fbig=zeros(nmodes^2,5);

for i=1:nmodes
    for j=1:nmodes
        part(i,j)=(cos(i*pi)-1)*(cos(j*pi)-1);
        part(i,j)=AAA*part(i,j)/(i*j);
        fbig(iv,1)=faux(iv);
        fbig(iv,2)=i;
        fbig(iv,3)=j;
        fbig(iv,4)=part(i,j);
        fbig(iv,5)=(part(i,j))^2;
        iv=iv+1;
    end
end
fbig=sortrows(fbig,1);
mt=iv-1;
%

disp(' ');
disp('    fn(Hz)   m   n        PF       EMM    ');
%
fn=zeros(mt,1);
for i=1:mt  
    m=fbig(i,2);
    n=fbig(i,3);
    fprintf(' %9.5g \t %d\t %d\t %8.4g\t %8.4g\n',fbig(i,1),fbig(i,2),fbig(i,3),fbig(i,4),fbig(i,5));
    fn(i)=fbig(i,1);
end
disp(' ');

%
%  Calculate mode shapes and mass-normalized
%
clear norm;

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
zmax=max(max(zzr));
zmin=min(min(zzr));
%
clear aaa;
clear abc;
aaa=max([max(x) max(y)]);
xmin=0;
ymin=0;
xmax=aaa;
ymax=aaa;
figure(1); 
surf(x,y,zzr);
zmax=2*zmax;
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
out1=sprintf('Mode 1  fn=%8.4g Hz',fn(1));
title(out1)
%
%  vibrationdata_fixed_circular_plate.m  ver 1.0  by Tom Irvine
%
function[fn,part,n,k,CE,DE,root,fig_num]=...
                vibrationdata_fixed_circular_plate(D,DD,rho,mu,h,r,fig_num)
% 
radius=r;
%
total_mass=rho*pi*r^2*h;
%
tpi=2*pi;
%
num=12;
num2=num^2;
nm1=num-1;
%
%
 root=zeros(num2,1);
rootn=zeros(num2,1);
rootk=zeros(num2,1);
   Cc=zeros(num2,1);
   Dc=zeros(num2,1);
   PF=zeros(num2,1);
%
for ijk=1:num2
    root(ijk)=0;
    rootn(ijk)=0;
    rootk(ijk)=0;
    Cc(ijk)=0;
    Dc(ijk)=0;
    PF(ijk)=0;
end
%
ijk=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
num_roots=(nm1+1)^2;
%
progressbar % Create figure and set starting time
%
for n=0:nm1
%
    clear a;
    clear b;
    clear x;
    clear y;
%
    j=1;
    delta=0.005;
    for i=1:60000
        xx=i*delta;
        x(i)=xx;
%        
        ya=Bessel_fixed(n,xx,mu);   
%
        if(i>2)
            if(ya*yb<=0)
                b(j)=xx;
                j=j+1;
            end
        end
        yb=ya;    
        if(j>4)
            break;
        end
%        
    end
    a=b-delta;
%
%   secant
%
    k=0;
    for i=1:max(size(a))
%
        for j=1:150
%            
            xx=a(i);    
            ya=Bessel_fixed(n,xx,mu);       
%
            xx=b(i);      
            yb=Bessel_fixed(n,xx,mu);   
%
            if(abs(b(i)-a(i))<0.00001)
                break;
            end
%
            m=(yb-ya)/(b(i)-a(i));
            bb=ya-m*a(i);
            ab=-bb/m;
%
            xx=ab;           
            yab=Bessel_fixed(n,xx,mu);   
%
            if(ya*yab<=0)
                b(i)=ab;    
            else
                a(i)=ab;
            end
%
        end
        root(ijk)=0.25*(a(i)+b(i))^2;
        rootn(ijk)=n;
        rootk(ijk)=k;
        progressbar(ijk/num_roots);
%
%  Eigenvectors & Participation Factors
%
        Dc(ijk)=0;
        Cc(ijk)=0;
        if(root(ijk)>0.01)
            L=sqrt(root(ijk));
            Dc(ijk)=besselj(n,L)/besseli(n,L);
            A=Dc(ijk);
            beta=L/radius;
            x=beta*radius;
%
            Q=0;
            Q = quad(@circular_ss_bessel_function,0,x,[],[],n,A);
            Cc(ijk)=L/sqrt(Q);

%
            Q=0;
            if(n==0)
                
                Q = quad(@circular_ss_bessel_function_PF,0,x,[],[],n,A);                
            end
%
            PF(ijk)=2*Cc(ijk)*Q/L^2;
%
            Cc(ijk)=Cc(ijk)/sqrt(total_mass);
            PF(ijk)=PF(ijk)*sqrt(total_mass);
%
%%            if(n==0)
%%                out1=sprintf('Cc=%8.4g  PF=%8.4g',Cc(ijk),PF(ijk));
%%                disp(out1);
%%            end
%
        end
%        
%
        if(k==nm1)
            break;
        end
        k=k+1;
        ijk=ijk+1;
%        
    end 
end
%
progressbar(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% plot(x,y);
% grid on;
% axis([0,max(x),-10,10]);
disp(' ');
%
clear RM;
clear n;
clear k;
%
root=fix_size(root);
rootn=fix_size(rootn);
rootk=fix_size(rootk);
Cc=fix_size(Cc);
Dc=fix_size(Dc);
PF=fix_size(PF);
%
%
RM=[root rootn rootk Cc Dc PF];
%
RM = sortrows(RM,1);
%
sz=size(root);
%
for i=max(sz):-1:1
    if(RM(i,1)<=0.001)
       RM(i,:)=[];
    end
end    
%
clear Cc;
clear Dc;
%
root=RM(:,1);
n=RM(:,2);
k=RM(:,3);
Cc=RM(:,4);
Dc=RM(:,5);
PF=RM(:,6);
%
disp(' ');
disp('  Natural ');
disp(' Frequency    ');
disp('   (Hz)    n  k       C        D        root      PF    EMM');
% 
DTerm=sqrt(D/(rho*h))/(tpi*radius^2);
clear f;
clear nn;
clear kk;
j=1;
%

NT=length(root);
if(NT>60)
    NT=60;
end
%
fn=zeros(NT,1);
f=zeros(NT,1);
%
sw=0;
for i=1:NT
        fn(i)=root(i)*DTerm;
        EMM=(PF(i))^2;
        sw=sw+EMM;
        out1=sprintf('%8.2f   %d  %d   %8.5f %9.6f %8.4f %8.4f %8.4f',fn(i),n(i),k(i),Cc(i),Dc(i),sqrt(root(i)),PF(i),EMM);
        disp(out1);
        f(j)=fn(i);
        nn(j)=n(i);
        kk(j)=k(i);
        j=j+1;
end
%% 386*sw
%
nodal_diam=n;
%
part=PF;
%
disp(' ')
disp('   n = nodal diameters ');
disp('   k = nodal circles ');
disp('  PF = participation factor ');
disp(' EMM = effective modal mass ');

CE=Cc;
DE=Dc;

%%

    mm=90;
    mmp=mm+1;
    for i=1:4
        clear Z;
        clear r;
        clear theta;
        nx=nn(i);
        lambda(i)=sqrt(root(i));
%
        L=lambda(i);
%
        for ii=1:mmp
            theta(ii)=(ii-1)*2*pi/mm;
            arg=nx*theta(ii);
            for(jj=1:mmp)
                r(jj)=(jj-1)/mm;  % note that the radius is non-dimensional
                kr=L*r(jj);
                Z(ii,jj)=Cc(i)*( besselj(nx,kr)- Dc(i)*besseli(nx,kr))*cos(arg);
            end
        end
%        
        figure(fig_num);
        fig_num=fig_num+1;
%  
        polarplot3d(Z','PlotType','surfn','meshscale',0.5,'PolarGrid',[20 72]);
%
        out1=sprintf('Mode %d  fn=%8.4g Hz  n=%d  k=%d',i,f(i),nn(i),kk(i));
        title(out1);
        h = get(gca, 'title');
        set(h, 'FontName', 'Arial','FontSize',10); 
%
    end
   
    

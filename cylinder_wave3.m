%
disp(' ')
disp(' cylinder_wave.m  ver 1.3  Sep 28, 2006')
disp(' By Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
%
clear ma;
clear ff;
clear fn;
clear mm;
clear nn;
%
nmax=170;
mmax=170;
%
bc=0;
while(1)
    disp(' Selected Boundary Conditions ')
    disp(' 1=free-free ')   
    disp(' 2=fixed-fixed ')
    disp(' 3=fixed-free')
    disp(' 4=simply supported-simply supported ')
    bc=input(' ');
    if(bc==1 | bc==2 | bc==3 | bc==4)
        break;
    end
end
%
a=24;           % radius (in)
h=0.125;        % thickness (in)
L=48.*2;          % length (in)
E=9.9e+06;      % elastic modulus (psi)
rho=0.0002539;  % mass/volume (lbf sec^2/in^4)
v=0.33;         % Poisson ratio
%
K=E*h/(1-v^2);
D=E*h^3/(1-v^2)/12;
%
ma=zeros([3 3]);
ma(1,1)=1;
ma(2,2)=1;
ma(3,3)=1;  
%
ma=ma*(rho*h);
%
kv=1;
%
progressbar % Create figure and set starting time 
disp(' ');
disp(' Calculating Modal Frequencies... ');
for(m=1:mmax)
%
    progressbar(m/mmax) % Update figure      
    if(bc==1 | bc==2)
        if(m==1)
            xo=[4.7 4.8];
            qcc=inline('cos(x).*cosh(x)-1','x');
            options=optimset('display','off');
            kx=fzero(qcc,xo,options);
        end
        if(m>=2)
            kx=(2*m+1)*pi/2;
        end
    end
    if(bc==3)
        if(m==1)
            xo=[1.8 1.9];
            qcc=inline('cos(x).*cosh(x)+1','x');
            options=optimset('display','off');
            kx=fzero(qcc,xo,options);
        end
        if(m>=2)
            kx=(2*m-1)*pi/2;
        end
    end
    if(bc==4)
        kx=m*pi;
    end   
    kx=kx/L;
    kx2=kx^2;
%    
    for(n=0:nmax)
%
        clear ka;
%
        kt=n/a;
        kt2=kt^2;
        khat=sqrt(kx2+kt2);
%
        ka(1,1)=kx2+((1-v)/2)*kt2;
        ka(1,2)=(kt*kx*(1+v))/2; 
        ka(1,3)=(v/a)*kx; 
        ka(2,1)=ka(1,2);
        ka(2,2)=kt2+((1-v)/2)*kx2; 
        ka(2,3)=kt/a;
        ka(3,1)=ka(1,3);
        ka(3,2)=ka(2,3); 
        ka(3,3)=((D/K)*(khat^4))+(1/a^2);    
        ka=K*ka;  
%
%  Optional for mode shapes
%
%        ka(1,2)=ka(1,2)*i;
%        ka(1,3)=ka(1,3)*i;
%        ka(2,1)=-ka(2,1)*i;
%        ka(3,1)=-ka(3,1)*i;
%
        [ModeShapes,som2]=eig(ka,ma);
        fn(1)=sqrt(som2(1,1));
        fn(2)=sqrt(som2(2,2));
        fn(3)=sqrt(som2(3,3));   
        fn=fn/(2.*pi);
        ff(kv)=fn(1);
        mm(kv)=m;
        nn(kv)=n;
        
         if(n==0 && m==1)
            fring1=fn(1);
            fring2=fn(2);
            fring3=fn(3);            
        end
        
        
        kv=kv+1;
%
%        out1=sprintf(' n=%d m=%d  fn1=%g  fn2=%g  fn3=%g',n,m,fn(1),fn(2),fn(3));
%        disp(out1)
    end
end
%
disp(' ');
disp(' Sorting... ');
clear fnm;
fnm=[ff',nn',mm'];
fnm=sortrows(fnm,1);
%
ffb=fnm(:,1);
nnb=fnm(:,2);
mmb=fnm(:,3);
%
disp(' ')
disp('  fn(Hz)   n  m ');
%
mmm=kv-1;
if(mmm>250)
    mmm=250;
end
for(i=1:mmm)
    out1=sprintf(' %d  %8.2f  %d  %d ',i,ffb(i),nnb(i),mmb(i));
    disp(out1)
    
    if(nnb(i)==0 && mmb(i)==1)
        fring=ffb(i);
    end
end
%
clear fc;
clear nn;
%
ioct=2;
if(ioct==1)
	fc(1)=2.;
	fc(2)=4.;
	fc(3)=8.;
	fc(4)=16.;
	fc(5)=31.5;
	fc(6)=63.;
	fc(7)=125.;
	fc(8)=250.;
	fc(9)=500.;
	fc(10)=1000.;
	fc(11)=2000.;
	fc(12)=4000.;
	fc(13)=8000.;
	fc(14)=16000.;
    imax=14;
end
if(ioct==2)
	fc(1)=2.5;
	fc(2)=3.15;
	fc(3)=4.;
	fc(4)=5.;
	fc(5)=6.3;
	fc(6)=8.;
	fc(7)=10.;
	fc(8)=12.5;
	fc(9)=16.;
	fc(10)=20.;
	fc(11)=25.;
	fc(12)=31.5;
	fc(13)=40.;
	fc(14)=50.;
	fc(15)=63.;
	fc(16)=80.;
	fc(17)=100.;
	fc(18)=125.;
	fc(19)=160.;
	fc(20)=200.;
	fc(21)=250.;
	fc(22)=315.;
	fc(23)=400.;
	fc(24)=500.;
	fc(25)=630.;
	fc(26)=800.;
	fc(27)=1000.;
	fc(28)=1250.;
	fc(29)=1600.;
	fc(30)=2000.;
	fc(31)=2500.;
	fc(32)=3150.;
	fc(33)=4000.;
	fc(34)=5000.;
	fc(35)=6300.;
	fc(36)=8000.;
	fc(37)=10000.;
	fc(38)=12500.;
	fc(39)=16000.;
	fc(40)=20000.;
    imax=40;
end
%
nun=zeros([1 imax]);
for(j=1:imax)
    fl=fc(j)/sqrt(2);
    fu=fc(j)*sqrt(2);
    for(i=1:(kv-1))
        if(ffb(i)>=fl & ffb(i) < fu)
           nun(j)=nun(j)+1;    
        end
        if(ffb(i)>fu)
            break;
        end
    end    
end
for(j=1:imax)
    fl=fc(j)/sqrt(2);
    fu=fc(j)*sqrt(2);  
    nun(j)=nun(j)/(fu-fl);
end    
md=[fc' nun'];
md=sortrows(md,1);
plot(md(:,1),md(:,2));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz)');
ylabel('Modes/Hz');
title('Cylinder Modal Density');
grid('on');

fring1
fring2
fring3
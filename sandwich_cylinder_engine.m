%
%  sandwich_cylinder_engine.m  ver 1.1  by Tom Irvine
%
function[ffb,nnb,mmb,kv,radius]=...
                 sandwich_cylinder_engine(D,K,v,diam,L,mpa,bc,mmax,nmax)
             
a=diam/2; % radius

radius=a;

%
ma=mpa*eye(3);
%
kv=1;
%

disp(' ');
disp(' Calculating Modal Frequencies... ');
%
for m=1:mmax
% 
    if(bc==1 || bc==2)
        if(m==1)
            xo=[4.7 4.8];
            qcc=@(x)(cos(x).*cosh(x)-1);
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
            qcc=@(x)(cos(x).*cosh(x)+1);
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
    for n=0:nmax
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
%
        kn=n*pi/(pi*diam);
        km=m*pi/L;
%
        if(m==0 && n==0)
            kn=1.0e-10;
            km=1.0e-10;
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

%
disp(' ')
disp('  fn(Hz)   n    m  ');
%


for i=1:length(ffb);

    if(i<250)
        out1=sprintf('%d  %8.2f  %d  %d ',i,ffb(i),nnb(i),mmb(i));
        disp(out1)
    end
% 
end
%



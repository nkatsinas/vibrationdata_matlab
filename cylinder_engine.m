%
%  cylinder_engine.m  ver 1.1  by Tom Irvine
%
function[ffb,nnb,mmb,kv,radius,kL]=...
                             cylinder_engine(E,rho,v,h,diam,L,mmax,nmax,bc)

a=diam/2; % radius

radius=a;

K=E*h/(1-v^2);

[D]=flexural_rigidity(E,h,v);

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
kx=zeros(mmax,1);
%
for m=1:mmax
% 
    if(bc==1 || bc==2)
        if(m==1)
            xo=[4.7 4.8];
            qcc=@(x)(cos(x).*cosh(x)-1);
            options=optimset('display','off');
            kx(m)=fzero(qcc,xo,options);
        end
        if(m==2)
            xo=[7.8 7.9];
            qcc=@(x)(cos(x).*cosh(x)-1);
            options=optimset('display','off');
            kx(m)=fzero(qcc,xo,options);
        end    
        if(m==3)
            xo=[10.95 11.1];
            qcc=@(x)(cos(x).*cosh(x)-1);
            options=optimset('display','off');
            kx(m)=fzero(qcc,xo,options);
        end            
        if(m>=4)
            kx(m)=(2*m+1)*pi/2;
        end
    end
    
    if(bc==3) % Fixed-Free
        if(m==1)
            xo=[1.8 1.9];
            qcc=@(x)(cos(x).*cosh(x)+1);
            options=optimset('display','off');
            kx(m)=fzero(qcc,xo,options);
        end
        if(m>=2)
            kx(m)=(2*m-1)*pi/2;
        end
    end
    if(bc==4) % SS-SS
        kx(m)=m*pi;
    end   
    kx(m)=kx(m)/L;
    kx2=kx(m)^2;
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
        ka(1,2)=(kt*kx(m)*(1+v))/2; 
        ka(1,3)=(v/a)*kx(m); 
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
        
        kv=kv+1;
%
%%        out1=sprintf(' n=%d m=%d  fn1=%g  fn2=%g  fn3=%g',n,m,fn(1),fn(2),fn(3));
%%        disp(out1)
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

kL=kx*L;

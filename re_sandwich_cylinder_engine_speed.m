%
%  re_sandwich_cylinder_engine_speed.m  ver 1.1  by Tom Irvine
%
function[rad_eff,mph,cphase]=...
        re_sandwich_cylinder_engine_speed(D,K,v,diam,L,mpa,bc,mmax,nmax,air_c,fcr,fring,freq)
             
fc=freq;    

a=diam/2; % radius

highest_AS=0;

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
%
        k=2*pi*fn(1)/air_c;
        if(k^2>=kn^2+km^2)
            nt(kv)=1;
            kratio=(km^2+kn^2)/k^2;
            rem(kv)=1/sqrt(1-kratio);
            
        else
            nt(kv)=0;
            rem(kv)=0;
        end
        if(m==0 && n==0)
            ff(kv)= ring_f;
            rem(kv)=1;
        end
%
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

fnm=[ff',nn',mm',nt',rem'];
fnm=sortrows(fnm,1);
%
ffb=fnm(:,1);
nnb=fnm(:,2);
mmb=fnm(:,3);
ntb=fnm(:,4);
remb=fnm(:,5);
%
reff=zeros([1 kv]);
%
disp(' ')
disp('   fn(Hz)    n   m    kn     km    kair    re   type   cb');
%
mmm=kv-1;
%
j=1;

kcomp=zeros(mmm,1);
cwb=zeros(mmm,1);
%
progressbar; 
for i=1:mmm
    progressbar(i/mmm);
    if(ntb(i)==1)
       mtype='AF';     
    else
       mtype='AS';
       if(ffb(i)>highest_AS && (mmb(i)+nnb(i))~=0)
           highest_AS=ffb(i);
       end
    end
    kn=nnb(i)*pi/(pi*diam);
    km=mmb(i)*pi/L;
    k=2*pi*ffb(i)/air_c;
    if(k>sqrt(kn^2+km^2))
        reff(i)=sqrt(1-(kn^2+km^2)/k^2);
    else
        reff(i)=0.01;
    end
%
    kcomp(i)=sqrt(kn^2+km^2);
%
    cw=0.;
    if(kcomp(i)>1.0e-10)
        cw=2*pi*ffb(i)/kcomp(i);
    end
    
    cwb(i)=cw;
    
    if(i<250)
        out1=sprintf('%d  %8.2f  %d  %d  %6.2g  %6.2g %6.2g %6.2g %s %7.3g',i,ffb(i),nnb(i),mmb(i),kn,km,k,reff(i),mtype,cw);
        disp(out1)
    end
%    
    if(nnb(i)==0)
       j=j+1;
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

NL=length(fc);

imax=NL;

modal_overlap=zeros(NL,1);

cphase=zeros([1 imax]);
nun=zeros([1 imax]);
rem_ave=zeros([1 imax]);
rem_sum=zeros([1 imax]);
nslow=zeros([1 imax]);
nfast=zeros([1 imax]);
%
nf=length(ffb);

alpha=2^(1/6);

fstar=fc(1);
jkn=1;

for j=1:NL
    
    fl=fc(j)/alpha;
    fu=fc(j)*alpha;
    
    for i=1:nf
%
        if(ffb(i)>=fl && ffb(i) < fu )   
           if(ntb(i)==1)
               nun(j)=nun(j)+1;
               nfast(j)=nfast(j)+1;
           else
               nun(j)=nun(j)+1;
               nslow(j)=nslow(j)+1;   
           end
           rem_sum(j)=rem_sum(j)+reff(i);
           cphase(j)=cphase(j)+cwb(i);
        end
        if(ffb(i)>fu)
            break;
        end
    end
    if(nun(j)>0)
       rem_ave(j)=rem_sum(j)/nun(j);  
       cphase(j)=cphase(j)/nun(j);  
    end
    if(nun(j)==0 && fc(j)>fring && fc(j)>fcr)
        rem_ave(j)=1;        
    end    
        
    nun(j)=nun(j)/(fu-fl);
    
%    modal_overlap(j)=nun*loss_factor*fc(j);

end  

%
%
rad_eff=rem_ave;
mph=nun;

rad_eff=fix_size(rad_eff);
mph=fix_size(mph);
cphase=fix_size(cphase);

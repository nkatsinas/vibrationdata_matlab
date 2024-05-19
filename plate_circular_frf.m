%
%  plate_circular_frf.m  ver 1.1  by Tom Irvine
%
function[Hrd,Hrv,Haa,HvM,Hsr,Hst]=...
     plate_circular_frf(BC,nf,f,fn,damp,nn,kr,PF,Cc,Dc,lambda,rz,radius,thetaz,E,mu,T)
%
tpi=2*pi;
%
zbar=T/2;
%
NT=length(fn);
%
num=length(f);
%
out1=sprintf('\n NT=%d  num=%d \n',NT,num);
%% disp(out1);
%
nodal_diam=nn;
%
progressbar % Create figure and set starting time
%
Hrd=zeros(num,1);
Hrv=zeros(num,1);
Hra=zeros(num,1);
dZdr=zeros(num,1);
d2Zdr2=zeros(num,1);
%
    for i=1:num
        progressbar(i/num);
        omega=tpi*f(i);
%       
        for jk=1:NT
            if(abs(PF(jk))>0)
                omegan=tpi*fn(jk);
                den=(omegan^2-omega^2)+(1i)*(2*damp(jk)*omegan*omega);
%
                kr=lambda(jk)*rz/radius;
                arg=nn(jk)*thetaz;
%        
                PFod=PF(jk)/den;
              
                    ZZ=Cc(jk)*( besselj(nn(jk),kr)- Dc(jk)*besseli(nn(jk),kr))*cos(arg);

                    
                    
                    nm2=nn(jk)-2;
                    nm1=nn(jk)-1;                   
                    nz=nn(jk);
                    np1=nn(jk)+1;
                    np2=nn(jk)+2;                    

                     bjm2=besselj(nm2,kr);                    
                     bjm1=besselj(nm1,kr);                    
                      bjz=besselj(nz,kr);
                     bjp1=besselj(np1,kr);
                     bjp2=besselj(np2,kr);
                     
                     d_besselj_sm1=( bjm2  - bjz  )/2;            
                     d_besselj =   ( bjm1  - bjp1 )/2;
                     d_besselj_sp1=( bjz   - bjp2 )/2;
                     
                    dd_besselj    =( d_besselj_sm1 -  d_besselj_sp1  )/2;
   
                    
                      bim2=besseli(nm2,kr);                    
                     bim1=besseli(nm1,kr);                    
                      biz=besseli(nz,kr);
                     bip1=besseli(np1,kr);
                     bip2=besseli(np2,kr);
                     
                     d_besseli_sm1=( bim2  + biz  )/2;            
                     d_besseli =   ( bim1  + bip1 )/2;
                     d_besseli_sp1=( biz   + bip2 )/2;    
             
                    dd_besseli    =( d_besseli_sm1 +  d_besseli_sp1  )/2;                               
                
                    
                A=(lambda(jk)/radius);   
                
                term= A*PFod*Cc(jk)*( d_besselj- Dc(jk)*d_besseli)*cos(arg);                 
                
                dZdr(i)=dZdr(i)+term;                
                
                B=A^2;                   
                    
                term= B*PFod*Cc(jk)*( dd_besselj- Dc(jk)*dd_besseli)*cos(arg);   
                    
                d2Zdr2(i)=d2Zdr2(i)+term;
%

                Hrd(i)=-Hrd(i)+ZZ*PFod;
                Hrv(i)=-Hrv(i)+ZZ*PFod*(1i*omega);                
                Hra(i)= Hra(i)+ZZ*PFod*omega^2;
            end
%                             
        end
    end

%    
progressbar(1);
%
Haa=1+Hra;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
Hsr=zeros(num,1);
Hst=zeros(num,1);
HvM=zeros(num,1);
%
for i=1:num
%    
   a=-(E*zbar/(1-mu^2));
%   

   if(rz<1.0e-04)

        Hsr(i)=a*abs(d2Zdr2(i));
        Hst(i)=a*abs(mu*d2Zdr2(i));
   
   else
       
        Hsr(i)=a*abs(     d2Zdr2(i) + (mu/rz)*dZdr(i));
        Hst(i)=a*abs((1/rz)*dZdr(i) +    mu*d2Zdr2(i));       
   end    
%   
   HvM(i)=sqrt( Hsr(i)^2 + Hst(i)^2 - Hsr(i)*Hst(i));
end  
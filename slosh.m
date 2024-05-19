disp(' ');
disp(' slosh_cylinder.m   ver 1.0   July 13, 2010 ');
disp(' by Tom Irvine ');
%
disp(' ');
disp(' This program calculates the slosh frequencies in ');
disp(' a cylindrical basin. ');
disp(' ');
disp(' Assume');
disp(' 1. The liquid is homogeneous, inviscid, irrotational, & incompressible');  
disp(' 2. The boundaries of the basin are rigid ');   
disp(' 3. Small wave amplitudes, linear behavior');   
disp(' 4. The influence of the surrounding atmosphere is negligible');   
disp(' 5. The influence of surface tension is negligible');   
%
clear f;
clear ff;
clear B;
clear lambda;
%
tpi=2*pi;
% 
disp(' ');
disp(' Enter acceleration of gravity (in/sec) ');
g=input(' ');
disp(' Enter diameter (inch) ');
d=input(' ');
R=d/2;
disp(' Enter height (inch) ');
h=input(' ');
%
lambda=zeros(10,10);
for(i=0:3)
   n=1;
   for(kj=1:500)
       k=kj*0.1;
       dJ=besselj(i-1,k)-(i/k)*besselj(i,k);
       if(dJ==0)
           lambda(i+1,n)=k;
           n=n+1;
           if(n==11)
               break;
           end
       else
           if(kj>=2)
              if((dJ*dJb)<0.)
                 for(m=1:20)
                     nk=kb-dJb*(k-kb)/(dJ-dJb);
                     dJn=besselj(i-1,nk)-(i/nk)*besselj(i,nk);
                     %
                     if(dJn*dJ>0.)
                         dJ=dJn;
                         k=nk;
                     else
                         dJb=dJn;
                         kb=nk;                         
                     end
                 end
                 lambda(i+1,n)=k;
                 n=n+1;
                 if(n==11)
                    break;
                 end  
              end
           end
       end
       dJb=dJ;
       kb=k;
   end
end   
%
kk=1;
for(i=1:3)
     for(j=1:3)
         lam=lambda(i,j)/R;
         f(i,j)=(1/tpi)*((lam*g)*tanh(lam*h));
         ii=i-1;
         if(i==1)
             jj=j;
         else
             jj=j-1;
         end
%%         out1=sprintf(' f=%8.4g Hz  lambda=%10.6g  i=%d j=%d',f(i,j),lambda(i,j),ii,jj);
%%         disp(out1);
         ff(kk,1)=f(i,j);
         ff(kk,2)=lambda(i,j);
         ff(kk,3)=ii;
         ff(kk,4)=jj;     
         kk=kk+1;
     end
end    
%
B = sortrows(ff,1);
%
kk=kk-1;
disp(' ');
disp(' i=number of node diameters ');
disp(' j=number of nodal circles ');
disp(' ');
disp(' Freq(Hz)      lambda        i   j  ');
for(i=1:kk)
    out1=sprintf(' %8.4g \t %10.6g \t %d \t %d',B(i,1),B(i,2),round(B(i,3)),round(B(i,4)));
    disp(out1);
end
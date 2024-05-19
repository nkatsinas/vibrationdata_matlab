disp(' ');
disp(' slosh_cylinder.m   ver 1.2   June 6, 2013 ');
disp(' by Tom Irvine ');
%
disp(' ');
disp(' This program calculates the slosh frequency inside ');
disp(' a cylindrical basin.');
disp(' ');
disp(' Assume');
disp(' 1. The liquid is homogeneous, inviscid, irrotational, & incompressible');  
disp(' 2. The boundaries of the basin are rigid ');   
disp(' 3. Small wave amplitudes, linear behavior');   
disp(' 4. The influence of the surrounding atmosphere is negligible');   
disp(' 5. The influence of surface tension is negligible');   
%
clear f;
clear g;
clear h;
clear D;
clear a;
clear b;
%
tpi=2*pi;
% 
disp(' ');
disp(' Enter acceleration of gravity (in/sec^2) ');
g=input(' ');
disp(' Enter the diameter (inch)');
D=input(' ');
disp(' Enter the liquid surface height (inch)');
h=input(' ');
R=D/2;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
term=inline('besselj(i-1,x)-(i/x)*besselj(i,x)','i','x');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
ib=5;
mj=4;
%
lambda=zeros(ib,mj);
%
for i=0:(ib-1)   % order
%
    j=0;
    dx=0.1;
    a=term(i,dx);
    for k=2:1000
        x=dx*k;
        b=term(i,x);
%
        if(abs(b)<1.0e-20)
              lambda(i+1,j+1)=root;
              j=j+1;
              break;
        end
%
        if((a*b)<0)
              x1=x-dx;
              x2=x;
              [root]=secant_method_sc(term,i,x1,x2);
              lambda(i+1,j+1)=root;
              j=j+1;
        end
        if(j==mj)
            break;
        end
        a=b;
%
    end
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
kk=1;
sz=size(lambda);
for i=0:(sz(1)-1)
%
     for j=0:(sz(2)-1)
         lam=lambda(i+1,j+1)/R;
         f(i+1,j+1)=(1/tpi)*sqrt((lam*g)*tanh(lam*h));
%
         ff(kk,1)=f(i+1,j+1);
         ff(kk,2)=lambda(i+1,j+1);
         ff(kk,3)=i;
         if(i==0)
            ff(kk,4)=j+1;                 
         else
            ff(kk,4)=j;     
         end
         kk=kk+1;
     end
end    
%
B = sortrows(ff,1);
%
kk=kk-1;
%
disp(' ');
disp(' i=number of nodal diameters ');
disp(' j=number of nodal circles ');
disp(' ');
disp(' Freq(Hz)      lambda           i      j  ');
for(i=1:16)
    out1=sprintf(' %8.4g \t %10.6g \t %d \t %d',B(i,1),B(i,2),round(B(i,3)),round(B(i,4)));
    disp(out1);
end
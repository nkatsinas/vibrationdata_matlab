disp(' ');
disp(' slosh_rectangular.m   ver 1.2   June 6, 2013 ');
disp(' by Tom Irvine ');
%
disp(' ');
disp(' This program calculates the slosh frequency inside ');
disp(' a rectangular basin.');
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
disp(' Enter length (inch)');
L=input(' ');
disp(' Enter width (inch)');
W=input(' ');
disp(' Enter height (inch)');
h=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(W>L)
    temp=L;
    L=W;
    W=temp;
end
%
f=zeros(7,7);
sz=size(f);
%
kk=1;
for i=0:(sz(1)-1)
%
     for j=0:(sz(2)-1)
         D=sqrt((i/L)^2+(j/W)^2);
%
         if(D>1.0e-20)
            f(i+1,j+1)=(1/(2*sqrt(pi)))*sqrt((D*g)*tanh(pi*h*D));
%
            ff(kk,1)=f(i+1,j+1);
            ff(kk,2)=D;
            ff(kk,3)=i;
            ff(kk,4)=j+1;                 
            ff(kk,4)=j;     
            kk=kk+1;
         end
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
disp(' Freq(Hz)     i    j  ');
for(i=1:10)
    out1=sprintf(' %8.4g     %d    %d',B(i,1),round(B(i,3)),round(B(i,4)));
    disp(out1);
end
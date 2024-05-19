%
%  plate_mass_stiff.m  ver 1.1  March 2, 2012
%
function[mass_local,stiff_local,area]=plate_mass_stiff(nodex,nodey,node1,node2,node3,node4,mu,beta,ijk)
%
    mass_local =zeros(12,12);
    stiff_local=zeros(12,12);
%
    a=abs(nodex(node1(ijk))-nodex(node2(ijk)));
    b=abs(nodey(node1(ijk))-nodey(node4(ijk)));
%
    x=a;
    y=b;
    area=a*b;
%
%%    out1=sprintf(' ijk=%d   a=%8.4g   b=%8.4g  ',ijk,a,b);
%%    disp(out1);
%
    xy   =x*y;
    x2y  =x^2*y;
    xy2  =x*y^2;
    x2y2 =x^2*y^2;
    xy3  =x*y^3;
    x3y  =x^3*y;
    x3y2 =x^3*y^2;
    x2y3 =x^2*y^3;
    x3y3 =x^3*y^3;
%
    mterm(1,1)=xy;

    mterm(1,2)=(x2y)/2;
    mterm(1,3)=(xy2)/2;

    mterm(1,4)=(x3y)/3;
    mterm(1,5)=(x2y2)/4;
    mterm(1,6)=(xy3)/3;

    mterm(1,7)=(x^4*y)/4;
    mterm(1,8)=(x3y2)/6;
    mterm(1,9)=(x2y3)/6;
    mterm(1,10)=(x*y^4)/4;

    mterm(1,11)=(x^4*y^2)/8;
    mterm(1,12)=(x^2*y^4)/8;
%
    mterm(2,2)=(x^3*y)/3;
    mterm(2,3)=(x^2*y^2)/4;

    mterm(2,4)=(x^4*y)/4;    
    mterm(2,5)=(x^3*y^2)/6;
    mterm(2,6)=(x^2*y^3)/6;

    mterm(2,7)=(x^5*y)/5;
    mterm(2,8)=(x^4*y^2)/8;
    mterm(2,9)=(x^3*y^3)/9;
    mterm(2,10)=(x^2*y^4)/8;

    mterm(2,11)=(x^5*y^2)/10;
    mterm(2,12)=(x^3*y^4)/12;
%
    mterm(3,3)=(x*y^3)/3;

    mterm(3,4)=(x^3*y^2)/6;
    mterm(3,5)=(x^2*y^3)/6;
    mterm(3,6)=(x*y^4)/4;

    mterm(3,7)=(x^4*y^2)/8;
    mterm(3,8)=(x^3*y^3)/9;
    mterm(3,9)=(x^2*y^4)/8;
    mterm(3,10)=(x*y^5)/5;

    mterm(3,11)=(x^4*y^3)/12;
    mterm(3,12)=(x^2*y^5)/10;
%
    mterm(4,4)=(x^5*y)/5;
    mterm(4,5)=(x^4*y^2)/8;
    mterm(4,6)=(x^3*y^3)/9;

    mterm(4,7)=(x^6*y)/6;
    mterm(4,8)=(x^5*y^2)/10;
    mterm(4,9)=(x^4*y^3)/12;
    mterm(4,10)=(x^3*y^4)/12;

    mterm(4,11)=(x^6*y^2)/12;
    mterm(4,12)=(x^4*y^4)/16;
%
    mterm(5,5)=(x^3*y^3)/9;
    mterm(5,6)=(x^2*y^4)/8;

    mterm(5,7)=(x^5*y^2)/10;
    mterm(5,8)=(x^4*y^3)/12;
    mterm(5,9)=(x^3*y^4)/12;
    mterm(5,10)=(x^2*y^5)/10;

    mterm(5,11)=(x^5*y^3)/15;
    mterm(5,12)=(x^3*y^5)/15;
%
    mterm(6,6)=(x*y^5)/5;

    mterm(6,7)=(x^4*y^3)/12;
    mterm(6,8)=(x^3*y^4)/12;
    mterm(6,9)=(x^2*y^5)/10;
    mterm(6,10)=(x*y^6)/6;

    mterm(6,11)=(x^4*y^4)/16;
    mterm(6,12)=(x^2*y^6)/12;
%
    mterm(7,7)=(x^7*y)/7;
    mterm(7,8)=(x^6*y^2)/12;
    mterm(7,9)=(x^5*y^3)/15;
    mterm(7,10)=(x^4*y^4)/16;

    mterm(7,11)=(x^7*y^2)/14;
    mterm(7,12)=(x^5*y^4)/20;
%
    mterm(8,8)=(x^5*y^3)/15;
    mterm(8,9)=(x^4*y^4)/16;
    mterm(8,10)=(x^3*y^5)/15;

    mterm(8,11)=(x^6*y^3)/18;
    mterm(8,12)=(x^4*y^5)/20;
%
    mterm(9,9)=(x^3*y^5)/15;
    mterm(9,10)=(x^2*y^6)/12;

    mterm(9,11)=(x^5*y^4)/20;
    mterm(9,12)=(x^3*y^6)/18;
%
    mterm(10,10)=(x*y^7)/7;

    mterm(10,11)=(x^4*y^5)/20;
    mterm(10,12)=(x^2*y^7)/14;
%
    mterm(11,11)=(x^7*y^3)/21;
    mterm(11,12)=(x^5*y^5)/25;
%
    mterm(12,12)=(x^3*y^7)/21;
%
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
   kterm1=zeros(12,12);
   kterm1a=zeros(12,12);
   kterm1b=zeros(12,12); 
   kterm2a=zeros(12,12);
   kterm2b=zeros(12,12);     
   kterm2=zeros(12,12);
   kterm3=zeros(12,12);   
%
   kterm1(4,4) =4*xy;            % 4
   kterm1(6,6) =kterm1(4,4);     % 4 
%
   kterm1(4,11)=3*x2y2;          % 12*x*y    
   kterm1(7,8) =kterm1(4,11);    % 12*x*y
   kterm1(6,12)=kterm1(4,11);    % 12*x*y
   kterm1(9,10)=kterm1(4,11);    % 12*x*y      
%
   kterm1(4,8) =2*xy2;          % 4*y    
   kterm1(6,9) =2*x2y;          % 4*x
%
   kterm1(4,7) =6*x2y;          % 12*x     
   kterm1(6,10)=6*xy2;          % 12*y
%
   kterm1(8,8) =(4/3)*xy3;    % 4*y^2   
   kterm1(9,9) =(4/3)*x3y;    % 4*x^2
%   
   kterm1(8,11)=2*x2y3;      % 12*x*y^2   
   kterm1(9,12)=2*x3y2;      % 12*x^2*y
%
   kterm1(7,7)  =12*x3y;      % 36*x^2   
   kterm1(10,10)=12*xy3;      % 36*y^2
%   
   kterm1(7,11) =6*x3y2;     % 36*x^2*y   
   kterm1(10,12)=6*x2y3;     % 36*x*y^2
%
   kterm1(11,11)=4*x3y3;        % 36*x^2*y^2
   kterm1(12,12)=kterm1(11,11); % 36*x^2*y^2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
   kterm2(4,6)   =kterm1(4,4);       % 4
   kterm2(4,9)   =kterm1(6,9);       % 4*x
   kterm2(4,10)  =kterm1(6,10);      % 12*y
   kterm2(4,12)  =kterm1(4,11);      % 12*x*y  
%
   kterm2(6,7)   =kterm1(4,7);       % 12*x
   kterm2(6,8)   =kterm1(4,8);       % 4*y
   kterm2(6,11)  =kterm1(4,11);      % 12*x*y  
%
   kterm2(7,9)   =4*x3y;             % 12*x^2
   kterm2(7,10)  =9*x2y2;            % 36*x*y
   kterm2(7,12)  =kterm1(7,11);      % 36*x^2*y   
%
   kterm2(8,9)   =x2y2;              % 4*x*y
   kterm2(8,10)  =4*xy3;             % 12*y^2
   kterm2(8,12)  =kterm1(9,12);      % 12*x*y^2  
%
   kterm2(9,11)  =kterm1(9,12);      % 12*x^2*y  
%
   kterm2(10,11) =kterm1(10,12);     % 36*x*y^2  
%
   kterm2(11,12) =kterm1(11,11);     % 36*x^2*y^2 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
   kterm3(5,5)  =xy;        % 1 
   kterm3(5,8)  =x2y;       % 2x   
   kterm3(5,9)  =xy2;       % 2y    
   kterm3(5,11) =x3y;       % 3x^2       
   kterm3(5,12) =xy3;       % 3y^2       
%
   kterm3(8,8)  =kterm1(9,9);    % 4x^2    
   kterm3(8,9)  =x2y2;           % 4*x*y       
   kterm3(8,11) =(6/4)*x^4*y;    % 6*x^3
   kterm3(8,12) = x2y3;          % 6*x*y^2   
%
   kterm3(9,9)  =kterm1(8,8);    % 4y^2    
   kterm3(9,11) =x3y2;           % 6*x^2*y       
   kterm3(9,12) =(6/4)*y^4*x;    % 6*y^3   
%
   kterm3(11,11) =(9/5)*x^5*y;   % 9*x^4    
   kterm3(11,12) = x3y3;         % 9*x^2*y^2
%   
   kterm3(12,12) =(9/5)*x*y^5;   % 9*y^4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for(i=1:12)
    for(j=i+1:12)
         mterm(j,i)=mterm(i,j);
        kterm1(j,i)=kterm1(i,j);
        kterm2(j,i)=kterm2(i,j);
        kterm3(j,i)=kterm3(i,j);
    end
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%
    B=zeros(12,12);
%
    a2=a^2;
    b2=b^2;
    a3=a^3;
    b3=b^3;    
%
    B(1,1)=1;
    B(4,1)=1;
    B(7,1)=1;
    B(10,1)=1;
%
    B(2,2)=1;
    B(4,2)=a;
    B(5,2)=1;
    B(7,2)=a;
    B(8,2)=1;
    B(11,2)=1;
%
    B(3,3)=1;
    B(6,3)=1;
    B(7,3)=b;
    B(9,3)=1;
    B(10,3)=b;
    B(12,3)=1;
%
    B(4,4)=a2;
    B(5,4)=2*a;
    B(7,4)=a2;
    B(8,4)=2*a;
%
    B(6,5)=a;
    B(7,5)=a*b;
    B(8,5)=b;
    B(9,5)=a;
    B(11,5)=b;
%
    B(7,6)=b2;
    B(9,6)=2*b;
    B(10,6)=b2;
    B(12,6)=2*b;
%
    B(4,7)=a3;
    B(5,7)=3*a2;
    B(7,7)=a3;
    B(8,7)=3*a2;
%
    B(6,8)=a2;
    B(7,8)=a2*b;
    B(8,8)=2*a*b;
    B(9,8)=a2;
%
    B(7,9)=a*b2;
    B(8,9)=b2;
    B(9,9)=2*a*b;
    B(11,9)=b2;
%
    B(7,10)=b3;
    B(9,10)=3*b2;
    B(10,10)=b3;
    B(12,10)=3*b2;
%
    B(6,11)=a3;
    B(7,11)=a3*b;
    B(8,11)=3*a2*b;
    B(9,11)=a3;
%
    B(7,12)=a*b3;
    B(8,12)=b3;
    B(9,12)=3*a*b2;
    B(11,12)=b3;
%
    c=inv(B);
%
%%%
%
     kterm=kterm1+mu*kterm2+beta*kterm3;
%
     mass_local=c'*mterm*c;
    stiff_local=c'*kterm*c;
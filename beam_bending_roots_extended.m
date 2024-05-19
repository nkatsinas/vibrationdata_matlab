%
%  beam_bending_roots.m  ver 1.0  by Tom Irvine
%

function[root]=beam_bending_roots(LBC,RBC)

n=16;

root=zeros(n,1);

if((LBC==1 && RBC==1)||((LBC==3 && RBC==3))) % fixed-fixed or free-free
    root(1)=4.73004;
    root(2)=7.8532;
    root(3)=10.9956;
    root(4)=14.13717;
    root(5)=17.27876;
    
    for j=6:n
       root(j)=(2*j+1)*pi/2;  
    end
         
end
if((LBC==1 && RBC==2) || (LBC==2 && RBC==1)) % fixed-pinned
    root(1)=3.9266;
    root(2)=7.0686;
    root(3)=10.2102;
    root(4)=13.3518;
    root(5)=16.4934;  
 
    
    for j=6:n
       root(j)=(j+0.25)*pi;  
    end
    
end
if((LBC==1 && RBC==3) || (LBC==3 && RBC==1)) % fixed-free
    root(1)=1.87510;
    root(2)=4.69409;
    root(3)=7.85476;
    root(4)=10.99554;
    
    for j=5:n
       root(j)=(2*j-1)*pi/2;  
    end
    
end
if(LBC==2 && RBC==2) % pinned-pinned
    for i=1:n
        root(i)=i*pi;
    end
end
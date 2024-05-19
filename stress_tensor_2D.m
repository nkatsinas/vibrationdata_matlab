
%  stress_tensor_2D.m  ver 1.0  by Tom Irvine

function[pstress]=stress_tensor_2D(sx,sy,txy)

ss=size(sx);

NT=ss(1);

pstress=zeros(NT,2);
    
for i=1:NT
        
    q1=(sx(i)+sy(i))/2;
    q2=sqrt( ((sx(i)-sy(i))/2).^2 + txy(i).^2 );  
    
    s1= q1+q2;
    s2= q1-q2; 
    
    pstress(i,:)=[s1 s2];
        
end
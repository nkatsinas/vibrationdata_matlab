
%  von_Mises_Tresca_plane_stress.m  ver 1.2  by Tom Irvine

function[vM,Tr,pstress1,pstress2]=von_Mises_Tresca_plane_stress(sxx,syy,txy)
        
vM=sqrt( sxx.^2 + syy.^2 - sxx.*syy + 3*txy.^2 );
      
q1=(sxx+syy)/2;
q2=sqrt( ((sxx-syy)/2).^2 + txy.^2 );  
    
pstress1= q1+q2;
pstress2= q1-q2; 


n=length(sxx);

Tr=zeros(n,1);

for i=1:n
    Tr(i)=max([  abs( pstress1(i)-pstress2(i) ) , abs(pstress1(i)) ,   abs(pstress2(i)) ]);
end    

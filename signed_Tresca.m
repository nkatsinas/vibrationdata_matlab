
%  signed_Tresca.m  ver 1.1  by Tom Irvine

function[str]=signed_Tresca(pstress)

ss=size(pstress);

nc=ss(2);

if(nc==2 || nc==3)
else
    errordlg(' Column error');
    return;
end

[polarity]=signed_stress_polarity(pstress);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s1=pstress(:,1);
s2=pstress(:,2); 

if(nc==2)
    
    n=length(s1);
    
    ts=zeros(n,1);
    
    for i=1:n
        ts(i)=max([ abs(s1(i)-s2(i)) , abs(s1(i)) , abs(s2(i)) ]);
    end    
        
end

if(nc==3)
    s3=pstress(:,3);   
    tarray= [ abs(s1-s3)  abs(s1-s2)  abs(s2-s3)  ];
    
    ts=max(tarray,[],2);
    
end


str=polarity.*ts; 
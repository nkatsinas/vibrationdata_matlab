
%  signed_von_Mises.m  ver 1.0  by Tom Irvine

function[svm]=signed_von_Mises(pstress)

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
    sv=sqrt(s1.^2-s1.*s2+s2.^2);
end

if(nc==3)
    s3=pstress(:,3);   
    
    a=  (s1-s2).^2 + (s1-s3).^2   + (s2-s3).^2   ;
    
    sv=sqrt(a/2);
end

svm=polarity.*sv; 
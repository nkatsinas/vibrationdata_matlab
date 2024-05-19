
%  signed_stress_polarity.m  ver 1.0  by Tom Irvine

function[polarity]=signed_stress_polarity(pstress)

ss=size(pstress);

nr=ss(1);

qqq=abs(pstress);
    
[~, maxindices] = max(qqq,[], 2);
    
polarity=zeros(nr,1);
for kv=1:nr
    polarity(kv)=sign(pstress(kv,maxindices(kv)));
end 
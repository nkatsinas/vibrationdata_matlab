%  
%    find_mo_freq.m  ver 1.1  by Tom Irvine
%
function[a_fmo,index]=find_mo_freq(fc,a_mo)
%
index=0;

nfc=length(fc);

for i=1:nfc
    if(a_mo(i)<1)
       index=i;
    end
end

j=index+1;

if(j>nfc)
    j=nfc;
    index=nfc;
end

a_fmo=fc(j);

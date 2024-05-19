% elma

clear ff;
clear gg;

a=-6.15
b=2.33
c=2.91
d=11.87
%
fcr=1000
%
k=1;
%

for i=1:20000
    
    f=i;
   
    ratio=f/fcr;
    
    if( 0.01 <= ratio && ratio < 0.3)
        ff(k)=f;
        gg(k)=a+b*(ratio);
        k=k+1;
    end
    if( 0.3 <= ratio && ratio <= 0.9)
        ff(k)=f;
        gg(k)=c+d*log(ratio);
        k=k+1; 
    end    
    
end

gg=10*log10(gg);

figure(1);
plot(ff,gg);
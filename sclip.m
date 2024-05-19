sz=size(sine);

sine_zp8=sine;

L=0.8*max(abs(sine(:,2)));

for i=1:sz(1)
    if(sine_zp8(i,2)>L)
        sine_zp8(i,2)=L;
    end    
    if(sine_zp8(i,2)<-L)
        sine_zp8(i,2)=-L;
    end         
end

sine_zp6=sine;

L=0.6*max(abs(sine(:,2)));

for i=1:sz(1)
    if(sine_zp6(i,2)>L)
        sine_zp6(i,2)=L;
    end    
    if(sine_zp6(i,2)<-L)
        sine_zp6(i,2)=-L;
    end         
end
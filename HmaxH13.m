

H13=6.;

No=56186;

i=1;

disp(' ');
disp('  mu   ratio ');
disp('  ');

while(1)
    
    mu=0.5-(i/400);
    
    if(mu<=0 || mu>=1)
        break;
    else
       
        num=No;
        den=log(1/(1-mu));
       
        ratio=0.706*sqrt(log(num/den));
        
        out1=sprintf('%5.3f  %5.3f',mu,ratio);
        disp(out1);
    end
    
    i=i+1;
    
end

disp(' ');

mu=1/40

num=No;
den=log(1/(1-mu));
       
ratio=0.706*sqrt(log(num/den));
        
out1=sprintf('%5.3f  %5.3f',mu,ratio);
disp(out1);

H13=10*ratio
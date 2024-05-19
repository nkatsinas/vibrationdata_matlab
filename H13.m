

H13=6.;

No=500;

i=0;

disp(' ');
disp('  mu   ratio ');
disp('  ');

while(1)
    
    mu=0.5+ i/50;
    
    if(mu>=1)
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
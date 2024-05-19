

%  k_factor.m  ver 1.0  by Tom Irvine  

function[k,Zp,delta,T]=k_factor(p,c,nsamples)

x = (-150:0.005:150)';


nu=nsamples-1;

prob=p/100;
confidence=c/100; 


    pn = normcdf(x);
    [~,i]=min(abs(pn-prob));
    Zp=x(i);

    delta=sqrt(nsamples)*Zp;

    p = nctcdf(x,nu,delta);


    [~,i]=min(abs(p-confidence));
    T=x(i);

  
k=T/sqrt(nsamples);






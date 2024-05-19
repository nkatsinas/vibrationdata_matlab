
%
%  k_factor_alt.m  ver 1.0  by Tom Irvine 
%
%  k factor for one-sided normal tolerance limit
%
%  p=probability percent  
%  c=confidence percent
%  nsamples=number of samples
%

function[k,Zp,delta,T]=k_factor_alt(p,c,nsamples)

k=0;
Zp=0;
delta=0;
T=0;

nu=nsamples-1;

prob=p/100;
confidence=c/100; 


x1=-20;
[pn1]= normcdf(x1);
pn1=pn1-prob;

x3=10;
[pn3]=normcdf(x3);
pn3=pn3-prob;


for i=1:200
    
    m=(pn3-pn1)/(x3-x1);
    d=pn1-m*x1;
%
    x2=-d/m;
  
    [pn2]=normcdf(x2);
    pn2=pn2-prob;
    Zp=x2;

    fprintf(' %d   %8.4g   %8.4g  \n',i,x2,pn2);    

    if(abs(pn1)<1.0e-06)
        Zp=x1;
        break;
    end    
    if(abs(pn2)<1.0e-06)
        Zp=x2;
        break;
    end
    if(abs(pn3)<1.0e-06)
        Zp=x3;
        break;
    end    
    
    if((pn1*pn2)<0)
        x3=x2;
        pn3=pn2;
    else
        x1=x2;
        pn1=pn2;        
    end
    

end

delta=sqrt(nsamples)*Zp;


return;






x1=-500;
[p1]=cdf_functions(prob,nu,x1);
p1=p1-confidence;

x3=500;
[p3]=cdf_functions(prob,nu,x3);
p3=p3-confidence;



for i=1:10
    
    m=(p3-p1)/(x3-x1);
    d=p1-m*x1;
%
    x2=-d/m;
    T=x2;
  
    [p2]=cdf_functions(prob,nu,x2);
    p2=p2-confidence;

    fprintf(' %d   %8.4g   %8.4g  \n',i,x2,p2);    

    if(abs(p1)<1.0e-05)
        T=x1;
        break;
    end    
    if(abs(p2)<1.0e-05)
        T=x2;
        break;
    end
    if(abs(p3)<1.0e-05)
        T=x3;
        break;
    end    
    
    if((x1*x2)<0)
        x3=x2;
        p3=p2;
    else
        x1=x2;
        p1=p2;        
    end

end


k=T/sqrt(nsamples);

end

function[p]=cdf_functions(prob,nu,x)

    pn = normcdf(x);
    [~,i]=min(abs(pn-prob));
    Zp=x(i);

    delta=sqrt(nsamples)*Zp;

    p = nctcdf(x,nu,delta);

end


%
%  tolerance_factor_core_alt.m  ver 1.0  by Tom Irvine  
%
%
% Tvd = abscissa value corresponding to the cumulative area under
%       the noncentral t-distribution curve with the confidence  
%       level gamma
%
%  Zp = Z-value abscissa corresponding to the cumulative probability
%       are p under the normal distribution curve
%
%    d = noncentrality parameter
%
%    n = number of samples
%
%    v = degrees-of-freedom
%

function[k,Zp,mu]=tolerance_factor_core_alt(p,c,nsamples)

%

v=nsamples-1;

 prob=p/100;
   mu=c/100; 
 
%

[Zp,d]=Zp_d_calcuation(prob,nsamples);

[Tvd]=Tvd_calculation(mu,v);
 
k=Tvd/sqrt(nsamples);

out1=sprintf('\n  Zp=%8.5g  d=%8.5g k=%8.5g\n',Zp,d,k);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[Tvd]=Tvd_calculation(mu,v)

[phi]=normal_CDF(-mu);


% fix here.............................

Fhat=phi;

Tvd=Fhat;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[Zp,d]=Zp_d_calcuation(prob,nsamples)

x1=-10;
y1=normal_CDF(x1);
x2=0;
y2=normal_CDF(x2);
x3=10;
y3=normal_CDF(x3);


for i=1:1000
    
    if(prob==y2)
        break;
    end
    if(prob<y2)
        x3=x2;
        y3=y2;
        x2=(x2+x1)/2;
    end
    if(prob>y2)
        x1=x2;
        y1=y2;
        x2=(x3+x2)/2;
    end
    y2=normal_CDF(x2);
    
    if((x3-x1)<1.0e-06)
        break;
    end

end

Zp=x2;

d = sqrt(nsamples)*Zp;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function[y]=normal_CDF(x)

y = (1/2)*(1+erf(x/sqrt(2)));







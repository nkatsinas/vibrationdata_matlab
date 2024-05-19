

% Dirlik_pdf.m  ver 1.0  by Tom Irvine


function[pdf,cumu,S]=Dirlik_pdf(m0,D1,D2,D3,Q,R,ds,EP,T,n)  

%

S=(linspace(1,n,n)-1)*ds;

Z=S/(2*sqrt(m0));
pn= (D1/Q)*exp(-Z/Q) + (D2*Z/R^2).*exp(-Z.^2/(2*R^2))  + D3*Z.*exp(-Z.^2/2);

pd=2*sqrt(m0);
p=pn/pd;
            
N=p*EP*T;
pdf=N;
                 
            
cumu=ds*cumsum(N);
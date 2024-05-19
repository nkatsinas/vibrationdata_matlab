
% p9550.m  ver 1.1  by Tom Irvine

function[p9550,p9550_lognormal]=p9550_function(A)

p=95;
c=50;

sz=size(A);
nsamples=sz(2);
nfreq=sz(1);

[k,lambda_int,Z,mu]=tolerance_factor_core(p,c,nsamples);

p9550=zeros(nfreq,1);
p9550_lognormal=zeros(nfreq,1);

B=A*0;

for i=1:nfreq
    
    B(i,:)=log10(A(i,:));
   
    m=mean(A(i,:));
    s=std(A(i,:));
    
    p9550(i)=m + k*s;
    
    mlog=mean(B(i,:));
    slog=std(B(i,:));
    
    p9550_lognormal(i)=10^(mlog + k*slog);
        
end
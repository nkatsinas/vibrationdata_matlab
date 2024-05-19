%
%  sn_curve_fit_plot.m  ver 1.0  by Tom Irvine
%
function[NN,SS]=sn_curve_fit_plot(num,SN,R,Pr,Ar,Br,Cr)
%
N=SN(:,1);
%
noct=log(N(num)/N(1))/log(2);

mn=1+round(noct*3);

SS=zeros(mn,1);
NN=zeros(mn,1);

f=N(1);

for j=1:mn
        NN(j)=f;
        
        w=(log10(NN(j))-Ar)/(-Br);
        Seq=10^w+Cr;
        
        rr=(1-R)^Pr;
        
        SS(j)=Seq/rr;
        
        f=f*2^(1/3);
end

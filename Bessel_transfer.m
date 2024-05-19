function[fH,H]=Bessel_Transfer(typ,fc,freq,nyq,L);
%
disp(' Bessel_Transfer.m   ver 1.0   June 27, 2007')
%
clear H;
clear G;
clear G1;
clear G2;
clear fH;
clear A;
tpi=2*pi;
disp(' ')
%
dzero=(factorial(2*L))/((2^L)*factorial(L));
%
%  The following coefficiences are for "Reference Only."
%  They are not used directly in the transfer function calculation.
%
% sc=complex(sr,si)';
%
for(i=1:nyq)
    s=complex(0,(freq(i)/fc));
    if(typ==2)
        s=1/s;
    end
    B(1)=1;
    B(2)=s+1;
    for(j=3:L+1)
        B(j)=(2*L-1)*B(j-1) + s^2*B(j-2);
    end
    H(i)=dzero/B(L+1);
    fH(i)=freq(i); 
end
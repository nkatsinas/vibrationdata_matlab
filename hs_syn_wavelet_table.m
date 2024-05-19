

%  hs_syn_wavelet_table.m  ver 1.0  by Tom Irvine


function[wavelet_table]=hs_syn_wavelet_table(nfr,ffmin,tp,x1r,x2r,x3r,x4r)
%
    tpi=2*pi;

    wavelet_table=zeros(nfr,5);

    for i=1:nfr
%
        if(x2r(i)<ffmin*tp)
                x2r(i)=ffmin*tp;
                x1r(i)=1.0e-20;
                x3r(i)=3;
                x4r(i)=0;
        end
%
		out1=sprintf(' amp=%10.4f   freq=%10.3f Hz   nhs=%d   delay=%10.4f ',x1r(i),x2r(i)/tp,x3r(i),x4r(i));
        disp(out1);
%
        wavelet_table(i,1)=i;
        wavelet_table(i,2)=x2r(i)/tpi;           
        wavelet_table(i,3)=x1r(i);
        wavelet_table(i,4)=x3r(i); 
        wavelet_table(i,5)=x4r(i);              
%
    end
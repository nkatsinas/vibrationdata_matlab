%
%    wavelet_lsf_function.m  ver 1.1  by Tom Irvine
%
%
function[x1]=wavelet_lsf_function(Y,Z)
%
    Y=fix_size(Y);
%
    ZZ=Z'*Z;
%
    x1=0;

    if(cond(ZZ)<1.0e+15)
%
        x1=ZZ\(Z'*Y);
   
    end     
%
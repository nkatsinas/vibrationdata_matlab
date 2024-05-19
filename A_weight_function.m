
%  A_weight_function.m  ver 1.0  by Tom Irvine


function[Aw]=A_weight_function(f)

% https://en.wikipedia.org/wiki/A-weighting
% function realization method

    [RA]=RAA(f);
    
    RA1000=RAA(1000);
    
    Aw=20*log10(RA)-20*log10(RA1000);

end

function [RA]=RAA(f)
    num=12194^2*f^4;
    f2=f^2;
    A=f2+20.6^2;
    B=f2+107.7^2;
    C=f2+737.9^2;
    D=f2+12194^2;
    den=A*sqrt(B*C)*D;
    RA=num/den;
end
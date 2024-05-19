
% https://en.wikipedia.org/wiki/A-weighting
% function realization method

f=input(' Enter Frequency (Hz) ');

[RA]=RAA(f);

RA1000=RAA(1000);

A=20*log10(RA)-20*log10(RA1000)

function[RA]=RAA(f)

    num=12194^2*f^4;
    f2=f^2;
    A=f2+20.6^2;
    B=f2+107.7^2;
    C=f2+737.9^2;
    D=f2+12194^2;
    den=A*sqrt(B*C)*D;

    RA=num/den;

end
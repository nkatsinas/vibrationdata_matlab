
% frequencies_octave_spaced.m  ver 1.0 by Tom Irvine

function[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N)

tpi=2*pi;
%
noct=log(fmax/fmin)/log(2);
np=round(noct*N);
%
freq=zeros(np,1);
%
R=2^(1/N);
%
freq(1)=fmin;
i=2;
while(1)
    freq(i)=freq(i-1)*R;
    if(freq(i)>=fmax)
        freq(i)=fmax;
        break;
    end
    i=i+1;
end

np=length(freq);
%
omega=tpi*freq;

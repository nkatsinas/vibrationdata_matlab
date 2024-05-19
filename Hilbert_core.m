   
%  Hilbert_core.m  ver 1.0  by Tom Irvine

function[t_real,t_imag]=Hilbert_core(tim,amp)
    
    n=length(tim);

    dur=tim(end,1)-tim(1,1);
    dt=dur/(n-1);
    sr=1/dt;

    df=1/(n*dt);
    nhalf=floor(n/2);

    [z,zz,f_real,f_imag,ms,freq,ff]=fourier_core(n,nhalf,df,amp);

%    z=fix_size(z);
%    zz=fix_size(zz);
%    freq=fix_size(freq);
%    ff=fix_size(ff);
    
    f_imag=fix_size(f_imag);
    f_real=fix_size(f_real);

%    phase=atan2(f_imag,f_real);
%    phase=fix_size(phase);
%    phase = phase*180/pi;

%    magnitude_FT=[ff zz];
%    magnitude_phase_FT=[ff zz phase(1:length(ff))];
%    complex_FT=[freq f_real f_imag];
    
    frf=zeros(n,1);
    for i=2:nhalf
        frf(i)=(f_real(i)+(1i)*f_imag(i));
    end

    frf=2*frf;
    [t_real,t_imag]=inverse_fourier_transform(frf,n);
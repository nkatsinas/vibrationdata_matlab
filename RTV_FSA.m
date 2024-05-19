
%
Dgm=52;
%

FS = 'elcentro_NS_FT';
THM=evalin('caller',FS);


freq=THM(:,1);
df=mean(diff(freq));
y=THM(:,2);

num=length(freq);

Q=10;
damp=1/(2*Q);

% Apply the SDOF transfer function.  then spectral moment calculation.

fstart=0.1;
fend=10;

noct=ceil(6*log2(fend/fstart));

fn=zeros(noct,1);
fn(1)=fstart;

for i=2:noct
    fn(i)=fn(i-1)*2^(1/6);
end


amax=zeros(noct,1);

for i=1:noct

    xr=zeros(num,1);

    for j=1:num
        [accel_complex,rd_complex,accel_mag,rd_mag]=...
                                          sdof_trans_base(freq(j),fn(i),damp);

        xr(j)=y(j)*2*accel_mag;
    end

    x_psd=xr.^2/df;

    [EP,vo,m0,m1,m2,m4,alpha2,e]=spectal_moments_alt(freq,x_psd,df);

    Ne=Dgm*(sqrt(m4/m2))/pi;
    e=sqrt(m2^2/(m0*m4));

    fun = @(x) (   1-(1-e*exp(-x.^2)).^Ne  );
    pf = sqrt(2)*integral(fun,0,Inf);

    To=1/fn(i);
    Do=To/(2*pi*damp);
    n=3;
    alpha=1/3;
    
    gamma=Dgm/To;
    
    A=gamma^n;
    B=A+alpha;

    Drms=Dgm+Do*(A/B);

    ms=0;

    for j=1:num
        ms=ms+ (xr(j)/sqrt(2))^2;
    end

    arms=sqrt(ms);

    amax(i)=pf*arms;

end

fn=fix_size(fn);
amax=fix_size(amax);

asrs=[fn amax];

fig_num=1;
ppp=asrs;
x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
t_string='SRS Q=10';
fmin=fstart;
fmax=fend;
[fig_num,h2]=plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);

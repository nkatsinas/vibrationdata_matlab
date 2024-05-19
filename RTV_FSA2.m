
%
Dgm=60;
%

FS = 'wpsd';
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

clear fn
fn=2;


amax=zeros(noct,1);

for i=1:1

    xr=zeros(num,1);

    for j=1:num
        [accel_complex,rd_complex,accel_mag,rd_mag]=...
                                          sdof_trans_base(freq(j),fn(i),damp);

        xr(j)=y(j)*accel_mag^2;
    end

   
    [EP,vo,m0,m1,m2,m4,alpha2,e]=spectal_moments_alt(freq,xr,df);

        Ne=Dgm*(sqrt(m4/m2))/pi;
    e=sqrt(m2^2/(m0*m4));

    fun = @(x) (   1-(1-e*exp(-x.^2)).^Ne  );
    pf = sqrt(2)*integral(fun,0,Inf);
end

sqrt(m0)
sqrt(m0)*pf

    To=1/fn(1);
    Do=To/(2*pi*damp);
    n=3;
    alpha=1/3;
    
    gamma=Dgm/To;
    
    A=gamma^n;
    B=A+alpha;

    Drms=Dgm+Do*(A/B)
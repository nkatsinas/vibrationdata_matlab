%
%   add_pre_post_shock.m  ver 1.0  Tom Irvine
%
function[signal]=add_pre_post_shock(store,residual,dt)
%
nm=max(size(store));
%
dur=nm*dt;
%
tstart=dur/20;
%
npre=round(tstart/dt);
%
nresidual=floor(residual/dt);
%
ntotal=nm+npre+nresidual;
%
tt=zeros(ntotal,1);
temp=zeros(ntotal,1);
%
%
for i=1:ntotal
    tt(i)=-tstart+(i-1)*dt;
end

i1=npre+1;
i2=i1+nm-1;

temp(i1:i2)=store(1:nm);

%
signal=[tt temp];

%
%   add_pre_shock.m  ver 1.0  December 21, 2012
%
function[signal]=add_pre_shock(store,dur,dt)
%
nm=max(size(store));
%
tstart=dur/20;
%
npre=round(tstart/dt);
%
ntotal=nm+npre;
%
clear temp;
%
tt=zeros(ntotal,1);
temp=zeros(ntotal,1);
%
ijk=1;
%
for i=1:ntotal
    tt(i)=-tstart+(i-1)*dt;
    if(i>npre)
        temp(i)=store(ijk);
        ijk=ijk+1;
    end
end
%
tt=fix_size(tt);
temp=fix_size(temp);
%
signal=[tt temp];

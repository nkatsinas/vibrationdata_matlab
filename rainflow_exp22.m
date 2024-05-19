clear a;
clear fn;
clear d6L;
clear d10L;
clear mean;

T=300;
sr=10000;

np=T*sr;

dt=1/sr;

mu=0;
sigma=1;


Q=10;

nt=100;


oct=1/12;

fn(1)=10;
fend=2000;

fmax=sr/8;

if fn(1)>sr/30.
    fn(1)=sr/30.;
end

%
j=1;
while(1)
    if (fn(j) > sr/8. || fn(j)>fend)
        break
    end
    fn(j+1)=fn(1)*(2. ^ (j*oct));
    j=j+1;
end

fn(end)=2000;

nf=length(fn);

d6L=zeros(nt,nf);
d10L=zeros(nt,nf);

d6L_mean=zeros(nf,1);
d10L_mean=zeros(nf,1);

d6L_std=zeros(nf,1);
d10L_std=zeros(nf,1);

d6L_max=zeros(nf,1);
d10L_max=zeros(nf,1);

d6L_min=zeros(nf,1);
d10L_min=zeros(nf,1);

progressbar;

for ijk=1:nf
    
 progressbar(ijk/nf);    

    for i=1:nt
        
       

        [a] = normrnd(mu,sigma,[np 1]);
        [accel_resp]=sdof_response_engine(fn(ijk),Q,a,dt);
    
        c=rainflow(accel_resp);

        cycles=c(:,1);
        amp=c(:,2)/2;
        d6L(i,ijk)=log10(sum( cycles.*amp.^6 ));    
        d10L(i,ijk)=log10(sum( cycles.*amp.^10 ));
    end    
    
    
    d6L_mean(ijk)=mean(d6L(:,ijk));
    d10L_mean(ijk)=mean(d10L(:,ijk));

    d6L_std(ijk)=std(d6L(:,ijk));
    d10L_std(ijk)=std(d10L(:,ijk));

    d6L_max(ijk)=max(d6L(:,ijk));
    d10L_max(ijk)=max(d10L(:,ijk));

    d6L_min(ijk)=min(d6L(:,ijk));
    d10L_min(ijk)=min(d10L(:,ijk));    
    

end

progressbar(1);











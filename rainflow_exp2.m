clear a;
clear fn;
clear d4L;
clear d8L;
clear mean;

T=300;
sr=10000;

np=T*sr;

dt=1/sr;

mu=0;
sigma=1;


Q=10;

nt=200;


oct=1/24;

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

d4L=zeros(nt,nf);
d6L=zeros(nt,nf);
d8L=zeros(nt,nf);
d10L=zeros(nt,nf);

d4L_mean=zeros(nf,1);
d6L_mean=zeros(nf,1);
d8L_mean=zeros(nf,1);
d10L_mean=zeros(nf,1);

d4L_std=zeros(nf,1);
d6L_std=zeros(nf,1);
d8L_std=zeros(nf,1);
d10L_std=zeros(nf,1);

m0=zeros(nf,1);
m1=zeros(nf,1);
m2=zeros(nf,1);
m4=zeros(nf,1);

base_psd=[10 1e-04; 5000 1e-04];
df=1;
new_freq=(10:5000);

kk=0;
tt=nf*nt;

progressbar;

for i=1:nt  
    
    [a]=synthesize_psd(base_psd,np,dt);    
 
    for ijk=1:nf
        
         kk=kk+1;
         progressbar(kk/tt);
         
         if(i==1)
            [response_psd]=sdof_psd_response_base_nofig(fn(ijk),Q,base_psd);
            f=response_psd(:,1);
            a=response_psd(:,2);
            [fi,ai] = interpolate_PSD_arbitrary_frequency_f(f,a,new_freq);
            [EP,vo,m0(ijk),m1(ijk),m2(ijk),m4(ijk)]=spectal_moments(fi,ai,df);
         end

%        [a] = normrnd(mu,sigma,[np 1]);

        [accel_resp]=sdof_response_engine(fn(ijk),Q,a,dt);
    
        c=rainflow(accel_resp);

        cycles=c(:,1);
        amp=c(:,2)/2;
        d4L(i,ijk)=log10(sum( cycles.*amp.^4 ));    
        d6L(i,ijk)=log10(sum( cycles.*amp.^6 ));
        d8L(i,ijk)=log10(sum( cycles.*amp.^8 ));    
        d10L(i,ijk)=log10(sum( cycles.*amp.^10 ));        
    end        

end

for ijk=1:nf
    d4L_mean(ijk)=mean(d4L(:,ijk));
    d6L_mean(ijk)=mean(d6L(:,ijk));
    d8L_mean(ijk)=mean(d8L(:,ijk));
    d10L_mean(ijk)=mean(d10L(:,ijk));    

    d4L_std(ijk)=std(d4L(:,ijk));
    d6L_std(ijk)=std(d6L(:,ijk));
    d8L_std(ijk)=std(d8L(:,ijk));
    d10L_std(ijk)=std(d10L(:,ijk));
   
end

progressbar(1);











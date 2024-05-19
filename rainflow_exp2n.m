clear a;
clear fn;

clear d4n;
clear d6n;
clear d8n;
clear d10n;

clear d4n_mean;
clear d6n_mean;
clear d8n_mean;
clear d10n_mean;

clear d4n_std;
clear d6n_std;
clear d8n_std;
clear d10n_std;


clear mean;

T=300;
sr=20000;

np=T*sr;

dt=1/sr;

mu=0;
sigma=1;


Q=10;

nt=500;

oct=1/24;

fn(1)=10;
fend=2000;

if fn(1)>sr/30.
    fn(1)=sr/30.;
end

%
j=1;
while(1)
    if (fn(j) > sr/4. || fn(j)>fend)
        break
    end
    fn(j+1)=fn(1)*(2. ^ (j*oct));
    j=j+1;
end

fn(end)=fend;

nf=length(fn);

d4n=zeros(nt,nf);
d6n=zeros(nt,nf);
d8n=zeros(nt,nf);
d10n=zeros(nt,nf);

d4n_mean=zeros(nf,1);
d6n_mean=zeros(nf,1);
d8n_mean=zeros(nf,1);
d10n_mean=zeros(nf,1);

d4n_std=zeros(nf,1);
d6n_std=zeros(nf,1);
d8n_std=zeros(nf,1);
d10n_std=zeros(nf,1);

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
    
    [ath]=synthesize_psd_alt(base_psd,np,dt);    
 
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

        [accel_resp]=sdof_response_engine(fn(ijk),Q,ath,dt);
    
        c=rainflow(accel_resp);

        cycles=c(:,1);
        amp=c(:,2)/2;
        d4n(i,ijk)=(sum( cycles.*amp.^4 ));    
        
        fprintf(' %d %d %8.4g %8.4g %8.4g\n',i,ijk,std(accel_resp),d4n(i,ijk),fn(ijk))
        
        
        d6n(i,ijk)=(sum( cycles.*amp.^6 ));
        d8n(i,ijk)=(sum( cycles.*amp.^8 ));    
        d10n(i,ijk)=(sum( cycles.*amp.^10 ));        
    end        

end

for ijk=1:nf
    d4n_mean(ijk)=mean(d4n(1:nt,ijk));
    d6n_mean(ijk)=mean(d6n(1:nt,ijk));
    d8n_mean(ijk)=mean(d8n(1:nt,ijk));
    d10n_mean(ijk)=mean(d10n(1:nt,ijk));    

    d4n_std(ijk)=std(d4n(1:nt,ijk));
    d6n_std(ijk)=std(d6n(1:nt,ijk));
    d8n_std(ijk)=std(d8n(1:nt,ijk));
    d10n_std(ijk)=std(d10n(1:nt,ijk));
   
end

progressbar(1);

clear ss4;
clear ss6;
clear ss8;
clear ss10;


ss4=zeros(nf,2);
ss6=zeros(nf,2);
ss8=zeros(nf,2);
ss10=zeros(nf,2);


    for i=1:nf
        cft=fn(i)*T;

        p4=d4n_std(i)/d4n_mean(i);
        p6=d6n_std(i)/d6n_mean(i);
        p8=d8n_std(i)/d8n_mean(i);
        p10=d10n_std(i)/d10n_mean(i);
        
        ss4(i,:)=[cft p4];
        ss6(i,:)=[cft p6];
        ss8(i,:)=[cft p8];
        ss10(i,:)=[cft p10];        
        
    end    






clear a;

T=300;
sr=10000;

np=T*sr;

dt=1/sr;

mu=0;
sigma=1;

fn=500;
Q=10;

nt=1000000;

d4=zeros(nt,1);
d8=zeros(nt,1);
peak=zeros(nt,1);

progressbar;
for i=1:nt
    progressbar(i/nt);

    [a] = normrnd(mu,sigma,[np 1]);
    [accel_resp]=sdof_response_engine(fn,Q,a,dt);
    
    peak(i)=max(abs(accel_resp));
    
    c=rainflow(accel_resp);

    cycles=c(:,1);
    amp=c(:,2)/2;
    d4(i)=sum( cycles.*amp.^4 );    
    d8(i)=sum( cycles.*amp.^8 );
end    

progressbar(1);

disp(' ');
fprintf('\n   d4: mean=%7.4g std=%7.4g max=%7.4g min=%7.4g\n',mean(d4),std(d4),max(d4),min(d4));
fprintf('\n   d8: mean=%7.4g std=%7.4g max=%7.4g min=%7.4g\n',mean(d8),std(d8),max(d8),min(d8));
fprintf('\n peak: mean=%7.4g std=%7.4g max=%7.4g min=%7.4g\n',mean(peak),std(peak),max(peak),min(peak));

figure(1);
histogram(d4,21);
title('d4');

figure(2);
histogram(d8,21);
title('d8');











clear t;
clear amp;

THM=bike_1;
t=THM(:,1);
amp=THM(:,2);
 
n=length(amp);
dur=THM(n,1)-THM(1,1);
dt=dur/(n-1);

tmin=t(1);
tmax=t(n);

num=1;

for i=1:num
    
end

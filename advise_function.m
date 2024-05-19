
%  advise_function.m  ver 1.0  by Tom Irvine


function[num_seg,time_seg,samples_seg,data,dt,rows]=advise_function(tim)

n=length(tim);

dur=tim(end)-tim(1);

dt=mean(diff(tim));

nj=floor(log2(n));

njt=min([12 nj]);

    num_seg=zeros(njt,1);
   time_seg=zeros(njt,1);
samples_seg=zeros(njt,1);
       data=zeros(njt,5);
       rows=(1:njt);

for i=1:njt
    num_seg(i)=2^(i-1);
    time_seg(i)=dur/num_seg(i);
    samples_seg(i)=floor(n/num_seg(i));
    ddf=1/time_seg(i);
    fprintf(' \t  %d  \t  %d  \t   %6.3f  \t  %6.3f \t %d \n',num_seg(i),samples_seg(i),time_seg(i),ddf,2*num_seg(i));   
    data(i,:)=[num_seg(i),samples_seg(i),time_seg(i),ddf,2*num_seg(i)];
    handles.number(i)=i;
end    

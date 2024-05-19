
clear tt;
clear ss;

fig_num=100;

THM=evalin('base','M1_AC_6309');
[tt,ss,fig_num]=core(THM,fig_num);
M1_AC_6309_RMS=[tt, ss];

THM=evalin('base','M1_AC_6310');
[tt,ss,fig_num]=core(THM,fig_num);
M1_AC_6310_RMS=[tt, ss];

THM=evalin('base','M1_AC_6319');
[tt,ss,fig_num]=core(THM,fig_num);
M1_AC_6319_RMS=[tt, ss];

THM=evalin('base','M1_AC_6320');
[tt,ss,fig_num]=core(THM,fig_num);
M1_AC_6320_RMS=[tt, ss];



function[tt,ss,fig_num]=core(THM,fig_num)

 t=THM(:,1);
 a=THM(:,2);
 
 t=t-t(1);
 t=t-1018-190;


sz=size(THM);

n=sz(1);

num=80;

m=floor(n/num);

tt=zeros((m-1),1);
ss=zeros((m-1),1);

for i=1:m-1
   
    n1=num*(i-1)+1;
    n2=n1+num;
    
    tt(i)=mean(t(n1:n2));
    ss(i)=std(a(n1:n2)); 
    
end

[~,k]=min(abs(tt+10));

tt=tt(k:end);
ss=ss(k:end);


figure(fig_num);
plot(tt,ss);
grid on;
ylabel('Accel (GRMS)');
xlabel('Time (sec)');

fig_num=fig_num+1;

end
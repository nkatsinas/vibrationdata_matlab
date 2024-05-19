
% time_history_envelope.m  ver 1.0  by Tom Irvine


function[envp,envn]=time_history_envelope(t,a,dt,pszcr)

num=length(a);

amean=mean(a);

a=a-amean;


% p2=(2*pi*pszcr)^2;
% [jerk]=differentiate_function(a,dt);
% [jerk]=bessel_filter_core(fc,dt,jerk);
% c=zeros(num,1);
% for i=1:num    
%     q=a(i)^2+jerk(i)^2/p2;
%     c(i)=sqrt(q);
% end
% envp=c;
% envn=-c;

j=1;
k=1;


maxa=max(a);
mina=min(a);

for i=2:(num-1)
    
    if(a(i)>0 && a(i)>=a(i-1) && a(i)>=a(i+1))
        ep(j)=a(i); 
        tp(j)=t(i);
        j=j+1;
    end    
    
    if(a(i)<0 && a(i)<=a(i-1) && a(i)<=a(i+1))
        en(k)=a(i); 
        tn(k)=t(i);
        k=k+1;
    end
    
end



envp=spline(tp,ep,t);
envn=spline(tn,en,t);

for i=1:num
    if(envp(i)>maxa)
        envp(i)=maxa;
    end
end
for i=1:num
    if(envn(i)<mina)
        envn(i)=mina;
    end
end

envp=envp+amean;
envn=envn+amean;



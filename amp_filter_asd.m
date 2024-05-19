clear a;
clear P9_6355_nr;
clear n;

P9_6355_nr=P9_6355;

a=P9_6355(:,2);

n=length(a);

for i=3:n
    if(a(i)<-2400)
        a(i)=(2*a(i-1)+a(i-1))/3;
    end
end

P9_6355_nr(:,2)=a;
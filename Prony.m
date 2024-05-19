    

% FS=get(handles.edit_input_array,'String');

clear THM;
clear t;
clear tt;
clear y;
clear Y;
clear syn;
clear dt;
clear D;
clear d;
clear U;
clear C;
clear A;
clear muhat;
clear phi;
clear a;
clear omegan;
clear q;
clear fn;
clear damp;
clear n;
clear num;
clear k;


disp(' ');
disp(' * * * * * * * * * ');
disp(' ');


tp=2*pi;

FS='drop_ext2';

THM=evalin('base',FS);

t=THM(:,1);
y=THM(:,2);

num=length(t);

dt=(t(num)-t(1))/(num-1)


n=2;


k=1;

for i=(n+1):num
        
%    D(k,:)=[ y(i-1) y(i-2) y(i-3) y(i-4)];
     D(k,:)=[ y(i-1) y(i-2) ];

    d(k)=y(i);
    
    k=k+1;
    
end 

size(D)
size(d)

a=pinv(D)*d'

muhat=roots([1;-a])


Y=y;

% U(1,:)=[1 1 1 1];

for i=2:num
%     U(i,:)=[muhat(1) muhat(2) muhat(3) muhat(4)];
     U(i,:)=[muhat(1) muhat(2)];
end

C=pinv(U)*Y


%%%%%%%%%%

for i=1:n
    q(i)=log(muhat(i))/dt;
    omegan(i)=abs(imag(q(i)));
    fn(i)=omegan(i)/tp;
    damp(i)=abs(real(q(i))/(2*omegan(i))); 
    
    out1=sprintf(' fn=%8.4g Hz  damp=%8.4g',fn(i),damp(i));
    disp(out1);
    
end




%    
%    f(t)=exp(-damp*omega*t)*(A*cos(omega*t) + B*sin(omega*t));
%

td=t-t(1);

[A,B]=damped_sine_lsf_function_prony(Y,td,omegan(1),damp(1));



for i=1:num
   tt=t(i)-t(1);  
   syn(i)=exp(-damp(1)*omegan(1)*tt)*(A*cos(omegan(1)*tt) + B*sin(omegan(1)*tt));
end

disp(' ref 4');

%%%%%%%%%%

clear xlabel;

figure(1)
plot(t,y,t-dt,syn);
grid on;
ylabel('Accel (G)');
xlabel('Time (sec)');













%
a=[0 3; 1 1; 2 4];
b=[ 0 -1; 1 2; 2 3];
%
figure(2)
hold on;
plot(a(:,1),a(:,2),'r','DisplayName','Curve A');  % r=red 
plot(b(:,1),b(:,2),'b','DisplayName','Curve B');  % b=blue
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Time History');
grid on;
legend show;
hold off;
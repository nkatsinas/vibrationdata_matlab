%
%   2D array with 3 rows and 2 columns
%
%   Use semicolon to separate rows
%
a=[0 3; 1 1; 2 4];
%
%
%   a(:,1)  is the first column
%   a(:,2)  is the second column
%
figure(1);
plot(a(:,1),a(:,2));
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Time History');
grid on;
%
%   Double the second column and replot
%
a(:,2)=2*a(:,2);
%
figure(2);
plot(a(:,1),a(:,2));
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Time History, Double');
grid on;
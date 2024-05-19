%
%   add_time_column.m  ver 1.0  by Tom Irvine
%

clear aaa;
clear ttt;

disp(' ');
disp(' Enter time step (sec)');
dt=input(' ');
%
aaa = input(' Enter the array name:  ');
%
L=length(aaa);
%
ttt=zeros(L,1);

for i=1:L
    ttt(i)=(i-1)*dt;
end

disp(' ');
disp(' data save as new_array');

new_array=[ttt aaa];
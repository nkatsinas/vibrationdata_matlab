%
%  subplots_two_linlin_scale.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_two_linlin_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2)

figure(fig_num);

subplot(2,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
yabs=max(abs( data1(:,2) ));
[ymax1]=ytick_linear_scale(yabs);


%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
grid on;
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
yabs=max(abs( data2(:,2) ));
[ymax2]=ytick_linear_scale(yabs);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ymax=max([ymax1 ymax2]);

subplot(2,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string1);
ylim([-ymax,ymax]);


%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
grid on;
xlabel(xlabel2);
ylabel(ylabel2)
title(t_string2);
ylim([-ymax,ymax]);


fig_num=fig_num+1;
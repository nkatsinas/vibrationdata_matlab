
% subplots_linlin_2x2.m  ver 1.1 by Tom Irvine

function[fig_num]=subplots_linlin_2x2(fig_num,x_label,...
               y_label,t_string11,t_string12,t_string21,t_string22,...
                                                   ppp11,ppp12,ppp21,ppp22)

   
hp=figure(fig_num);
fig_num=fig_num+1;

%

subplot(2,2,1);
plot(ppp11(:,1),ppp11(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string11);
grid on;

%

subplot(2,2,2);
plot(ppp12(:,1),ppp12(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string12);
grid on;

%

subplot(2,2,3);
plot(ppp21(:,1),ppp21(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string21);
grid on;

%

subplot(2,2,4);
plot(ppp22(:,1),ppp22(:,2));
ylabel(y_label);
xlabel(x_label);
title(t_string22);
grid on;

%

set(hp, 'Position', [0 0 1000 700]);

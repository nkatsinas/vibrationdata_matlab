%
%  subplots_two_linlin.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_two_linlin(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string)


try
    close fig_num;
end
try
    close fig_num hidden;
end

figure(fig_num);

subplot(2,1,1);
plot(data1(:,1),data1(:,2));
grid on;
ylabel(ylabel1);
title(t_string);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);


%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
grid on;
xlabel(xlabel2);
ylabel(ylabel2);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);

fig_num=fig_num+1;
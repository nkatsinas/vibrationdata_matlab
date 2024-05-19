%
%  subplots_two_linlin_f.m  ver 1.0  by Tom Irvine
%

function[fig_num]=subplots_two_linlin_f(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string,fmin,fmax)

figure(fig_num);

f=data1(:,1);

[c j] = min(abs(f-fmin));

[c k] = min(abs(f-fmax));


subplot(2,1,1);
plot(data1(j:k,1),data1(j:k,2));
grid on;
ylabel(ylabel1);
title(t_string);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);
xlim([fmin,fmax]);


%
subplot(2,1,2);
plot(data2(j:k,1),data2(j:k,2));
grid on;
xlabel(xlabel2);
ylabel(ylabel2);
qqq=get(gca,'ylim');
qmax=max(abs(qqq));
ylim([-qmax,qmax]);
xlim([fmin,fmax]);

fig_num=fig_num+1;
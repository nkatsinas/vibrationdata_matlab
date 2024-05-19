%
%  subplots_two_linlin_two_titles_scale_same.m  ver 1.2  by Tom Irvine
%

function[fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2)


try
    close fig_num;
end
try
    close fig_num hidden;
end


hp=figure(fig_num);


subplot(2,1,1);
plot(data1(:,1),data1(:,2));
ylabel(ylabel1);
title(t_string1);

yabs=max(abs(data1(:,2)));
[ymax1]=ytick_linear_scale(yabs);
ylim([-ymax1,ymax1]);
grid on;
x1=xlim;

%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);

yabs=max(abs(data2(:,2)));
[ymax2]=ytick_linear_scale(yabs);
ylim([-ymax2,ymax2]);
grid on;
x2=xlim;

xmin=min([x1(1) x2(1)]);
xmax=min([x1(2) x2(2)]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ymax=max([ymax1 ymax2]);


subplot(2,1,1);
plot(data1(:,1),data1(:,2));
ylabel(ylabel1);
title(t_string1);
ylim([-ymax,ymax]);
xlim([xmin xmax]);
grid on;

%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
ylim([-ymax,ymax]);
xlim([xmin xmax]);
grid on;


set(hp, 'Position', [0 0 750 500]);

fig_num=fig_num+1;
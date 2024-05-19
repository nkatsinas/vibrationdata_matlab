%
%  subplots_two_linlin_two_titles_scale.m  ver 1.1  by Tom Irvine
%

function[fig_num]=subplots_two_linlin_two_titles_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2)


try
    close fig_num;
end
try
    close fig_num hidden;
end

aa=max(abs(data1(:,2)));
bb=max(abs(data2(:,2)));

yabs=max([ aa bb   ]);
ymax=yabs;

[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);


h=figure(fig_num);


subplot(2,1,1);
plot(data1(:,1),data1(:,2));
ylabel(ylabel1);
title(t_string1);
ylim([-ymax,ymax]);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'yTickLabel',yTT);
end


grid on;

%
subplot(2,1,2);
plot(data2(:,1),data2(:,2));
xlabel(xlabel2);
ylabel(ylabel2);
title(t_string2);
ylim([-ymax,ymax]);
if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'yTickLabel',yTT);
end

grid on;

set(h, 'Position', [0 0 700 650]);

fig_num=fig_num+1;
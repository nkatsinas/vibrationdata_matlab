
% plot_time_history_histogram_peak.m  ver 1.0  by Tom Irvine

function[fig_num]=plot_time_history_histogram_peak(fig_num,THM,t_string,x_label,y_label,nbars)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num)
plot(THM(:,1),THM(:,2));

[xq]=get(gca,'ylim');
xx=max(abs(xq));
x=linspace(0,xx,nbars);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num)
[ii,jj]=hist(THM(:,2),x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(fig_num);
subplot(1,3,3);

hmax=max(ii);
N=floor(log10(hmax));

if(hmax>=1000)
    M=10^N;
    bar(jj,ii/M,1);
    yyss=sprintf('Counts x 10^{%d}',N);
    ylabel(yyss);
else
    bar(jj,ii,1);
    ylabel('Counts');    
end


title('Peak Histogram');
xlabel(y_label);
xlim([0,xx]);
ytickformat('%g')
set(gca,'view',[90 -90])

qq=get(gca,'xlim');

subplot(1,3,[1 2]),
plot(THM(:,1),THM(:,2));
title(t_string);
xlabel(x_label)
ylabel(y_label)
ylim([qq(1),qq(2)]);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=fig_num+1;
set(hp, 'Position', [0 0 850 450]);
        
% print(hp,'thist2','-dsvg');   % takes too long 


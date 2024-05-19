

%  plot_two_time_histories_histograms.m  ver 1.1  by Tom Irvine

function[fig_num]=plot_two_time_histories_histograms(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2,nbars)

if(nbars>100)
    nbars=100;
end

%%%

figure(fig_num)
plot(data1(:,1),data1(:,2));
[x1]=get(gca,'ylim');

%%%

figure(fig_num)
plot(data2(:,1),data2(:,2));
[x2]=get(gca,'ylim');



%%%

figure(fig_num)
xx=max(abs(x1));
x=linspace(-xx,xx,nbars);
[ii1,jj1]=hist(data1(:,2),x);
hmax=max(ii1);
N=floor(log10(hmax));
M=10^N;

%%%

figure(fig_num)
xx=max(abs(x2));
x=linspace(-xx,xx,nbars);
[ii2,jj2]=hist(data2(:,2),x);
yabs=max([ max(abs(ii1))  max(abs(ii2)) ]);

m1=max(abs(x1));
m2=max(abs(x2));

xxa=max([ m1 m2  ]);

n1=max(abs(data1(:,2)));
n2=max(abs(data2(:,2)));
yq=max([ n1 n2  ]);

[yy]=ytick_linear_altp(yq);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(fig_num);

subplot(2,3,3);

if(hmax>=1000)
    bar(jj1,ii1/M,1);
    yyss=sprintf('Counts x 10^{%d}',N);
    ylabel(yyss);
    
    [ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs/M);

    yym=ymax;
    
    if(iflag==1)
        set(gca,'ytick',ytt);
        set(gca,'YTickLabel',yTT);
        ylim([min(ytt),max(ytt)]);
    end
    ylim([0,yym]);
else
    bar(jj1,ii1,1);
    ylabel('Counts');    
end

title('Input Histogram');
xlabel(ylabel1);
xlim([-yy,yy]);
ytickformat('%g')
grid on;
set(gca,'view',[90 -90]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,3,6);

if(hmax>=1000)
    bar(jj2,ii2/M,1);
    yyss=sprintf('Counts x 10^{%d}',N);
    ylabel(yyss);
    
    if(iflag==1)
        set(gca,'ytick',ytt);
        set(gca,'YTickLabel',yTT);
        ylim([min(ytt),max(ytt)]);
    end    
    ylim([0,yym]);
else
    bar(jj2,ii2,1);
    ylabel('Counts');    
end

title('Response Histogram');
xlabel(ylabel2);
xlim([-yy,yy]);
ytickformat('%g')
grid on;
set(gca,'view',[90 -90])
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,3,[1 2]);
plot(data1(:,1),data1(:,2));
ylim([-yy,yy]);
title(t_string1);
xlabel(xlabel2);
ylabel(ylabel1);
grid on;

%%%

subplot(2,3,[4 5]);
plot(data2(:,1),data2(:,2));
ylim([-yy,yy]);
title(t_string2);
xlabel(xlabel2);
ylabel(ylabel2);
grid on;

%%%

set(hp, 'Position', [0 0 800 650]);

fig_num=fig_num+1;

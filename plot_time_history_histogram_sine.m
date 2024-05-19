
% plot_time_history_histogram_sine.m  ver 1.3  by Tom Irvine

function[fig_num]=plot_time_history_histogram_sine(fig_num,THM,t_string,x_label,y_label,nbars)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yabs=max(abs(THM(:,2)));

[ymax,yTT,ytt,iflag]=ytick_linear_double_sided(yabs);

[mu,sd,rms,sk,kt]=kurtosis_stats(THM(:,2));

figure(fig_num)
plot(THM(:,1),THM(:,2));

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

[xq]=get(gca,'ylim');
xx=max(abs(xq));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num)
% [ii,jj]=hist(THM(:,2),x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(fig_num);
subplot(1,3,3);

Amax=max(abs(THM(:,2)));

nn=nbars;
nn1=nn-1;

edges=(1:nn1)-nn/2;
edges=edges*Amax/max(abs(edges));


try
    histogram(THM(:,2),'BinEdges',edges); sorts X into bins with bin edges specified in a vector.
    

    % histogram(THM(:,2),nbars);

catch
end


try

    set(gca,'view',[90 -90])

    ttt=sprintf('Histogram \n skewness=%5.3f  kurtosis=%5.2f',sk,kt);
    
    title(ttt);

    grid on;
    ylabel('Counts');

    xlabel(y_label);
    xlim([-xx,xx]);

    try
        ytickformat('%g')
    catch
    end

    qq=get(gca,'xlim');
catch
    disp('Histogram plot failed')
    return
end

try

    subplot(1,3,[1 2]),
    plot(THM(:,1),THM(:,2));
    title(t_string);
    xlabel(x_label)
    ylabel(y_label)
    ylim([qq(1),qq(2)]);
    grid on;
    
catch
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=fig_num+1;
set(hp, 'Position', [0 0 1200 450]);
        
% print(hp,'thist2','-dsvg');    


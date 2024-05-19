%
%   psd_plot_all_alt.m  ver 1.7  by Tom Irvine
%
function[fig_num]=psd_plot_all_alt(fig_num,t_string,ppp,leg,ylab)
%

sz=size(ppp);

f=ppp(:,1);
amp=ppp(:,2:sz(2));

sz=size(amp);

%

hp=figure(fig_num);
%
hold on;


for i=1:sz(2)
    if(i==1)
        try
            plot(f,amp(:,i),'DisplayName',char(leg(i)),'LineWidth',2);
        catch
            try
                plot(f,amp(:,i),'DisplayName',leg{i},'LineWidth',2);            
            catch
            end
        end
    else
        try
            plot(f,amp(:,i),'DisplayName',char(leg(i)));
        catch
            try
                plot(f,amp(:,i),'DisplayName',leg{i});            
            catch
            end
        end
    end
end

legend show;

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log')
grid on;
  
title(t_string)
xlabel('Frequency (Hz)');
ylabel(ylab);

fmin=min(f);
fmax=max(f);


if(fmin>20)
    fmin=20;
end

%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
end

md=5;
upper=max(max(ppp(:,2:end)));
lower=min(min(ppp(:,2:end)));
[ymax,ymin]=ymax_ymin_md(upper,lower,md);


try
    ylim([ymin,ymax]);
catch
end


%
grid on;
set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')

xlim([fmin,fmax]);

fig_num=fig_num+1;

legend show;
    
legend('location','eastoutside')
set(hp, 'Position', [0 0 900 550]);
set(gca,'Fontsize',10.5);
    

hold off;


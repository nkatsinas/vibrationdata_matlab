%
%   spl_plot_all.m  ver 1.7  by Tom Irvine
%
function[fig_num]=spl_plot_all_alt(fig_num,t_string,ppp,leg)
%

sz=size(ppp);

f=ppp(:,1);
dB=ppp(:,2:sz(2));

sz=size(dB);

%

hp=figure(fig_num);
%
hold on;


for i=1:sz(2)
    if(i==1)
        try
            plot(f,dB(:,i),'DisplayName',char(leg(i)),'LineWidth',2);
        catch
            try
                plot(f,dB(:,i),'DisplayName',leg{i},'LineWidth',2);            
            catch
            end
        end
    else
        try
            plot(f,dB(:,i),'DisplayName',char(leg(i)));
        catch
            try
                plot(f,dB(:,i),'DisplayName',leg{i});            
            catch
            end
        end
    end
end

legend show;

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
  
title(t_string)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

fmin=min(f);
fmax=max(f);

% yy=get(gca,'ylim');

ymin=min(min((dB)));
ymax=max(max((dB)));

for i=0:10:250
    if(ymax<i)
        ymax=i;
        break;
    end
end
for i=0:10:200
    if(ymin<i)
        ymin=i-10;
        break;
    end
end



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


%
grid on;
set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')

axis([fmin,fmax,ymin,ymax]);

fig_num=fig_num+1;

legend show;
    
legend('location','eastoutside')
set(hp, 'Position', [0 0 900 550]);
set(gca,'Fontsize',10.5);
    

hold off;


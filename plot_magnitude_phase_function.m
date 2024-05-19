%
%   plot_magnitude_phase_function.m  ver 1.3  by Tom Irvine
%
function[fig_num]=...
    plot_magnitude_phase_function(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md)
%



[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    fmin=min(xtt);
    fmax=max(xtt);
end



hp=figure(fig_num);
fig_num=fig_num+1;
%
subplot(3,1,1);
plot(ff,FRF_p);
title(t_string);
grid on;
ylabel('Phase (deg)');
%
%%%%%%
%
ylim([-180,180]);
    
if(iflag==1)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0,90,180],'xtick',xtt,'XTickLabel',xTT);  
else

    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);    
end
%
%%%%%%
%
if(max(FRF_p)<=0.)
%
   ylim([-180,0]);
%
  if(iflag==1)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0],'xtick',xtt,'XTickLabel',xTT);
  else
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0]);    
  end
end  
%
if(min(FRF_p)>=-90. && max(FRF_p)<90.)
%
    ylim([-90,90]);
    
    if(iflag==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-90,0,90],'xtick',xtt,'XTickLabel',xTT);
    else
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-90,0,90]);        
    end
end 
%
if(min(FRF_p)>=0.)
%
    ylim([0,180]);
    
    if(iflag==1)    
    
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[0,90,180],'xtick',xtt,'XTickLabel',xTT);
    else
     
        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[0,90,180]);       
    end    
end 


try
    xlim([fmin,fmax]);
catch    
end


%
subplot(3,1,[2 3]);
plot(ff,FRF_m);
grid on;
xlabel('Frequency(Hz)');
ylabel(ylab);


[~,index1] = min(abs(ff-fmin));
[~,index2] = min(abs(ff-fmax));

ymin=min(FRF_m(index1:index2));
ymax=max(FRF_m(index1:index2));

NN=10^md;

ymax=10^(ceil(log10(ymax)));

if(ymin<ymax/NN)
    ymin=ymax/NN;
end

[ytt,yTT,iflag]=ytick_label(ymin,ymax);


if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end



if(iflag==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off','xtick',xtt,'XTickLabel',xTT);
else
    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');    
end

%

try
    xlim([fmin,fmax]);
catch    
end

set(hp, 'Position', [0 0 550 550]);
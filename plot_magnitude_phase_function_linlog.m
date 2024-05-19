%
%   plot_magnitude_phase_function_linlog.m  ver 1.1  by Tom Irvine
%
function[fig_num]=...
    plot_magnitude_phase_function_linlog(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md)
%


[c,j] = min(abs(ff-fmin));

[c,k] = min(abs(ff-fmax));



figure(fig_num);
fig_num=fig_num+1;
%
subplot(3,1,1);
plot(ff(j:k),FRF_p(j:k));
title(t_string);
grid on;
ylabel('Phase (deg)');
%
%%%%%%
%
ylim([-180,180]);
    


    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','linear',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);    

%%%%%%
%
if(max(FRF_p)<=0.)
%
   ylim([-180,0]);
%

    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','linear',...
                    'YScale','lin','ytick',[-180,-90,0]);    

end  
%
if(min(FRF_p)>=-90. && max(FRF_p)<90.)
%
    ylim([-90,90]);
    

        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','linear',...
                    'YScale','lin','ytick',[-90,0,90]);        

end 
%
if(min(FRF_p)>=0. && max(FRF_p)< 180)
%
    ylim([0,180]);

        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','linear',...
                    'YScale','lin','ytick',[0,90,180]);       
  
end 

if(min(FRF_p)>=0. && max(FRF_p)>= 180)
%
    ylim([0,360]);

        set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','linear',...
                    'YScale','lin','ytick',[0,90,180,270,360]);       
  
end 


try
    xlim([fmin,fmax]);
catch    
end


%
subplot(3,1,[2 3]);
plot(ff(j:k),FRF_m(j:k));
grid on;
xlabel('Frequency(Hz)');
ylabel(ylab);

max_amp=max(FRF_m(j:k));
min_amp=min(FRF_m(j:k));


[ymax,ymin]=ymax_ymin_md(max_amp,min_amp,md);

ylim([ymin,ymax]);


    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','linear',...
                     'YScale','log','XminorTick','off','YminorTick','off');    


%

try
    xlim([fmin,fmax]);
catch    
end
%
%   plot_magnitude_phase_function_linear.m  ver 1.1  by Tom Irvine
%
function[fig_num]=...
    plot_magnitude_phase_function_linear(fig_num,t_string,fmin,fmax,ff,FRF_p,FRF_m,ylab,md)
%

md=4;

figure(fig_num);
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
    


    set(gca,'XScale','linear',...
                    'YScale','lin','ytick',[-180,-90,0,90,180]);    

%%%%%%
%
if(max(FRF_p)<=0.)
%
   ylim([-180,0]);
%

    set(gca,'XScale','linear',...
                    'YScale','lin','ytick',[-180,-90,0]);    

end  
%
if(min(FRF_p)>=-90. && max(FRF_p)<90.)
%
    ylim([-90,90]);
    

        set(gca,'XScale','linear',...
                    'YScale','lin','ytick',[-90,0,90]);        

end 
%
if(min(FRF_p)>=0. && max(FRF_p)< 180)
%
    ylim([0,180]);

        set(gca,'XScale','linear',...
                    'YScale','lin','ytick',[0,90,180]);       
  
end 

if(min(FRF_p)>=0. && max(FRF_p)>= 180)
%
    ylim([0,360]);

        set(gca,'XScale','linear',...
                    'YScale','lin','ytick',[0,90,180,270,360]);       
  
end 

grid on;


try
    xlim([fmin,fmax]);
catch    
end



[~,j] = min(abs(ff-fmin));
[~,k] = min(abs(ff-fmax));

%
subplot(3,1,[2 3]);
plot(ff(j:k),FRF_m(j:k));
grid on;
xlabel('Frequency(Hz)');
ylabel(ylab);

yabs=max(FRF_m(j:k));

[ymax,yTT,ytt,iflag]=ytick_linear_one_sided(yabs);
ylim([0 ymax]);



%    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','linear',...
%                     'YScale','linear','XminorTick','off','YminorTick','off');    


%

try
    xlim([fmin,fmax]);
catch    
end
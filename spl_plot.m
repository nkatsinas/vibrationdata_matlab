%
%   spl_plot.m  ver 1.8  by Tom Irvine
%
%   Sound Pressure Level Plot
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%     fig_num = figure number
%
%     n_type = 1 for one-third octave bands
%            = 2 for full octave bands
%
%     f = frequency (Hz)
%    dB = dB level
%      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%     fig_num = figure number plus 1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions
%
%     oaspl_function.m
%     dB_ylimits.m
%     xtick_label.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[fig_num]=spl_plot(fig_num,n_type,f,dB)
%
[oadb]=oaspl_function(dB);
%
fprintf('\n Overall Sound Pressure Level = %8.4g dB \n',oadb);

disp('  ');
disp(' zero dB Reference = 20 micro Pascal ');
disp('  ');
%
figure(fig_num);
%
plot(f,dB);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
if(n_type==1)
    out1=sprintf(' One-Third Octave Sound Pressure Level \n OASPL = %8.4g dB  Ref: 20 micro Pa ',oadb);
else
    out1=sprintf(' Full Octave Sound Pressure Level \n OASPL = %8.4g dB  Ref: 20 micro Pa ',oadb);    
end    
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

fmin=min(f);
fmax=max(f);

[ymin,ymax]=dB_ylimits(dB);


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
%
axis([fmin,fmax,ymin,ymax]);

fig_num=fig_num+1;

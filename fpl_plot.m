%
%   fpl_plot.m  ver 1.6  by Tom Irvine
%
function[fig_num]=fpl_plot(fig_num,n_type,f,dB)
%
[oadb]=oaspl_function(dB);
%
out1=sprintf('\n Overall Fluctating Pressure Level = %8.4g dB',oadb);
disp(out1)
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
    out1=sprintf(' One-Third Octave Fluctating Pressure Level \n OAFPL = %8.4g dB  Ref: 20 micro Pa ',oadb);
else
    out1=sprintf(' Full Octave Fluctating Pressure Level \n OAFPL = %8.4g dB  Ref: 20 micro Pa ',oadb);    
end    
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' FPL (dB) ');

fmin=min(f);
fmax=max(f);

% yy=get(gca,'ylim');

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
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');
%
axis([fmin,fmax,ymin,ymax]);

fig_num=fig_num+1;

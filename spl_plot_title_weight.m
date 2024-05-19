%
%   spl_plot_title_weight.m  ver 1.7  by Tom Irvine
%
function[fig_num]=spl_plot_title_weight(fig_num,n_type,f,dB,tstring,ns)
%

tstring=strrep(tstring,'_',' ');

[oadb]=oaspl_function(dB);
%
if(ns==1)
    ss='A';
end
if(ns==2)
    ss='B';
end
if(ns==3)
    ss='C';
end


out1=sprintf('\n Overall Sound Pressure Level = %8.4g dB%s',oadb,ss);

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
    out1=sprintf(' One-Third Octave  SPL %s \n OASPL = %8.4g dB%s  Ref: 20 micro Pa ',tstring,oadb,ss);
else
    out1=sprintf(' Full Octave SPL  %s \n OASPL = %8.4g dB%s  Ref: 20 micro Pa ',tstring,oadb,ss);    
end    
title(out1)
xlabel(' Center Frequency (Hz) ');

out1=sprintf('SPL (dB%s)',ss);
ylabel(out1);

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
    xtt;
end


%
grid on;
set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');
%
axis([fmin,fmax,ymin,ymax]);

fig_num=fig_num+1;

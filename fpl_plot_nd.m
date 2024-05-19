%
%   fpl_plot_nd.m  ver 1.6  by Tom Irvine
%
function[fig_num]=fpl_plot_nd(fig_num,n_type,f,dB)
%
[oadb]=oaspl_function(dB);

%
figure(fig_num);
%
plot(f,dB);
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','lin')
grid on;
if(n_type==1)
    out1=sprintf(' One-Third Octave Fluctuating Pressure Level \n OAFPL = %8.4g dB  Ref: 20 micro Pa ',oadb);
else
    out1=sprintf(' Full Octave Fluctuating Pressure Level \n OAFPL = %8.4g dB  Ref: 20 micro Pa ',oadb);    
end    
title(out1)
xlabel(' Center Frequency (Hz) ');
ylabel(' FPL (dB) ');

fmin=min(f);
fmax=max(f);

% yy=get(gca,'ylim');

ymin=min(dB);
ymax=max(dB);

for i=0:5:250
    if(ymax<i)
        ymax=i;
        break;
    end
end
for i=0:5:200
    if(ymin<i)
        ymin=i-5;
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
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');
%
axis([fmin,fmax,ymin,ymax]);

fig_num=fig_num+1;

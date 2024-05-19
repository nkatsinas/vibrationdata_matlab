%
%   srs_plot_function_spec_h.m  ver 1.3  by Tom Irvine
%
function[fig_num,h]=...
       srs_plot_function_spec_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax,srs_spec,tol)
%

fr=srs_spec(:,1);
r=srs_spec(:,2);

scale=10^(tol/20);
tola=srs_spec(:,2)*scale;
tolb=srs_spec(:,2)/scale;

sss=sprintf('spec & %g dB tol',tol);

h=figure(fig_num);
fig_num=fig_num+1;
plot(fn,a_pos,'b',fn,a_neg,'r',fr,r,'k',fr,tola,'k',fr,tolb,'k');
legend('positive','negative',sss);
title(t_string);
xlabel('Natural Frequency (Hz)');
ylabel(y_lab);
%
[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmax=max(xtt);
    fmin=min(xtt);
end


%
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log',...
                     'YScale','log','XminorTick','off','YminorTick','off');
%

yymax=max([ max(a_pos) max(a_neg) ]);
%%% yymin=min([ min(a_pos) min(a_neg) ]);


yymin=1.0e+20;

for i=1:length(fn)
    if(a_pos(i)<yymin && a_pos(i)>1.0e-10)
        yymin=a_pos(i);
    end
    if(a_neg(i)<yymin && a_neg(i)>1.0e-10)
        yymin=a_neg(i);
    end
end

    
ymin=10^(floor(log10(yymin)));
ymax=10^(ceil(log10(yymax)));

if( (yymax/ymax) >0.4)
    ymax=ymax*10;
end

xlim([fmin fmax]);
ylim([ymin ymax]);
%
grid on;

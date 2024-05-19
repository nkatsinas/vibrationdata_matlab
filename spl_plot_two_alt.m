%
%   spl_plot_two_alt.m  ver 1.6  by Tom Irvine
%
function[fig_num]=spl_plot_two_alt(fig_num,n_type,f1,dB1,f2,dB2,string_1,string_2)
%
[oaspl_1]=oaspl_function(dB1);

[oaspl_2]=oaspl_function(dB2);
%


disp(' ');
disp(' Overall Sound Pressure Levels (ref = 20 micro Pascal) ');
out1=sprintf('\n %s = %8.4g dB',string_1,oaspl_1);
disp(out1)
out1=sprintf('  %s = %8.4g dB \n',string_2,oaspl_2);
disp(out1)

string_1=sprintf('%s ',string_1);
string_2=sprintf('%s, %6.4g dB oaspl',string_2,oaspl_2);

figure(fig_num);
%
plot(f1,dB1,f2,dB2);

legend(string_1,string_2);  

grid on;
if(n_type==1)
    disp(' One-Third Octave Sound Pressure Level  Ref: 20 micro Pa ');
else
    disp(' Full Octave Sound Pressure Level  Ref: 20 micro Pa ');    
end    

title('Sound Pressure Level  Ref: 20 micro Pa');
xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

%

fmin=min([ min(f1) min(f2)]);
fmax=max([ max(f1) max(f2)]);

yy=get(gca,'ylim');

ymin=min(yy);
ymax=max(yy)+10;  % extra for legend

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
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
xlim([fmin,fmax]);

fig_num=fig_num+1;

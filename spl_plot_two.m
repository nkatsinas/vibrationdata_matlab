%
%   spl_plot_two.m  ver 1.8  by Tom Irvine
%
function[fig_num]=spl_plot_two(fig_num,n_type,f1,dB1,f2,dB2,leg1,leg2)
%
[oaspl_1]=oaspl_function(dB1);

[oaspl_2]=oaspl_function(dB2);
%


disp(' ');
disp(' Overall Sound Pressure Levels (ref = 20 micro Pascal) ');
out1=sprintf('\n %s = %8.4g dB',leg1,oaspl_1);
disp(out1)
out1=sprintf('  %s = %8.4g dB \n',leg2,oaspl_2);
disp(out1)

leg1=sprintf('%s  oaspl %6.4g dB',leg1,oaspl_1);
leg2=sprintf('%s  oaspl %6.4g dB',leg2,oaspl_2);

figure(fig_num);
%
plot(f1,dB1,f2,dB2);

legend(leg1,leg2);  

grid on;
if(n_type==1)
    disp(' One-Third Octave Sound Pressure Level  Ref: 20 micro Pa ');
    title('One-Third Octave Sound Pressure Level  Ref: 20 micro Pa');
else
    disp(' Full Octave Sound Pressure Level  Ref: 20 micro Pa ');
    title('Full Octave Sound Pressure Level  Ref: 20 micro Pa');
end    


xlabel(' Center Frequency (Hz) ');
ylabel(' SPL (dB) ');

%

fmin=max([ min(f1) min(f2)]);
fmax=max([ max(f1) max(f2)]);

ymin=min([ min(dB1) min(dB2)  ]);
ymax=max([ max(dB1) max(dB2)  ]);

ymax=ymax+10;

if(ymin<ymax-75)
    ymin=ymax-75;
end    

if(fmin>20)
    fmin=20;
end


[ytt,yTT,iflag]=ytick_label_spl(ymin,ymax);

if(iflag==1)
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ymin=min(ytt);
    ymax=max(ytt);    
end

%%  iflag
%%  ymin
%%  ymax


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
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
%
%
axis([fmin,fmax,ymin,ymax]);

fig_num=fig_num+1;
